Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports Microsoft.AspNet.Identity
Imports System.Web.ModelBinding
Imports System.Data.SqlClient
Imports System.Data.Entity
Imports System.Globalization


Public Class ReportAgente
    Inherits System.Web.UI.Page

    Private ctx As New AcomLinqContextDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            textdataal.Text = Today
        End If
    End Sub

    Public Function Get_agents()
        Return BLL.Get_agent
    End Function

    Public Function Get_clients()
        Return BLL.Get_client
    End Function

    Public Function Get_families()
        Return BLL.Get_families
    End Function

    Protected Sub btnCerca_Click(sender As Object, e As EventArgs)

        Dim datain As Date = ConvertDate(textdatadal.Text)
        Dim dataout As Date = ConvertDate(textdataal.Text)

        Dim agent As Nullable(Of Integer)
        If DDLagent.SelectedValue = "" Then
            agent = Nothing
        Else
            agent = DDLagent.SelectedValue
        End If

        Dim cliente As Nullable(Of Integer)
        If clienteID.SelectedValue = "" Then
            cliente = Nothing
        Else
            cliente = clienteID.SelectedValue
        End If

        Dim filiale As Nullable(Of Integer)
        If officeID.SelectedValue = "" Then
            filiale = Nothing
        Else
            filiale = officeID.SelectedValue
        End If

        Dim famiglia As Nullable(Of Integer)
        If DDLfamily.SelectedValue = "" Then
            famiglia = Nothing
        Else
            famiglia = DDLfamily.SelectedValue
        End If

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("AcomdbConnectionString").ConnectionString
        Dim con As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure

        'definisco stored procedure e parametri per gridvisit
        cmd.CommandText = "dbo.VisitReport"
        cmd.Parameters.Add("@datain", SqlDbType.Date).Value = datain
        cmd.Parameters.Add("@dataout", SqlDbType.Date).Value = dataout
        cmd.Parameters.Add("@agentID", SqlDbType.Int).Value = agent
        cmd.Parameters.Add("@clientID", SqlDbType.Int).Value = cliente
        cmd.Parameters.Add("@officeID", SqlDbType.Int).Value = filiale

        Try
            con.Open()
            GridViewVisit.EmptyDataText = "Nessun dato disponibile"
            GridViewVisit.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            GridViewVisit.DataBind()
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        Finally
            con.Close()
        End Try

        'definisco stored procedure e parametri per gridoffer
        cmd = New SqlCommand
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure
        cmd.CommandText = "dbo.OfferReport"
        cmd.Parameters.Add("@datain", SqlDbType.Date).Value = datain
        cmd.Parameters.Add("@dataout", SqlDbType.Date).Value = dataout
        cmd.Parameters.Add("@agentID", SqlDbType.Int).Value = agent
        cmd.Parameters.Add("@clientID", SqlDbType.Int).Value = cliente
        cmd.Parameters.Add("@officeID", SqlDbType.Int).Value = filiale
        cmd.Parameters.Add("@familyID", SqlDbType.Int).Value = famiglia

        Try
            con.Open()
            GridViewOffer.EmptyDataText = "Nessun dato disponibile"
            GridViewOffer.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            GridViewOffer.DataBind()
            update_report.Visible = True
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        Finally
            con.Close()
            con.Dispose()
        End Try

    End Sub

    Protected Sub clienteID_SelectedIndexChanged(sender As Object, e As EventArgs)
        officeID.Items.AddRange(BLL.Get_office_from_client(TableFindOffer))
    End Sub

    Public Function Get_client()
        Return BLL.Get_client
    End Function


    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridViewVisit_GetData(<Control("textdatadal")> ByVal datadal As Nullable(Of Date), _
                                          <Control("textdataal")> ByVal dataal As Nullable(Of Date), _
                                          <Control("DDLagent")> ByVal agent As Nullable(Of Integer), _
                                          <Control("clienteID")> ByVal cliente As Nullable(Of Integer)) As Boolean


        If Not datadal.HasValue And _
           Not dataal.HasValue And _
           Not agent.HasValue And _
           Not cliente.HasValue Then

            Return Nothing

        End If


        Return True

    End Function

    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridViewOffer_GetData(<Control("textdatadal")> ByVal datadal As Nullable(Of Date), _
                                          <Control("textdataal")> ByVal dataal As Nullable(Of Date), _
                                          <Control("DDLagent")> ByVal agent As Nullable(Of Integer), _
                                          <Control("clienteID")> ByVal cliente As Nullable(Of Integer), _
                                          <Control("DDLfamily")> ByVal family As Nullable(Of Integer)) As IQueryable
        If Not datadal.HasValue And _
            Not dataal.HasValue And _
            Not agent.HasValue And _
            Not cliente.HasValue And _
            Not family.HasValue Then

            Return Nothing

        End If


        Return Nothing
    End Function

    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridViewOrder_GetData(<Control("textdatadal")> ByVal datadal As Nullable(Of Date), _
                                          <Control("textdataal")> ByVal dataal As Nullable(Of Date), _
                                          <Control("DDLagent")> ByVal agent As Nullable(Of Integer), _
                                          <Control("clienteID")> ByVal cliente As Nullable(Of Integer), _
                                          <Control("DDLfamily")> ByVal family As Nullable(Of Integer)) As IQueryable
        If Not datadal.HasValue And _
           Not dataal.HasValue And _
           Not agent.HasValue And _
           Not cliente.HasValue And _
           Not family.HasValue Then

            Return Nothing

        End If


        Return Nothing
    End Function
End Class