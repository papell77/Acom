Public Class AnagraficaCanali
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ListView1_ItemInserting(sender As Object, e As ListViewInsertEventArgs)

        SqlDataSource1.InsertParameters("created_by").DefaultValue = User.Identity.Name
        SqlDataSource1.InsertParameters("created_date").DefaultValue = Now

    End Sub

    Protected Sub SqlDataSource1_Updating(sender As Object, e As SqlDataSourceCommandEventArgs)

        Dim datanow As Date = System.DateTime.Today
        e.Command.Parameters("@updated_by").Value = User.Identity.Name
        e.Command.Parameters("@aggiorn_date").Value = datanow

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
End Class