Imports System
Imports System.Web
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Owin

Partial Public Class ForgotPassword
    Inherits System.Web.UI.Page

    Protected Property StatusMessage() As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

    Protected Sub Forgot(sender As Object, e As EventArgs)
        If IsValid Then
            ' Convalidare l'indirizzo e-mail dell'utente
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim user As ApplicationUser = manager.FindByName(Email.Text)
            If user Is Nothing OrElse Not manager.IsEmailConfirmed(user.Id) Then
                FailureText.Text = "L'utente non esiste o non è confermato."
                ErrorMessage.Visible = True
                Return
            End If
            ' Per ulteriori informazioni su come abilitare la conferma dell'account e la reimpostazione della password, visitare http://go.microsoft.com/fwlink/?LinkID=320771
            ' Inviare un messaggio di posta elettronica con il codice e il reindirizzamento alla pagina di reimpostazione della password
            ' Dim code = manager.GeneratePasswordResetToken(user.Id)
            ' Dim callbackUrl = IdentityHelper.GetResetPasswordRedirectUrl(code, Request)
            ' manager.SendEmail(user.Id, "Reimposta password", "Per reimpostare la password, fare clic <a href=""" & callbackUrl & """>qui</a>.")
            loginForm.Visible = False
            DisplayEmail.Visible = True
        End If
    End Sub
End Class