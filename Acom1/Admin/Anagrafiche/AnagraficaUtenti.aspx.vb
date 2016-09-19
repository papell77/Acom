Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Owin
Imports Acom1.DAL


Public Class AnagraficaUtenti
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click

        Dim delUser As String
        delUser = Me.GridView1.SelectedValue
        If delUser.Equals(User.Identity.GetUserId) Then
            lblError.Text = "Attenzione, si sta cercando di cancellare il proprio utente"
            lblError.Visible = True
            Return
        End If

        If Not String.IsNullOrEmpty(delUser) Then

            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            'Dim user As ApplicationUser = manager.FindByEmail(delUser)
            'Dim usrid As String = user.Id
            'bisognerebbe aggiungere un controllo che verifichi se lo user in cancellazione è loggato
            Dim result = manager.SetLockoutEnabled(delUser, True)

            If result.Succeeded Then
                'imposto una data futura sufficientemente lontata di sblocco dell'account
                Dim dateoff As DateTimeOffset = #1/1/2100#
                result = manager.SetLockoutEndDate(delUser, dateoff)
                If result.Succeeded Then
                    'da inserire messagebox di conferma
                    Me.GridView1.DataBind()
                Else
                    lblError.Text = "Blocco utente non riuscito, contattare l'amministratore di sistema"
                    lblError.Visible = True
                End If

            End If
        Else
            lblError.Text = "Selezionare un utente"
            lblError.Visible = True
        End If

    End Sub

    Protected Sub btnActivate_Click(sender As Object, e As EventArgs) Handles btnActivate.Click

        Dim selectuser As String
        selectuser = Me.GridView1.SelectedValue

        If Not String.IsNullOrEmpty(selectuser) Then

            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            'Dim user As ApplicationUser = manager.FindByEmail(selectuser)
            'Dim usrid As String = user.Id
            'bisognerebbe aggiungere un controllo che verifichi se lo user in cancellazione è loggato
            Dim result = manager.SetLockoutEnabled(selectuser, False)

            If result.Succeeded Then

                Me.GridView1.DataBind()
            Else
                lblError.Text = "Sblocco utente non riuscito, contattare l'amministratore di sistema"
                lblError.Visible = True
            End If
        Else
            lblError.Text = "Selezionare un utente"
            lblError.Visible = True
        End If

    End Sub


    Protected Sub btnResetPw_Click(sender As Object, e As EventArgs) Handles btnResetPw.Click

        Dim selectuser As String
        selectuser = Me.GridView1.SelectedValue
        Dim newpassword As String = "acomsrl"

        If Not String.IsNullOrEmpty(selectuser) Then

            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim user = manager.FindById(selectuser)

            user.PasswordHash = manager.PasswordHasher.HashPassword(newpassword)
            'aggiorno il security stamp
            manager.UpdateSecurityStamp(selectuser)
            'salvo la nuova password
            Dim result = manager.Update(user)
            If result.Succeeded Then
                lblResetPw.Text = "La password dell'utente " & user.name & " è stata resettata a " & newpassword
                lblResetPw.Visible = True
                lblError.Visible = False
            Else
                lblResetPw.Text = "Il reset password per l'utente " & user.name & " non è riuscito, contattare l'amministratore di sistema"
                lblResetPw.Visible = True
                lblError.Visible = False
            End If
        Else
            lblError.Text = "Selezionare un utente"
            lblError.Visible = True
        End If
    End Sub
End Class