Imports Acom1.BLL
Imports Acom1.Models
Imports Acom1.DAL
Imports System.Web.ModelBinding
Imports Microsoft.AspNet.Identity
Imports OfficeOpenXml 'serve per esportazione excel con epplus
Imports System.IO 'serve per esportazione excel

Public Class Listino
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub

    Public Function Get_products() As List(Of product)
        Return BLL.Get_products
    End Function

    Public Function Get_families() As List(Of family)
        Return BLL.Get_families
    End Function

    Protected Sub btncerca_Click(sender As Object, e As EventArgs)

        If IsNothing(data.Text) Or data.Text = "" Then
            errmsg.Text = "Attenzione, inserire una data di decorrenza"
            errmsg.Visible = True
            data.Focus()
            Exit Sub
        End If

        GridViewPrice.DataBind()

    End Sub

    Protected Sub btnexport_Click(sender As Object, e As EventArgs)

        If IsNothing(dataAL.Text) Or dataAL.Text = "" Then
            errmsg.Text = "Per esportare il listino è necessario inserire una data di fine decorrenza"
            errmsg.Visible = True
            dataAL.Focus()
            Exit Sub
        End If

        Dim pricelist = GetPrices().ToList

        Dim excel As New ExcelPackage
        Dim worksheet = excel.Workbook.Worksheets.Add("Listino")
        Dim totalCols As Integer = 5
        Dim totalRows As Integer = pricelist.Count

        worksheet.Cells(1, 1).Value = "Descrizione"
        worksheet.Cells(1, 2).Value = "CodArticolo"
        worksheet.Cells(1, 3).Value = "Importo"
        worksheet.Cells(1, 4).Value = "Famiglia"
        worksheet.Cells(1, 5).Value = "Prodotto"
        worksheet.Cells(1, 6).Value = "Annullato"

        For j As Integer = 1 To totalRows

            Dim price = pricelist.ElementAt(j - 1)
            worksheet.Cells(j + 1, 1).Value = price.article_desc
            worksheet.Cells(j + 1, 2).Value = price.article_code
            worksheet.Cells(j + 1, 3).Value = price.prezzo.Value
            worksheet.Cells(j + 1, 4).Value = Int(price.familyID.Value)
            worksheet.Cells(j + 1, 5).Value = Int(price.productID.Value)
            worksheet.Cells(j + 1, 6).Value = price.annull

        Next

        Dim memorystream = New MemoryStream
        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        Response.AddHeader("content-disposition", "attachment;  filename=ExportListino.xlsx")
        excel.SaveAs(memorystream)
        memorystream.WriteTo(Response.OutputStream)
        Response.Flush()
        Response.End()


    End Sub

    Protected Sub calext_datadecorrenza_Load(sender As Object, e As EventArgs)

        If Not Page.IsPostBack Then
            Dim anno As Integer = Year(Now())
            Dim giorno As Date = DateValue("01/01/" & anno)
            data.Text = giorno
        End If
        
    End Sub


    Public Function GridViewPrice_GetData(<Control("textarticolo")> articolo As String, _
                                            <Control("textarticolo_desc")> articolo_desc As String, _
                                            <Control("DDLprod")> prodotto As Nullable(Of Integer), _
                                            <Control("DDLfam")> famiglia As Nullable(Of Integer), _
                                            <Control("data")> datadecor As String, _
                                            <Control("dataAl")> datadecorAl As String, _
                                            <Control("checkAnnull")> annull As Boolean) As IQueryable(Of ViewPricelist)



        'se nessuno dei campi di ricerca è compilato non restituisco niente
        If String.IsNullOrEmpty(articolo) And _
            String.IsNullOrEmpty(articolo_desc) And _
            String.IsNullOrEmpty(datadecor) And _
            String.IsNullOrEmpty(datadecorAl) And _
            Not prodotto.HasValue And _
            Not famiglia.HasValue Then

            Return Nothing
            Exit Function
        End If

        Dim context As New AcomLinqContextDataContext
        Dim query = From p In context.ViewPricelist Select p

        'eseguo la query solo se almeno uno dei campi di ricerca è compilato: il campo data è precompilato con il 01/01 dell'anno in corso
        If Not String.IsNullOrEmpty(articolo) Then
            query = query.Where(Function(p) p.article_code.Contains(articolo))
        End If

        If Not String.IsNullOrEmpty(articolo_desc) Then
            query = query.Where(Function(p) p.article_desc.Contains(articolo_desc))
        End If

        If Not String.IsNullOrEmpty(datadecor) Then
            query = query.Where(Function(p) p.data_decorrenza >= datadecor)
        End If

        If Not String.IsNullOrEmpty(datadecorAl) Then
            query = query.Where(Function(p) p.data_decorrenza <= datadecorAl)
        End If

        If checkAnnull.Checked Then
            query = query.Where(Function(p) p.annull = False)
        End If

        If prodotto.HasValue Then
            If prodotto.Value <> 0 Then
                query = query.Where(Function(p) p.productID = prodotto)
            End If
        End If

        If famiglia.HasValue Then
            If famiglia.Value <> 0 Then
                query = query.Where(Function(p) p.familyID = famiglia)
            End If
        End If

        recordCount.Text = query.Count & " Articoli trovati"

        Return query

    End Function

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub GridViewPrice_UpdateItem(ByVal article_code As String, ByVal data_decorrenza As String)



        Dim item As New Acom1.Models.pricelist
        Dim context As New AcomContext

        
        item = context.pricelists.Single(Function(p) p.article_code = article_code And p.data_decorrenza = data_decorrenza)
        item.updated_by = User.Identity.Name
        item.updated_date = Today

        If item Is Nothing Then
            ModelState.AddModelError("", String.Format("Articolo con codice {0} e data decorrenza {1} non trovato", article_code, data_decorrenza))
            Return
        End If

        TryUpdateModel(item)
        If ModelState.IsValid Then
            context.SaveChanges()
        End If

    End Sub

    'Funzione usata per ottenere il listino da esportare in btnexport_Click
    Public Function GetPrices() As IQueryable(Of ViewPricelist)

        'se nessuno dei campi di ricerca è compilato non restituisco niente
        If String.IsNullOrEmpty(textarticolo.Text) And _
            String.IsNullOrEmpty(textarticolo_desc.Text) And _
            String.IsNullOrEmpty(calext_datadecorrenza.SelectedDate.ToString) And _
            String.IsNullOrEmpty(calext_datadecorrenzaAL.SelectedDate.ToString) And _
            Not DDLprod.SelectedValue = "" And _
            Not DDLfam.SelectedValue = "" Then

            Return Nothing
            Exit Function
        End If

        Dim context As New AcomLinqContextDataContext
        Dim query = From p In context.ViewPricelist Select p

        'eseguo la query solo se almeno uno dei campi di ricerca è compilato: il campo data è precompilato con il 01/01 dell'anno in corso
        If Not String.IsNullOrEmpty(textarticolo.Text) Then
            query = query.Where(Function(p) p.article_code.Contains(textarticolo.Text))
        End If

        If Not String.IsNullOrEmpty(textarticolo_desc.Text) Then
            query = query.Where(Function(p) p.article_desc.Contains(textarticolo_desc.Text))
        End If

        If Not String.IsNullOrEmpty(data.Text) Then
            query = query.Where(Function(p) p.data_decorrenza >= data.Text)
        End If

        If Not String.IsNullOrEmpty(dataAL.Text) Then
            query = query.Where(Function(p) p.data_decorrenza <= dataAL.Text)
        End If

        If checkAnnull.Checked Then
            query = query.Where(Function(p) p.annull = False)
        End If

        If Not DDLprod.SelectedValue = "" Then
            query = query.Where(Function(p) p.productID = DDLprod.SelectedValue)
        End If

        If Not DDLfam.SelectedValue = "" Then
            query = query.Where(Function(p) p.familyID = DDLfam.SelectedValue)
        End If

        Return query

    End Function

End Class