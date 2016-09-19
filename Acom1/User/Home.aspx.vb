Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Globalization
Imports System.Collections.Generic
Imports Acom1.SiteMaster
Imports Acom1.DAL


Public Class Home1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If User.IsInRole("DataEntry") Then
            Response.Redirect("/User/HomeDE")
        End If

    End Sub

    Public Function GridVisite_GetData(<Control("DropDownAgent")> agent As Nullable(Of Integer), <Control("DropDownGGVisite")> days As Integer) As IQueryable(Of ViewVisit)

        Dim dataodierna As Date = Today 'Date.Now
        Dim datalimite As Date
        datalimite = DateAdd(DateInterval.Day, days, dataodierna)

        Dim ctx As New AcomLinqContextDataContext
        Dim vst = ctx.ViewVisit

        'controllo se agent è selezionato, se non lo è assegno ad agent l'agente associato allo username loggato
        If agent Is Nothing Then
            Dim context As New AcomContext
            Dim usr As String = User.Identity.Name

            Dim qry = context.agents.Where(Function(p) p.username = usr And p.annull = False).ToList

            If qry.Count = 1 Then 'c'è un solo agente con questo username
                DropDownAgent.SelectedValue = qry.Item(0).ID
                agent = qry.Item(0).ID
            Else
                DropDownAgent.SelectedValue = Nothing
                agent = Nothing
            End If
        End If

        'seleziono gli eventi con data fino a datalimite, per l'agente selezionato, non annullati, con motivo PR e stato pending e motivo preventivo e nessun riferimento preventivo
        Dim query = From p In vst Select p
                    Where p.data <= datalimite And p.agentID = agent And p.annull = False And ((p.motivo_type = 1 And p.stato = "pending") Or (p.motivo_type = 2 And (p.preventivo_num = Nothing Or p.preventivo_num.Equals(Nothing) Or p.stato = "pending")))
                    Order By p.data Ascending

        Return query

    End Function
    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridVisiteInc_GetData(<Control("DropDownAgent")> agent As Nullable(Of Integer), <Control("DropDownGGVisite")> days As Integer) As IQueryable(Of ViewVisit)
        Dim dataodierna As Date = Today
        Dim datalimite As Date
        datalimite = DateAdd(DateInterval.Day, days, dataodierna)

        Dim ctx As New AcomLinqContextDataContext
        Dim vst = ctx.ViewVisit

        Dim query = From p In vst Select p
                    Where p.data < dataodierna And p.agentID = agent

        Return query
    End Function

    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridPreventivi_GetData(<Control("DropDownAgent")> agent As Nullable(Of Integer), <Control("DropDownGGPreventivi")> days As Integer) As IQueryable

        Dim dataodierna As Date = Today 'Date.Now
        Dim datalimite As Date
        datalimite = DateAdd(DateInterval.Day, days, dataodierna)

        Dim ctx As New AcomLinqContextDataContext
        Dim offer = ctx.ViewOfferInsert

        'controllo se agent è selezionato, se non lo è assegno ad agent l'agente associato allo username loggato
        If agent Is Nothing Then
            Dim context As New AcomContext
            Dim usr As String = User.Identity.Name

            Dim qry = context.agents.Where(Function(p) p.username = usr And p.annull = False).ToList

            If qry.Count = 1 Then 'c'è un solo agente con questo username
                DropDownAgent.SelectedValue = qry.Item(0).ID
                agent = qry.Item(0).ID
            Else
                DropDownAgent.SelectedValue = Nothing
                agent = Nothing
            End If
        End If

        'seleziono le offerte scadute e con scadenza nel periodo fino a datalimite, non annullate, per l'agente selezionato e con stato in attesa
        Dim query = From p In offer Select p
                    Where p.data_valid <= datalimite And p.annull = False And p.agentID = agent And p.stato = "In attesa"
                    Order By p.data_valid Ascending, p.offer_code Descending
        Return query

    End Function

    Protected Sub DropDownAgent_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub GridPreventivi_DataBound(sender As Object, e As EventArgs)

        'per ogni riga del gridview, cerco il campo data validità e lo evidenzio in rosso se è passata
        Dim row As GridViewRow

        For Each row In GridPreventivi.Rows

            Dim dataval As Label = row.FindControl("dataval")

            If Not String.IsNullOrEmpty(dataval.Text) Then
                If dataval.Text < Today Then
                    dataval.ForeColor = Drawing.Color.Red
                ElseIf dataval.Text = Today Then
                    dataval.ForeColor = Drawing.Color.Blue
                End If
            End If

        Next

    End Sub

    Protected Sub GridVisite_DataBound(sender As Object, e As EventArgs)
        'per ogni riga del gridview, cerco il campo data validità e lo evidenzio in rosso se è passata
        Dim row As GridViewRow

        For Each row In GridVisite.Rows

            Dim dataval As Label = row.FindControl("data")

            If Not String.IsNullOrEmpty(dataval.Text) Then
                If dataval.Text < Today Then
                    dataval.ForeColor = Drawing.Color.Red
                ElseIf dataval.Text = Today Then
                    dataval.ForeColor = Drawing.Color.Blue
                End If
            End If

        Next


    End Sub

    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function Grid_OtherAgents_GetData() As IQueryable
        Dim ctx As New AcomContext
        Dim usr As String = User.Identity.Name
        Dim query = ctx.agents.Where(Function(p) p.annull = 0 And p.username <> usr)

        Return query
    End Function

    Protected Sub Grid_OtherAgents_DataBound(sender As Object, e As EventArgs)

        Dim row As GridViewRow
        Dim agent As Label
        Dim agentID As Integer
        Dim ctx As New AcomLinqContextDataContext
        Dim gridvis As GridView
        Dim gridoff As GridView

        For Each row In Grid_OtherAgents.Rows

            'cerco il controllo ID agente e ne prendo il valore
            agent = row.FindControl("ID")
            agentID = agent.Text

            'passo il valore dell'ID agente alle grid view
            Dim queryvisit = ctx.ViewAgentWorkVisit.Where(Function(p) p.agentID = agentID)
            gridvis = row.FindControl("GridOtherAgentVisit")
            gridvis.DataSource = queryvisit
            gridvis.DataBind()


            Dim queryoffer = ctx.ViewAgentWorkOffer.Where(Function(p) p.agentID = agentID)
            gridoff = row.FindControl("GridOtherAgentOffer")
            gridoff.DataSource = queryoffer
            gridoff.DataBind()


        Next

    End Sub
End Class