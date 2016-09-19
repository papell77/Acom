Imports Acom1.Models
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework

Public Class Anagrafiche
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Insert_Click(sender As Object, e As EventArgs)

        Dim IdRoleResult As IdentityResult
        Dim context As New ApplicationDbContext
        Dim rolestore As New RoleStore(Of IdentityRole)(context)
        Dim rolemng As New RoleManager(Of IdentityRole)(rolestore)

        'se il ruolo inserito nella casella role non esiste lo inserisco
        If Not rolemng.RoleExists(role.Text) Then
            IdRoleResult = rolemng.Create(New Identityrole With {.Name = role.Text})
            GridView1.DataBind()
        Else
            lblerror.Visible = True
        End If



    End Sub

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub GridView1_UpdateItem(ByVal id As Integer)

    End Sub
End Class