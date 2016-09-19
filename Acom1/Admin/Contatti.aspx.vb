Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports Microsoft.AspNet.Identity
Imports System.Web.ModelBinding

Public Class Contatti
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub clienteID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Try
            officeID.Items.AddRange(BLL.Get_office_from_client(TableFindContact))
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        End Try

    End Sub

    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridViewContact_GetData(<Control("clienteID")> ByVal cliente As Nullable(Of Integer), _
                                          <Control("officeID")> ByVal office As Nullable(Of Integer), _
                                          <Control("textcognome")> ByVal cognome As String, _
                                          <Control("texttelefono")> ByVal telefono As String, _
                                          <Control("textcellulare")> ByVal cellulare As String, _
                                          <Control("textemail")> ByVal email As String, _
                                          <Control("textfunzione")> ByVal funzione As String) As IQueryable

        If Not cliente.HasValue And _
           Not office.HasValue And _
           String.IsNullOrEmpty(textcognome.Text) And _
           String.IsNullOrEmpty(texttelefono.Text) And _
           String.IsNullOrEmpty(textcellulare.Text) And _
           String.IsNullOrEmpty(textemail.Text) And _
           String.IsNullOrEmpty(textfunzione.Text) Then

            If Page.IsPostBack Then
                errmsg.Text = "Inserire almeno un criterio di ricerca"
                errmsg.Visible = True
                Return Nothing
            Else
                Return Nothing
            End If

        End If

        Dim ctx As New AcomLinqContextDataContext
        Dim query As IQueryable(Of ViewContacts)
        query = From p In ctx.ViewContacts Select p

        If cliente.HasValue Then
            query = query.Where(Function(p) p.clientID = cliente)
        End If

        If office.HasValue Then
            query = query.Where(Function(p) p.officeID = office)
        End If

        If Not String.IsNullOrEmpty(cognome) Then
            query = query.Where(Function(p) p.cognome.Contains(cognome))
        End If

        If Not String.IsNullOrEmpty(telefono) Then
            query = query.Where(Function(p) p.telefono.Contains(telefono))
        End If

        If Not String.IsNullOrEmpty(cellulare) Then
            query = query.Where(Function(p) p.cellulare.Contains(cellulare))
        End If

        If Not String.IsNullOrEmpty(email) Then
            query = query.Where(Function(p) p.email.Contains(email))
        End If

        If Not String.IsNullOrEmpty(funzione) Then
            query = query.Where(Function(p) p.funzione.Contains(funzione))
        End If

        Try
            Return query.OrderBy(Function(p) p.cognome)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try


    End Function

    Protected Sub btnCercaContatto_Click(sender As Object, e As EventArgs)
        GridViewContact.DataBind()
    End Sub

    Public Function Get_clients()
        Try
            Return BLL.Get_client
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

End Class