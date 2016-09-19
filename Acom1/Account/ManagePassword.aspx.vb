Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin

Partial Public Class ManagePassword
    Inherits System.Web.UI.Page
    Protected Property SuccessMessage() As String
      Get
            Return m_SuccessMessage
        End Get
        Private Set
            m_SuccessMessage = Value
        End Set
    End Property
    Private m_SuccessMessage As String

    Private Function HasPassword(manager As ApplicationUserManager) As Boolean
        Return manager.HasPassword(User.Identity.GetUserId())
    End Function

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()

        If Not IsPostBack Then
            ' Determinare le sezioni di cui eseguire il rendering
            If HasPassword(manager) Then
                changePasswordHolder.Visible = True
            Else
                setPassword.Visible = True
                changePasswordHolder.Visible = False
            End If

            ' Messaggio di completamento del rendering
            Dim message = Request.QueryString("m")
            If message IsNot Nothing Then
                ' Rimuovere la stringa di query dall'azione
                Form.Action = ResolveUrl("~/Account/Manage")
            End If
        End If
    End Sub

      Protected Sub ChangePassword_Click(sender As Object, e As EventArgs)
        If IsValid Then
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim signInManager = Context.GetOwinContext().Get(Of ApplicationSignInManager)()
            Dim result As IdentityResult = manager.ChangePassword(User.Identity.GetUserId(), CurrentPassword.Text, NewPassword.Text)

            If result.Succeeded Then
                Dim userInfo = manager.FindById(User.Identity.GetUserId())
                signInManager.SignIn(userInfo, isPersistent := False, rememberBrowser := False)
                Response.Redirect("~/Account/Manage?m=ChangePwdSuccess")
            Else
                AddErrors(result)
            End If
        End If
    End Sub

    Protected Sub SetPassword_Click(sender As Object, e As EventArgs)
      If IsValid Then
          ' Creare le informazioni di accesso locali e collegare l'account locale all'utente
          Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
          Dim result As IdentityResult = manager.AddPassword(User.Identity.GetUserId(), password.Text)
          If result.Succeeded Then
              Response.Redirect("~/Account/Manage?m=SetPwdSuccess")
          Else
              AddErrors(result)
          End If
      End If
    End Sub

    Private Sub AddErrors(result As IdentityResult)
        For Each [error] As String In result.Errors
            ModelState.AddModelError("", [error])
        Next
    End Sub

    Private Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

        'verifico se l'utente è autenticato
        If Not User.Identity.IsAuthenticated Then
            Response.Redirect("~/Account/Login")
            Exit Sub
        Else 'se è autenticato definisco la masterpage da utilizzare
            If User.IsInRole("admin") Then
                MasterPageFile = "~/Admin/AdminMaster.Master"
            ElseIf User.IsInRole("user") Then
                MasterPageFile = "~/User/UserMaster.Master"
            End If
        End If
    End Sub
End Class

