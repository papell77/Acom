Imports System
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Owin
Imports Acom1.DAL



Partial Public Class Register
    Inherits Page
    Protected Sub CreateUser_Click(sender As Object, e As EventArgs)
        Dim userName As String = Email.Text
        Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
        Dim signInManager = Context.GetOwinContext().Get(Of ApplicationSignInManager)()
        Dim user = New ApplicationUser() With {.UserName = userName, .Email = userName, .name = Textname.Text, .role = Role.Text}
        Dim result = manager.Create(user, Password.Text)

        If result.Succeeded Then
            ' Per ulteriori informazioni su come abilitare la conferma dell'account e la reimpostazione della password, visitare http://go.microsoft.com/fwlink/?LinkID=320771
            ' Dim code = manager.GenerateEmailConfirmationToken(user.Id)
            ' Dim callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request)
            ' manager.SendEmail(user.Id, "Conferma account", "Per confermare l'account, fare clic <a href=""" & callbackUrl & """>qui</a>.")

            'se lo user è stato aggiunto con successo aggiungo il ruolo allo user
            If Not manager.IsInRole(manager.FindByEmail(Email.Text).Id, Role.Text) Then
                result = manager.AddToRole(manager.FindByEmail(Email.Text).Id, Role.Text)
            End If

            'imposto il lockout su false, sarà admin a decidere quali utenti bloccare
            result = manager.SetLockoutEnabled(manager.FindByEmail(Email.Text).Id, False)

            'Le due righe successive le uso se chi crea lo user è lo user stesso, quindi lo faccio entrare
            'signInManager.SignIn(user, isPersistent:=False, rememberBrowser:=False
            'IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)

            'Qui è solo admin che può creare un nuovo utente, quindi gli do un messaggio di avvenuto inserimento dell'utente

            'Response.Redirect("~/Account/Register")
            ConfirmMessage.Text = "Inserimento nuovo utente completato"
            confirmsg.Visible = True
            Textname.Text = ""
            Email.Text = ""
            Role.SelectedValue = ""

        Else
            ErrorMessage.Text = result.Errors.FirstOrDefault()
            errormsg.Visible = True
        End If
    End Sub

   
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load


        Dim usr As New ApplicationUser
        If Not User.IsInRole("Admin") Then

            Response.Redirect("~/Account/Login")

        End If
    End Sub
End Class

