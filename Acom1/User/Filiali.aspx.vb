Imports Acom1.Models
Imports Acom1.DAL
Imports System.Web.ModelBinding

Public Class Filiali
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    'per popolare la dropdown provincie
    Public Function Get_provincie() As List(Of provincia)
        Return BLL.Get_provincia
    End Function

    'per popolare la dropdown comuni in assenza di un valore selezionato di provincia
    Public Function Get_comuni() As List(Of comune)
        Return BLL.Get_comune
    End Function

    'per popolare la dropdown comuni in presenza di un valore selezionato di provincia
    Protected Sub DDLprov_SelectedIndexChanged(sender As Object, e As EventArgs)

        comuneID.Items.AddRange(BLL.Get_comune_from_provincia(TableFindClient))

    End Sub

    'per popolare la dropdown canali
    Public Function Get_canals() As List(Of canal)
        Return BLL.Get_canal()
    End Function

    Public Function Get_agents() As List(Of agent)
        Return BLL.Get_agent
    End Function

    'per popolare la gridview clienti tramite ViewClient
    Public Function GridViewOffice_GetData(<Control("textRagSoc")> ragsoc As String, _
                                            <Control("textpiva")> piva As String, _
                                            <Control("provinciaID")> prov As Nullable(Of Integer), _
                                            <Control("comuneID")> comun As Nullable(Of Integer), _
                                            <Control("DDLcanale")> canal As Nullable(Of Integer), _
                                            <Control("DDLagente")> agent As Nullable(Of Integer), _
                                            <Control("textphone")> phone As String, _
                                            <Control("textNomeFiliale")> filiale As String) As IQueryable

        'se nessuno dei campi di ricerca è compilato non visualizzo niente
        If String.IsNullOrEmpty(ragsoc) And _
            String.IsNullOrEmpty(piva) And _
            Not prov.HasValue And _
            Not comun.HasValue And _
            Not canal.HasValue And _
            Not agent.HasValue And _
            String.IsNullOrEmpty(phone) And _
            String.IsNullOrEmpty(filiale) Then

            Return Nothing
            Exit Function
        End If

        Dim context As New AcomLinqContextDataContext
        Dim ctx As New AcomContext
        'Dim query = From p In context.ViewOffice Select p
        Dim query = ctx.offices.Include("client").Include("comune").Include("provincia")

        'verifico quai campi di ricerca sono compilati e aggiungo clausole where alla query
        If Not String.IsNullOrEmpty(ragsoc) Then
            query = query.Where(Function(p) p.client.ragione_sociale.Contains(ragsoc))
        End If

        If Not String.IsNullOrEmpty(piva) Then
            query = query.Where(Function(p) p.client.piva.Contains(piva))
        End If

        If prov.HasValue Then
            query = query.Where(Function(p) p.provinciaID = prov)
        End If

        If comun.HasValue Then
            query = query.Where(Function(p) p.comuneID = comun)
        End If

        If canal.HasValue Then
            query = query.Where(Function(p) p.client.canalID = canal)
        End If

        If agent.HasValue Then
            query = query.Where(Function(p) p.client.agentID = agent)
        End If

        If Not String.IsNullOrEmpty(phone) Then
            query = query.Where(Function(p) p.telefono.Contains(phone))
        End If

        If Not String.IsNullOrEmpty(filiale) Then
            query = query.Where(Function(p) p.nome.Contains(filiale))
        End If

        If Not query Is Nothing Then
            Dim result = query.Select(Function(p) New With {Key .ID = p.ID, .clientID = p.clientID, .ragione_sociale = p.client.ragione_sociale, .nome = p.nome, .provincia = p.provincia.nome, .comune = p.comune.nome, .indirizzo = p.indirizzo, .cap = p.cap, .telefono = p.telefono, .email = p.email, .agent = p.client.agent.name, .canal = p.client.canal.canal_code})
            Return result
        End If

        Return query

    End Function

    'richiamo il binding delle grid client e office
    Protected Sub btnCercaCliente_Click(sender As Object, e As EventArgs) Handles btnCercaCliente.Click

        GridViewOffice.DataBind()

    End Sub

End Class