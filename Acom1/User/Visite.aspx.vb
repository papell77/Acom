Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports System.Web.ModelBinding

Public Class Visite1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            textdataal.Text = Today
        End If

    End Sub

    Public Function Get_agent()
        Try
            Return BLL.Get_agent
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_client()
        Try
            Return BLL.Get_client
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_offer()
        Try
            Return BLL.Get_offer
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_order()
        Try
            Return BLL.Get_order
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridViewVisit_GetData(<Control("textdatadal")> datadal As Nullable(Of Date), _
                                          <Control("textdataal")> dataal As Nullable(Of Date), _
                                          <Control("DDLagent")> agent As Nullable(Of Integer), _
                                          <Control("DDLcliente")> client As Nullable(Of Integer), _
                                          <Control("textmotivo")> motivo As String) As IQueryable
        '<Control("DDLpreventivo")> preventivo As String, _
        '<Control("DDLordine")> ordine As String) 

        If Not datadal.HasValue And _
            Not dataal.HasValue And _
            Not agent.HasValue And _
            Not client.HasValue And _
            String.IsNullOrEmpty(textmotivo.Text) Then
            'String.IsNullOrEmpty(DDLordine.Text) And _
            'String.IsNullOrEmpty(DDLpreventivo.Text) Then

            Return Nothing
        End If

        Dim ctx As New AcomLinqContextDataContext
        Dim vst = ctx.ViewVisit

        Dim query As IQueryable(Of ViewVisit)
        query = From p In vst
                    Where (p.data >= datadal And p.data <= dataal And p.annull = False)
                    Select p
                    Order By p.data Ascending, p.name Ascending, p.ragione_sociale Ascending

        If agent.HasValue Then
                query = query.Where(Function(p) p.agentID = agent)
        End If

        If client.HasValue Then
                query = query.Where(Function(p) p.clientID = client)
        End If

        If Not String.IsNullOrEmpty(textmotivo.Text) Then
                query = query.Where(Function(p) p.motivo_desc.Contains(motivo))
        End If

        Try
            Return query
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try


    End Function
End Class