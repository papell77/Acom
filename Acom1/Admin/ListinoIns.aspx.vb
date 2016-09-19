Imports Acom1.BLL
Imports Acom1.Models
Imports Acom1.DAL
Imports System.Web.ModelBinding
Imports Microsoft.AspNet.Identity
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.IO
Imports System.Globalization
Imports System.Data.Entity.Infrastructure
Imports OfficeOpenXml


Public Class ListinoIns
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim code As String = Request.QueryString("code")
        Dim data As String = Request.QueryString("data")

        'se sono in postback (ho cliccato su NUOVO) allora resto in modalità inserimento
        If Not Page.IsPostBack Then
            If Not String.IsNullOrEmpty(code) Or Not String.IsNullOrEmpty(data) Then
                DetailsViewPrice.ChangeMode(DetailsViewMode.ReadOnly)
            End If
        End If

    End Sub

    Protected Sub calext_datadecorrenza_Load(sender As Object, e As EventArgs)
        'determino il primo giorno dell'anno in corso come data di default per la decorrenza del nuovo articolo che vado ad inserire
        Dim anno As Integer = Year(Now())
        Dim giorno As Date = DateValue("01/01/" & anno)
        Dim calend As AjaxControlToolkit.CalendarExtender = DetailsViewPrice.FindControl("calext_datadecorrenza")
        calend.SelectedDate = giorno
    End Sub

    Public Sub DetailsViewPrice_InsertItem()

        Dim context As New AcomContext
        Dim item As New Acom1.Models.pricelist
        Dim prod As DropDownList = DetailsViewPrice.FindControl("productID")
        Dim fam As DropDownList = DetailsViewPrice.FindControl("familyID")

        If item Is Nothing Then
            ModelState.AddModelError("", "Nessun elemento inserito")
            Return
        Else
            If Not prod.SelectedValue = "" Then
                item.productID = prod.SelectedValue
            End If
            If Not fam.SelectedValue = "" Then
                item.familyID = fam.SelectedValue
            End If
            item.created_by = User.Identity.Name
            item.created_date = Today
            context.pricelists.Add(item)
        End If


        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                context.SaveChanges()
                Response.Redirect("~/Admin/ListinoIns?&code=" & item.article_code & "&data=" & item.data_decorrenza)
            Catch ex As System.Data.Entity.Infrastructure.DbUpdateException
                error_msg.Text = "Attenzione il codice " & item.article_code & " è già utilizzato per il listino con decorrenza " & item.data_decorrenza
                error_msg.Visible = True
            End Try

        End If


    End Sub

    Public Function Get_products()
        Return BLL.Get_products
    End Function

    Public Function Get_families()
        Return BLL.Get_families
    End Function

    ' Il parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    ' o essere decorato con un attributo del provider di valori, ad esempio <QueryString>ByVal id as Integer
    Public Function DetailsViewPrice_GetItem(<QueryString("code")> article_code As String, <QueryString("data")> data_decorrenza As String) As Acom1.Models.pricelist

        If String.IsNullOrEmpty(article_code) Or String.IsNullOrEmpty(data_decorrenza) Then
            Return Nothing
        End If

        Dim context As New AcomContext
        'Dim query = context.pricelists.SqlQuery("SELECT * FROM dbo.pricelists WHERE article_code=@p0 and data_decorrenza=@p1", article_code, data_decorrenza).Single
        Dim query = context.pricelists.Where(Function(p) p.article_code = article_code And p.data_decorrenza = data_decorrenza).Single

        Return query
    End Function

    Protected Sub btn_import_Click(sender As Object, e As EventArgs)

        Dim filename As String
        Dim sheet As String
        Dim data_decorr As Date
        Dim doublerows As IEnumerable(Of String) = Nothing

        If upload_excel.HasFile = False Then
            upload_error.Text = "Nessun file selezionato per l'importazione"
            upload_place_error.Visible = True
            Return
        Else
            If Path.GetExtension(upload_excel.PostedFile.FileName) = ".xlsx" Then
                If upload_excel.PostedFile.ContentLength < 1024000 Then 'file inferiore a 1Mb
                    If upload_excel.PostedFile.FileName.StartsWith("listino", True, CultureInfo.CurrentCulture) Then 'nome file deve cominciare con listino, non case-sensitive
                        'logica di upload
                        Try
                            filename = upload_excel.PostedFile.FileName
                            sheet = "Listino"
                            data_decorr = decorrenza.Text
                            Dim dt As New DataTable

                            'importo i dati da excel usando EPPlus
                            Dim package As New ExcelPackage(upload_excel.FileContent)
                            Try
                                dt = BLL.ImportExcelEPPlus(package, sheet, data_decorr, User.Identity.Name)
                            Catch ex As Exception
                                upload_error.Text = "Importazione fallita"
                                exc_detail.Text = ex.Message
                                upload_place_error.Visible = True
                                Return
                            End Try

                            Try
                                doublerows = dt.AsEnumerable.GroupBy(Function(p) p.Field(Of String)("CodArticolo")).Where(Function(g) g.Count() > 1).Select(Function(g) g.Key)
                                GridDouble.DataSource = doublerows
                                GridDouble.DataBind()
                            Catch ex As Exception
                                upload_error.Text = "Importazione fallita"
                                exc_detail.Text = ex.Message
                                upload_place_error.Visible = True
                                Return
                            End Try

                            If GridDouble.Rows.Count > 0 Then 'sono presenti codici duplicati
                                'LabelDouble.Visible = True
                                'LabelDouble.Focus()
                                upload_error.Text = "Importazione fallita: il file contiene i seguenti codici articolo duplicati"
                                upload_place_error.Visible = True
                                exc_detail.Visible = False
                                Return
                            End If

                            'estraggo i dati dal foglio excel e li inserisco in una datatable usando la funzione ImportExcelOledb
                            'Try
                            '    dt = BLL.ImportExcelOledb(upload_excel, filename, sheet, User.Identity.Name)
                            'Catch ex As Exception
                            '    upload_error.Text = ex.Message
                            '    upload_place_error.Visible = True
                            'End Try

                            
                            Dim sqlBulk As New SqlBulkCopy(ConfigurationManager.ConnectionStrings("AcomdbConnectionString").ToString())
                            sqlBulk.DestinationTableName = "pricelists"
                            sqlBulk.ColumnMappings.Add("CodArticolo", "article_code")
                            sqlBulk.ColumnMappings.Add("Descrizione", "article_desc")
                            sqlBulk.ColumnMappings.Add("Importo", "prezzo")
                            sqlBulk.ColumnMappings.Add("Data decorrenza", "data_decorrenza")
                            sqlBulk.ColumnMappings.Add("Famiglia", "familyID")
                            sqlBulk.ColumnMappings.Add("Prodotto", "productID")
                            sqlBulk.ColumnMappings.Add("created_by", "created_by")
                            sqlBulk.ColumnMappings.Add("created_date", "created_date")
                            sqlBulk.ColumnMappings.Add("annull", "annull")

                            sqlBulk.WriteToServer(dt)

                            upload_place_success.Visible = True

                        Catch ex As SqlException
                            If ex.Number = 2601 Then
                                'Dati duplicati
                                upload_error.Text = "Importazione fallita: sono presenti duplicati nei codici articolo"
                                exc_detail.Text = ex.Message
                                upload_place_error.Visible = True
                                Return
                            Else
                                upload_error.Text = "Importazione fallita " & ex.Number
                                exc_detail.Text = ex.Message
                                upload_place_error.Visible = True
                                Return
                            End If
                            
                        Catch ex As Exception
                            upload_error.Text = "Importazione fallita"
                            exc_detail.Text = ex.Message
                            upload_place_error.Visible = True
                            Return
                        End Try
                    Else
                        upload_error.Text = "Nome file non valido"
                        exc_detail.Visible = False
                        upload_place_error.Visible = True
                        Return
                    End If
                Else
                    upload_error.Text = "Dimensione file eccessiva, non superare 1Mb"
                    exc_detail.Visible = False
                    upload_place_error.Visible = True
                    Return
                End If
            Else
                upload_error.Text = "Estensione del file non valida"
                upload_place_error.Visible = True
                Return
            End If

        End If

    End Sub
End Class