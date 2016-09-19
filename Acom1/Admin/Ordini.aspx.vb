Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports Microsoft.AspNet.Identity
Imports System.Web.ModelBinding
Imports System.Data.SqlClient
Imports System.Data.Entity
Imports System.Globalization

Public Class Ordini
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            textdataal.Text = Today
        End If
    End Sub

    Protected Sub btnCercaOrdine_Click(sender As Object, e As EventArgs)

        Dim datain As Date = ConvertDate(textdatadal.Text)
        Dim dataout As Date = ConvertDate(textdataal.Text)

        'devo controllare se le stringhe sono vuote e settarle su nothing, altrimenti le esclude nella query
        Dim ordine As String = textordine.Text
        If String.IsNullOrEmpty(textordine.Text) Then ordine = Nothing
        Dim ordinesap As String = textordineSAP.Text
        If String.IsNullOrEmpty(textordineSAP.Text) Then ordinesap = Nothing
        Dim ordine_cliente As String = ordinecliente.Text
        If String.IsNullOrEmpty(ordinecliente.Text) Then ordine_cliente = Nothing
        Dim offerta As String = textofferta.Text
        If String.IsNullOrEmpty(textofferta.Text) Then offerta = Nothing
        Dim offertaest As String = textoffertaest.Text
        If String.IsNullOrEmpty(textoffertaest.Text) Then offertaest = Nothing
        Dim rif_impianto As String = textrifimpianto.Text
        If String.IsNullOrEmpty(textrifimpianto.Text) Then rif_impianto = Nothing

        Dim annull As Boolean = checkAnnull.Checked

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

        Dim canale As Nullable(Of Integer)
        If canalID.SelectedValue = "" Then
            canale = Nothing
        Else
            canale = canalID.SelectedValue
        End If

        Dim prodotto As Nullable(Of Integer)
        If DDLproduct.SelectedValue = "" Then
            prodotto = Nothing
        Else
            prodotto = DDLproduct.SelectedValue
        End If

        Dim strConnString As String = ConfigurationManager.ConnectionStrings("AcomdbConnectionString").ConnectionString
        Dim con As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure

        'definisco stored procedure e parametri per gridvisit
        cmd.CommandText = "dbo.CercaOrdini"
        cmd.Parameters.Add("@datain", SqlDbType.Date).Value = datain
        cmd.Parameters.Add("@dataout", SqlDbType.Date).Value = dataout
        cmd.Parameters.Add("@agentID", SqlDbType.Int).Value = agent
        cmd.Parameters.Add("@clientID", SqlDbType.Int).Value = cliente
        cmd.Parameters.Add("@officeID", SqlDbType.Int).Value = filiale
        cmd.Parameters.Add("@canalID", SqlDbType.Int).Value = canale
        cmd.Parameters.Add("@productID", SqlDbType.Int).Value = prodotto
        cmd.Parameters.Add("@riferimento", SqlDbType.VarChar).Value = rif_impianto
        cmd.Parameters.Add("@offerta", SqlDbType.VarChar).Value = offerta
        cmd.Parameters.Add("@offerta_est", SqlDbType.VarChar).Value = offertaest
        cmd.Parameters.Add("@ordine", SqlDbType.VarChar).Value = ordine
        cmd.Parameters.Add("@ordinesap", SqlDbType.VarChar).Value = ordinesap
        cmd.Parameters.Add("@ordinecliente", SqlDbType.VarChar).Value = ordine_cliente
        cmd.Parameters.Add("@annull", SqlDbType.Bit).Value = annull

        Try
            con.Open()
            GridViewOrder.EmptyDataText = "Nessun dato disponibile"
            GridViewOrder.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            GridViewOrder.DataBind()
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        Finally
            con.Close()
        End Try

    End Sub

    Public Function Get_office_from_client()
        Try
            Return BLL.Get_office_from_client(clienteID)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub clienteID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Try
            officeID.Items.AddRange(BLL.Get_office_from_client(TableFindOrder))
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        End Try

    End Sub

    Public Function Get_agents()
        Try
            Return BLL.Get_agent
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_clients()
        Try
            Return BLL.Get_client
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_canal()
        Try
            Return BLL.Get_canal
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_families()
        Try
            Return BLL.Get_families
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_products()
        Try
            Return BLL.Get_products
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function


    Protected Sub GridViewOrder_DataBound(sender As Object, e As EventArgs)

        Dim grid As GridView = sender
        Dim prodotto As Label

        For Each row As GridViewRow In GridViewOrder.Rows
            prodotto = row.FindControl("num_product")
            If prodotto.Text = 0 Then
                row.BackColor = Drawing.Color.Yellow
            End If
        Next

    End Sub
End Class
