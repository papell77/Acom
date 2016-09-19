Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports System.Web.ModelBinding
Imports System.Data.Entity

Public Class FilialiIns
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id As Integer = Request.QueryString("ID_of")

        'se la pagina viene caricata senza riferimento all'id office, apro in modalità inserimento
        If id = 0 Then

            DetailsViewOffice.ChangeMode(DetailsViewMode.Insert)

        End If

        If DetailsViewOffice.CurrentMode = DetailsViewMode.Insert Then
            updatecontact.Visible = False
        End If

    End Sub

    Private Sub Page_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

        If DetailsViewOffice.CurrentMode() = DetailsViewMode.Insert Then

            ListViewContacts.Visible = False

        End If

    End Sub

    ' Il parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    ' o essere decorato con un attributo del provider di valori, ad esempio <QueryString>ByVal id as Integer
    Public Function DetailsViewOffice_GetItem(<QueryString("ID_of")> ByVal id As Nullable(Of Integer)) As IQueryable(Of ViewOfficeDettaglio)

        Dim context As New AcomLinqContextDataContext
        Dim query As IQueryable(Of ViewOfficeDettaglio)

        Try
            query = context.ViewOfficeDettaglio.Where(Function(p) p.ID = id)
            Return query
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_client() As List(Of client)
        Try
            Return BLL.Get_client(DetailsViewOffice.CurrentMode)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    'usata per popolare drop down provincia
    Public Function Get_provincia() As List(Of provincia)
        Try
            Return BLL.Get_provincia
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Sub DetailsViewOffice_InsertItem()

        Dim item As New Acom1.Models.office
        Dim context As New AcomContext

        Dim DDLclient As DropDownList = DetailsViewOffice.FindControl("clientID")
        Dim nome As TextBox = DetailsViewOffice.FindControl("nome")
        Dim DDLprov As DropDownList = DetailsViewOffice.FindControl("provinciaID")
        Dim DDLcom As DropDownList = DetailsViewOffice.FindControl("comuneID")
        Dim cap As TextBox = DetailsViewOffice.FindControl("cap")
        Dim indirizzo As TextBox = DetailsViewOffice.FindControl("indirizzo")
        Dim telefono As TextBox = DetailsViewOffice.FindControl("telefono")
        Dim email As TextBox = DetailsViewOffice.FindControl("email")
        Dim note As TextBox = DetailsViewOffice.FindControl("note")


        item.nome = nome.Text
        item.cap = cap.Text
        item.indirizzo = indirizzo.Text
        item.telefono = telefono.Text
        item.email = email.Text
        item.note = note.Text

        'un po' di verifiche su dropdownlist e date
        If Not DDLprov.SelectedValue = "" Then
            item.provinciaID = DDLprov.SelectedValue
        End If
        If Not DDLcom.SelectedValue = "" Then
            item.comuneID = DDLcom.SelectedValue
        End If
        If Not DDLclient.SelectedValue = "" Then
            item.clientID = DDLclient.SelectedValue
        End If

        'If Not id_client = Nothing Then
        'item.clientID = id_client
        'End If

        TryUpdateModel(item)
        If ModelState.IsValid Then

            context.offices.Add(item)
            context.SaveChanges()

            'recupero l'id del record inserito e aggiorno la pagina
            Dim id = item.ID
            Response.Redirect("~/User/FilialiIns?ID_of=" & id & "&ID_cl=" & item.clientID)

        End If

    End Sub

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub DetailsViewOffice_UpdateItem(ByVal id As Integer)

        Dim item As Acom1.Models.office = Nothing
        Dim context As New AcomContext
        item = context.offices.Find(id)

        If item Is Nothing Then
            ' Elemento non trovato
            ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
            Return
        End If
        TryUpdateModel(item)
        If ModelState.IsValid Then
            context.SaveChanges()
        End If

    End Sub

    Protected Sub comuneID_DataBinding(sender As Object, e As EventArgs)

        Dim DDLcomuni As DropDownList = DetailsViewOffice.FindControl("comuneID")

        Try
            DDLcomuni.Items.AddRange(BLL.Get_comune_from_provincia(DetailsViewOffice))
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return
        End Try
    End Sub

    Protected Sub provinciaID_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim DDLcomuni As DropDownList = DetailsViewOffice.FindControl("comuneID")

        Try
            DDLcomuni.Items.AddRange(BLL.Get_comune_from_provincia(DetailsViewOffice))
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return
        End Try

    End Sub

    Protected Sub ListViewContacts_ItemInserting(sender As Object, e As ListViewInsertEventArgs)

        'devo passare il valore dell'ID cliente e office ai parametri @clientID e officeID nella query di inserimento nuovo contatto
        SqlDataSourceContacts.InsertParameters("clientID").DefaultValue = Request.QueryString("ID_cl")
        SqlDataSourceContacts.InsertParameters("officeID").DefaultValue = Request.QueryString("ID_of")

    End Sub

    Protected Sub comuneID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim comune As DropDownList = sender
        Dim cap As TextBox = DetailsViewOffice.FindControl("cap")
        Dim ctx As New AcomContext

        If Not comune.SelectedValue = "" Then 'imposto il cap
            Dim query As String
            Try
                query = ctx.comuni.Where(Function(p) p.ID = comune.SelectedValue).Select(Function(c) c.CAP).FirstOrDefault()
                cap.Text = query
            Catch ex As Exception
                errmsg.Text = ex.Message
                errmsg.Visible = True
                Return
            End Try

        End If

    End Sub

    Protected Sub duplicate_code_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim ctx As New AcomContext
        Dim IDcliente As DropDownList = DetailsViewOffice.FindControl("clientID")
        If IDcliente Is Nothing Then Exit Sub
        Dim query As String

        Try
            query = ctx.offices.Where(Function(p) p.nome = args.Value And p.clientID = IDcliente.SelectedValue).Select(Function(c) c.nome).FirstOrDefault
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return
        End Try

        If query Is Nothing Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If

    End Sub
End Class