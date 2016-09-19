Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports Acom1.Models
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Acom1.DAL

Namespace Logic
    Friend Class RoleActions

        Sub AddUserAndRole()

            Dim context As New AcomContext
            Dim IdRoleResult As IdentityResult
            Dim IdUserResult As IdentityResult

            'creo un role store e un role manager
            Dim rolestore As New RoleStore(Of IdentityRole)(context)
            Dim rolemng As New RoleManager(Of IdentityRole)(rolestore)

            'se non esiste creo un nuovo ruolo canEdit, o admin in futuro
            If Not rolemng.RoleExists("admin") Then
                IdRoleResult = rolemng.Create(New Identityrole With {.Name = "admin"})
            End If

            'creo lo user
            Dim usermng As New UserManager(Of ApplicationUser)(New UserStore(Of ApplicationUser)(context))
            Dim appuser As New ApplicationUser With {.UserName = "admin@acomsrl.com", .Email = "admin@acomsrl.com"}

            IdUserResult = usermng.Create(appuser, "Pa$$word1")

            'se lo user è stato aggiunto con successo aggiungo il ruolo allo user
            If Not usermng.IsInRole(usermng.FindByEmail("admin@acomsrl.com").Id, "admin") Then
                IdUserResult = usermng.AddToRole(usermng.FindByEmail("admin@acomsrl.com").Id, "admin")
            End If



        End Sub

    End Class
End Namespace
