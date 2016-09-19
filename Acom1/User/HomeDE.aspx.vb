Imports Acom1.DAL
Imports Acom1.BLL


Public Class HomeDE
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim ctx As New AcomLinqContextDataContext
        Dim query = ctx.ViewOrderNoProduct.Count

        order_no_prod.Text = "Sono presenti " & query & " ordini senza prodotti associati"

    End Sub

    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridViewOrder_GetData() As IQueryable

        Dim ctx As New AcomLinqContextDataContext
        Dim query = ctx.ViewOrderNoProduct.OrderBy(Function(p) p.data)
        Return query

    End Function

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