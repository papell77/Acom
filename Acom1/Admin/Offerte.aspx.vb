Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports Microsoft.AspNet.Identity
Imports System.Web.ModelBinding
Imports System.Data.SqlClient

Public Class Offerte
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'se non sono in postback imposto la data fine ricerca a oggi
        If Not Page.IsPostBack Then
            textdataal.Text = Today
        End If


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

    Public Function Get_office_from_client()
        Try
            Return BLL.Get_office_from_client(clienteID)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub clientID_SelectedIndexChanged(sender As Object, e As EventArgs)

        Try
            officeID.Items.AddRange(BLL.Get_office_from_client(TableFindOffer))
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        End Try

    End Sub


    Protected Sub btnCercaVisita_Click(sender As Object, e As EventArgs)

        Dim datain As Date = ConvertDate(textdatadal.Text)
        Dim dataout As Date = ConvertDate(textdataal.Text)

        'controllo se le stringhe sono vuote e le setto a nothing, altrimenti non le vede nella query
        Dim rif As String = textriferimento.Text
        If String.IsNullOrEmpty(textriferimento.Text) Then rif = Nothing
        Dim offer As String = textpreventivo.Text
        If String.IsNullOrEmpty(textpreventivo.Text) Then offer = Nothing
        Dim offerest As String = textofferta_est.Text
        If String.IsNullOrEmpty(textofferta_est.Text) Then offerest = Nothing
        Dim stato As String = DDLstato.SelectedValue
        If DDLstato.SelectedValue = "" Then stato = Nothing
        Dim annull As Boolean = CheckAnnull.Checked

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
        cmd.CommandText = "dbo.CercaOfferta"
        cmd.Parameters.Add("@datain", SqlDbType.Date).Value = datain
        cmd.Parameters.Add("@dataout", SqlDbType.Date).Value = dataout
        cmd.Parameters.Add("@agente", SqlDbType.Int).Value = agent
        cmd.Parameters.Add("@cliente", SqlDbType.Int).Value = cliente
        cmd.Parameters.Add("@filiale", SqlDbType.Int).Value = filiale
        cmd.Parameters.Add("@riferimento", SqlDbType.VarChar).Value = rif
        cmd.Parameters.Add("@preventivo", SqlDbType.VarChar).Value = offer
        cmd.Parameters.Add("@preventivo_est", SqlDbType.VarChar).Value = offerest
        cmd.Parameters.Add("@famiglia", SqlDbType.Int).Value = famiglia
        cmd.Parameters.Add("@prodotto", SqlDbType.Int).Value = prodotto
        cmd.Parameters.Add("@stato", SqlDbType.VarChar).Value = stato
        cmd.Parameters.Add("@annull", SqlDbType.Bit).Value = annull

        Try
            con.Open()
            GridViewOffer.EmptyDataText = "Nessun dato disponibile"
            GridViewOffer.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            GridViewOffer.DataBind()
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        Finally
            con.Close()
        End Try


    End Sub

End Class