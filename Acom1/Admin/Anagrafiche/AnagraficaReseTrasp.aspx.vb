Public Class AnagraficaReseTrasp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ListView1_ItemInserting(sender As Object, e As ListViewInsertEventArgs)
        SqlDataSourceResa.InsertParameters("created_by").DefaultValue = User.Identity.Name
        SqlDataSourceResa.InsertParameters("created_date").DefaultValue = Now

    End Sub

    Protected Sub ListView1_ItemUpdated(sender As Object, e As ListViewUpdatedEventArgs)
        If Not e.Exception Is Nothing Then
            If e.AffectedRows = 0 Then
                concurrencyViolation.Text = e.Exception.Message & " dati non modificati"
                concurrencyViolation.Visible = True
                e.KeepInEditMode = True
            Else
                concurrencyViolation.Text = e.Exception.Message
                concurrencyViolation.Visible = True
            End If
            e.ExceptionHandled = True
        End If


    End Sub

    Protected Sub SqlDataSourceResa_Updating(sender As Object, e As SqlDataSourceCommandEventArgs)
        e.Command.Parameters("@updated_by").Value = User.Identity.Name
        e.Command.Parameters("@updated_date").Value = Today
    End Sub

    Protected Sub ListView2_ItemUpdated(sender As Object, e As ListViewUpdatedEventArgs)
        If Not e.Exception Is Nothing Then
            If e.AffectedRows = 0 Then
                concurrencyViolation2.Text = e.Exception.Message & " dati non modificati"
                concurrencyViolation2.Visible = True
                e.KeepInEditMode = True
            Else
                concurrencyViolation2.Text = e.Exception.Message
                concurrencyViolation2.Visible = True
            End If
            e.ExceptionHandled = True
        End If


    End Sub

    Protected Sub SqlDataSourceTrasporto_Updating(sender As Object, e As SqlDataSourceCommandEventArgs)
        e.Command.Parameters("@updated_by").Value = User.Identity.Name
        e.Command.Parameters("@updated_date").Value = Today
    End Sub

    Protected Sub ListView1_ItemInserted(sender As Object, e As ListViewInsertedEventArgs)
        If Not e.Exception Is Nothing Then
            If e.AffectedRows = 0 Then
                concurrencyViolation.Text = e.Exception.Message & " dati non inseriti"
                concurrencyViolation.Visible = True
                e.KeepInInsertMode = True
            Else
                concurrencyViolation.Text = e.Exception.Message
                concurrencyViolation.Visible = True
            End If
            e.ExceptionHandled = True
        End If


    End Sub

    Protected Sub ListView2_ItemInserted(sender As Object, e As ListViewInsertedEventArgs)
        If Not e.Exception Is Nothing Then
            If e.AffectedRows = 0 Then
                concurrencyViolation2.Text = e.Exception.Message & " dati non inseriti"
                concurrencyViolation2.Visible = True
                e.KeepInInsertMode = True
            Else
                concurrencyViolation2.Text = e.Exception.Message
                concurrencyViolation2.Visible = True
            End If
            e.ExceptionHandled = True
        End If


    End Sub
End Class