Imports System
Imports System.Data.Entity
Imports System.Data.Entity.Migrations
Imports System.Linq
Imports Acom1.Models
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework


Namespace IdentityContextMigrations

    Friend NotInheritable Class Configuration 
        Inherits DbMigrationsConfiguration(Of ApplicationDbContext)

        Public Sub New()
            AutomaticMigrationsEnabled = False
            MigrationsDirectory = "IdentityContextMigrations"
        End Sub

        Protected Overrides Sub Seed(context As ApplicationDbContext)
            '  This method will be called after migrating to the latest version.

            '  You can use the DbSet(Of T).AddOrUpdate() helper extension method 
            '  to avoid creating duplicate seed data. E.g.
            '
            '    context.People.AddOrUpdate(
            '       Function(c) c.FullName,
            '       New Customer() With {.FullName = "Andrew Peters"},
            '       New Customer() With {.FullName = "Brice Lambson"},
            '       New Customer() With {.FullName = "Rowan Miller"})
            Dim IdRoleResult As IdentityResult
            Dim IdUserResult As IdentityResult

            'creo un role store e un role manager
            Dim rolestore As New RoleStore(Of IdentityRole)(context)
            Dim rolemng As New RoleManager(Of IdentityRole)(rolestore)

            'se non esiste creo un nuovo ruolo admin
            If Not rolemng.RoleExists("Admin") Then
                IdRoleResult = rolemng.Create(New Identityrole With {.Name = "Admin"})
            End If

            'se non esiste creo un nuovo ruolo user
            If Not rolemng.RoleExists("User") Then
                IdRoleResult = rolemng.Create(New Identityrole With {.Name = "User"})
            End If

            If Not rolemng.RoleExists("DataEntry") Then
                IdRoleResult = rolemng.Create(New IdentityRole With {.Name = "DataEntry"})
            End If

            'creo lo user
            Dim usermng As New UserManager(Of ApplicationUser)(New UserStore(Of ApplicationUser)(context))
            Dim appuser As New ApplicationUser With {.UserName = "admin@acomsrl.it", .Email = "admin@acomsrl.it", .name = "Amministratore"}

            IdUserResult = usermng.Create(appuser, "adminadmin")

            'se lo user è stato aggiunto con successo aggiungo il ruolo allo user
            If Not usermng.IsInRole(usermng.FindByEmail("admin@acomsrl.it").Id, "Admin") Then
                IdUserResult = usermng.AddToRole(usermng.FindByEmail("admin@acomsrl.it").Id, "Admin")
            End If

        End Sub

    End Class

End Namespace
