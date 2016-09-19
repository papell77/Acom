Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Microsoft.Owin.Security
Imports Owin

Partial Public Class Login
    Inherits Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'RegisterHyperLink.NavigateUrl = "Register"
        ' Abilitare questa opzione dopo aver abilitato la conferma dell'account per la funzionalità di reimpostazione della password
        ' ForgotPasswordHyperLink.NavigateUrl = "Forgot"
        'OpenAuthLogin.ReturnUrl = Request.QueryString("ReturnUrl")

        'Dim returnUrl = HttpUtility.UrlEncode(Request.QueryString("ReturnUrl"))

        'se c'è uno user loggato, eseguo il logout
        'If User.Identity.IsAuthenticated = True Then
        'Dim authmng = HttpContext.Current.GetOwinContext.Authentication
        'authmng.SignOut()
        'End If

        'If Not [String].IsNullOrEmpty(returnUrl) Then
        'RegisterHyperLink.NavigateUrl += "?ReturnUrl=" & returnUrl
        'End If
    End Sub

    Protected Sub LogIn(sender As Object, e As EventArgs)
        If IsValid Then
            ' Convalidare la password utente
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim signinManager = Context.GetOwinContext().GetUserManager(Of ApplicationSignInManager)()

            ' Questa opzione non calcola il numero di tentativi di accesso non riusciti per il blocco dell'account
            ' Per abilitare il conteggio degli errori di password per attivare il blocco, impostare shouldLockout: = True
            Dim result = signinManager.PasswordSignIn(Email.Text, Password.Text, RememberMe.Checked, shouldLockout := False)
            Dim returnurl As String = Request.QueryString("ReturnUrl")

            Select Case result
                Case SignInStatus.Success 'il login ha successo
                    'controllo il ruolo e reindirizzo alla pagina di appartenenza
                    If manager.IsInRole(manager.FindByEmail(Email.Text).Id, "Admin") Then
                        If Not String.IsNullOrEmpty(returnurl) Then
                            IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                            Exit Select
                        Else
                            Response.Redirect("~/Admin/Home")
                            Exit Select
                        End If
                    ElseIf manager.IsInRole(manager.FindByEmail(Email.Text).Id, "User") Then
                        If Not String.IsNullOrEmpty(returnurl) Then
                            'If returnurl.Contains("Admin") Then 'l'utente si è loggato correttamente ma proviene da una pagina non autorizzata, quindi logout
                            'Context.GetOwinContext().Authentication.SignOut()
                            'Exit Select
                            'End If
                            IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                            Exit Select
                        Else
                            Response.Redirect("~/User/Home")
                            Exit Select
                        End If
                    ElseIf manager.IsInRole(manager.FindByEmail(Email.Text).Id, "DataEntry") Then
                        If Not String.IsNullOrEmpty(returnurl) Then
                            IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                            Exit Select
                        Else
                            Response.Redirect("~/User/HomeDE")
                        End If
                    Else 'se lo user non appartiene nè ad Admin nè a User nè a DataEntry lo reindirizzo alla homepage
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                        Exit Select
                    End If
                    
                Case SignInStatus.LockedOut
                    Response.Redirect("/Account/Lockout")
                    Exit Select
                Case SignInStatus.RequiresVerification
                    Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}",
                                                    Request.QueryString("ReturnUrl"),
                                                    RememberMe.Checked),
                                      True)
                    Exit Select
                Case Else
                    FailureText.Text = "Tentativo di accesso non valido"
                    ErrorMessage.Visible = True
                    Exit Select
            End Select
        End If
    End Sub
End Class
