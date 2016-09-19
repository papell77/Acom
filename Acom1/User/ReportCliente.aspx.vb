Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports Microsoft.AspNet.Identity
Imports System.Web.ModelBinding
Imports System.Data.SqlClient
Imports System.Data.Entity
Imports System.Globalization

Public Class ReportCliente
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            textdataal.Text = Today
        End If

    End Sub

    Public Function Get_clients()
        Return BLL.Get_client
    End Function

    Public Function Get_canal()
        Return BLL.Get_canal
    End Function

    Public Function Get_agents()
        Return BLL.Get_agent()
    End Function

    Public Function Get_families()
        Return BLL.Get_families
    End Function

    Protected Sub btnCerca_Click(sender As Object, e As EventArgs)

        Dim ctx As New AcomLinqContextDataContext
        Dim datain As Date = ConvertDate(textdatadal.Text)
        Dim dataout As Date = ConvertDate(textdataal.Text)
        Dim query = ctx.ViewOrderNoProduct.Where(Function(c) c.data >= datain And c.data <= dataout)

        Dim agent As Nullable(Of Integer)
        If DDLagent.SelectedValue = "" Then
            agent = Nothing
        Else
            agent = DDLagent.SelectedValue
            query = query.Where(Function(c) c.agentID)
        End If

        Dim cliente As Nullable(Of Integer)
        If clienteID.SelectedValue = "" Then
            cliente = Nothing
        Else
            cliente = clienteID.SelectedValue
            query = query.Where(Function(c) c.clientID)
        End If

        Dim office As Nullable(Of Integer)
        If officeID.SelectedValue = "" Then
            office = Nothing
        Else
            office = officeID.SelectedValue
            query = query.Where(Function(c) c.officeID)
        End If

        Dim canale As Nullable(Of Integer)
        If canalID.SelectedValue = "" Then
            canale = Nothing
        Else
            canale = canalID.SelectedValue
            query = query.Where(Function(c) c.canalID)
        End If

        Dim family As Nullable(Of Integer)
        If familyID.SelectedValue = "" Then
            family = Nothing
        Else
            family = familyID.SelectedValue
            query = query.Where(Function(c) c.familyID)
        End If

        Dim ordNoProd As Integer
        ordNoProd = query.Count(Function(p) p.ID)

        If ordNoProd > 0 Then
            prodotti_assenti.Text = "Sono presenti " & ordNoProd & " ordini senza prodotti associati, vedere dettaglio in maschera CERCA ORDINI"
            prodotti_assenti.Visible = True
        End If

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("AcomdbConnectionString").ConnectionString
        Dim con As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure

        'definisco stored procedure e parametri per gridvisit
        cmd.CommandText = "dbo.OrderReport"
        cmd.Parameters.Add("@datain", SqlDbType.Date).Value = datain
        cmd.Parameters.Add("@dataout", SqlDbType.Date).Value = dataout
        cmd.Parameters.Add("@agentID", SqlDbType.Int).Value = agent
        cmd.Parameters.Add("@clientID", SqlDbType.Int).Value = cliente
        cmd.Parameters.Add("@officeID", SqlDbType.Int).Value = office
        cmd.Parameters.Add("@canalID", SqlDbType.Int).Value = canale
        cmd.Parameters.Add("@familyID", SqlDbType.Int).Value = family


        Try
            con.Open()
            GridViewProducts.EmptyDataText = "Nessun dato disponibile"
            GridViewProducts.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            GridViewProducts.DataBind()
            'update_report.Visible = True
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        Finally
            con.Close()
        End Try




    End Sub

    Protected Sub clienteID_SelectedIndexChanged(sender As Object, e As EventArgs)
        officeID.Items.AddRange(BLL.Get_office_from_client(TableFindOrder))
    End Sub



    Public Function Get_client()
        Return BLL.Get_client
    End Function

End Class