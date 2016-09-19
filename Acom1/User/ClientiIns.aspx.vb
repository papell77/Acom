Imports Acom1.Models
Imports Acom1.DAL
Imports Acom1.BLL
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports System.Globalization
Imports System.Data.Entity.Infrastructure

Public Class ClientiIns1
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id As Integer = Request.QueryString("ID")

        'se la pagina viene caricata senza riferimento all'id cliente, apro in modalità inserimento
        If id = 0 Then

            FormClientIns.ChangeMode(DetailsViewMode.Insert)

        End If

        If Not FormClientIns.CurrentMode = FormViewMode.ReadOnly Then
            btn_stampa_anagrafica.Visible = False
        End If

    End Sub

    Private Sub Page_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

        If FormClientIns.CurrentMode() = DetailsViewMode.Insert Then

            contact_panel.Visible = False

        End If

    End Sub


    Protected Sub cmd_insert_Click(sender As Object, e As EventArgs)

        FormClientIns.InsertItem(True)

    End Sub

    Protected Sub cmd_nuovo_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/User/ClientiIns")
    End Sub

    Protected Sub cmd_modifica_Click(sender As Object, e As EventArgs)
        FormClientIns.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub cmd_update_Click(sender As Object, e As EventArgs)
        Try
            FormClientIns.UpdateItem(True)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        End Try

    End Sub

    Protected Sub cmd_cancel_Click(sender As Object, e As EventArgs)
        If FormClientIns.CurrentMode = FormViewMode.Insert Then
            Response.Redirect("~/User/ClientiIns")
        Else
            FormClientIns.ChangeMode(FormViewMode.ReadOnly)
        End If

    End Sub

    ' Il parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    ' o essere decorato con un attributo del provider di valori, ad esempio <QueryString>ByVal id as Integer
    Public Function FormClientIns_GetItem(<QueryString("ID")> ByVal id As Nullable(Of Integer)) As IQueryable(Of ViewClientDettaglio)
        Dim context As New AcomLinqContextDataContext
        Dim query = From p In context.ViewClientDettaglio
                    Where p.ID = id
                    Select p

        'il codice cliente mi serve come controllo in fase di update dell'anagrafica
        Dim query_code = context.ViewClientDettaglio.Where(Function(p) p.ID = id).Select(Function(p) p.codice).FirstOrDefault
        ViewState("codice_cliente") = query_code

        Try
            Return query
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub FormClientIns_UpdateItem(ByVal id As Integer)
        Dim ctx As New AcomContext
        Dim item As Acom1.Models.client = Nothing
        item = ctx.clients.Where(Function(p) p.ID = id).FirstOrDefault

        If item Is Nothing Then
            ' Elemento non trovato
            ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
            Return
        End If

        item.updated_by = User.Identity.Name
        item.data_aggiornamento = Today

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                ctx.SaveChanges()
            Catch ex As DbUpdateConcurrencyException
                errmsg.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
                errmsg.Visible = True
            Catch ex1 As Exception
                errmsg.Text = ex1.Message
                errmsg.Visible = True
            End Try

        Else
            errmsg.Text = "Errore nel modello, aggiornamento non riuscito"
            errmsg.Visible = True
        End If



    End Sub



    Protected Sub FormClientIns_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)

        If e.AffectedRows = 0 Then
            e.KeepInEditMode = True
        End If

    End Sub

    Public Sub FormClientIns_InsertItem()

        Dim item = New Acom1.Models.client()

        Dim code As TextBox = FormClientIns.FindControl("codice")
        Dim ragsoc As TextBox = FormClientIns.FindControl("ragione_sociale")
        Dim cf As TextBox = FormClientIns.FindControl("CF")
        Dim iva As TextBox = FormClientIns.FindControl("piva")
        Dim ivacee As TextBox = FormClientIns.FindControl("pivaCEE")
        Dim prov As DropDownList = FormClientIns.FindControl("provinciaID")
        Dim com As DropDownList = FormClientIns.FindControl("comuneID")
        Dim cap As TextBox = FormClientIns.FindControl("CAP")
        Dim indir As TextBox = FormClientIns.FindControl("indirizzo")
        Dim canal As DropDownList = FormClientIns.FindControl("canalID")
        Dim tel As TextBox = FormClientIns.FindControl("telefono")
        Dim mail As TextBox = FormClientIns.FindControl("email")
        Dim note As TextBox = FormClientIns.FindControl("note")
        Dim fatture As TextBox = FormClientIns.FindControl("invio_fattura")
        Dim banca As TextBox = FormClientIns.FindControl("banca")
        Dim iban As TextBox = FormClientIns.FindControl("iban")
        Dim fatturato As TextBox = FormClientIns.FindControl("fatturato")
        Dim fatt_potenz As TextBox = FormClientIns.FindControl("fatturato_potenz")
        Dim dipendenti As TextBox = FormClientIns.FindControl("dipendenti")
        Dim fido_r As TextBox = FormClientIns.FindControl("fido_richiesto")
        Dim fido_c As TextBox = FormClientIns.FindControl("fido_concesso")
        Dim scad_fido As TextBox = FormClientIns.FindControl("scadenza_fido")
        Dim fondaz As TextBox = FormClientIns.FindControl("fondazione")
        Dim possed As TextBox = FormClientIns.FindControl("possedimenti")
        'Dim annull As CheckBox = FormClientIns.FindControl("annull")
        Dim pay As DropDownList = FormClientIns.FindControl("pagamento")
        Dim trasp As DropDownList = FormClientIns.FindControl("trasporto")
        Dim agt As DropDownList = FormClientIns.FindControl("agentID")

        'item.codice = code.Text
        item.ragione_sociale = ragsoc.Text
        item.CF = cf.Text
        item.piva = iva.Text
        item.pivaCEE = ivacee.Text
        item.cap = cap.Text
        item.indirizzo = indir.Text
        item.telefono = tel.Text
        item.email = mail.Text
        item.note = note.Text
        item.invio_fattura = fatture.Text
        item.banca = banca.Text
        item.iban = iban.Text
        item.possedimenti = possed.Text
        'item.annull = annull.Checked
        item.created_by = User.Identity.Name
        item.created_date = Today

        'un po' di verifiche su dropdownlist e date
        If Not prov.SelectedValue = "" Then
            item.provinciaID = prov.SelectedValue
        End If
        If Not com.SelectedValue = "" Then
            item.comuneID = com.SelectedValue
        End If
        If Not canal.SelectedValue = "" Then
            item.canalID = canal.SelectedValue
        End If
        If Not agt.SelectedValue = "" Then
            item.agentID = agt.SelectedValue
        End If
        If Not scad_fido.Text = "" Then
            Dim scadfido As Date = ConvertDate(scad_fido.Text)
            item.scadenza_fido = scadfido
        End If
        If Not fondaz.Text = "" Then
            Dim fond_date As Date = ConvertDate(fondaz.Text)
            item.fondazione = fond_date
        End If
        If Not pay.SelectedValue = "" Then
            item.paymentID = pay.SelectedValue
        End If
        If Not trasp.SelectedValue = "" Then
            item.transportID = trasp.SelectedValue
        End If
        If Not fatturato.Text = "" Then
            item.fatturato = fatturato.Text
        End If
        If Not fatt_potenz.Text = "" Then
            item.fatturato_potenz = fatt_potenz.Text
        End If
        If Not dipendenti.Text = "" Then
            item.dipendenti = dipendenti.Text
        End If
        If Not fido_c.Text = "" Then
            item.fido_concesso = fido_c.Text
        End If
        If Not fido_r.Text = "" Then
            item.fido_richiesto = fido_r.Text
        End If

        Dim ctx As New AcomContext
        If Not String.IsNullOrEmpty(code.Text) Then
            item.codice = code.Text
        Else 'il codice non è stato inserito
            Dim rand As String = BLL.GenRandom 'serve per generare un codice cliente casuale se non fornito
            Dim query = ctx.clients.Where(Function(p) p.codice = rand).Select(Function(p) p.codice).FirstOrDefault
            Do Until query Is Nothing
                rand = BLL.GenRandom
                query = ctx.clients.Where(Function(p) p.codice = rand).Select(Function(p) p.codice).FirstOrDefault
            Loop
            item.codice = rand
        End If

        'TryUpdateModel(item)
        If ModelState.IsValid Then

            Try
                ctx.clients.Add(item)
                ctx.SaveChanges()
                Response.Redirect("~/User/ClientiIns?ID=" & item.ID)
            Catch ex1 As System.Data.Entity.Infrastructure.DbUpdateException
                errmsg.Text = "Attenzione il cliente codice " & item.codice & " esiste già"
                errmsg.Visible = True
                Return
            Catch ex As Exception
                errmsg.Text = ex.Message
                errmsg.Visible = True
                Return
            End Try

        Else
            errmsg.Text = "Attenzione, modello non valido, nessun inserimento effettuato"
            errmsg.Visible = True
        End If

    End Sub

    Protected Sub FormClientIns_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        If e.AffectedRows < 0 Then
            e.KeepInInsertMode = True
        End If
    End Sub

    'usata per popolare drop down provincia
    Public Function Get_provincia() As List(Of provincia)
        Try
            Return BLL.Get_provincia
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub provinciaID_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim DDLcomuni As DropDownList = FormClientIns.FindControl("comuneID")
        DDLcomuni.Items.AddRange(BLL.Get_comune_from_provincia(FormClientIns))

    End Sub

    'usata per popolare drop down comuni in fase di editing
    Public Function Get_comune() As List(Of comune)
        Try
            Return BLL.Get_comune
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub comuneID_DataBinding(sender As Object, e As EventArgs)

        Dim DDLcomuni As DropDownList = FormClientIns.FindControl("comuneID")
        DDLcomuni.Items.AddRange(BLL.Get_comune_from_provincia(FormClientIns))

    End Sub

    Protected Sub comuneID_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim comune As DropDownList = sender
        Dim cap As TextBox = FormClientIns.FindControl("cap")

        If Not comune.SelectedValue = "" Then 'imposto il cap
            Dim ctx As New AcomContext
            Dim query = ctx.comuni.Where(Function(p) p.ID = comune.SelectedValue).Select(Function(c) c.CAP).First
            cap.Text = query
        End If

    End Sub

    'usata per popolare dropdown canali
    Public Function Get_canale() As List(Of canal)
        Dim mode As FormViewMode = FormClientIns.CurrentMode
        Try
            Return BLL.Get_canal(mode)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub canalID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim canalval As DropDownList = FormClientIns.FindControl("canalID")
        Dim canallabel As Label = FormClientIns.FindControl("canal_annull")
        If canalval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            canallabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query = ctx.canals.Where(Function(p) p.ID = canalval.SelectedValue).FirstOrDefault

        If query.annull = True Then
            canallabel.Visible = True
        Else
            canallabel.Visible = False
        End If
    End Sub

    Public Function Get_agente() As List(Of agent)
        Dim mode As FormViewMode = FormClientIns.CurrentMode
        Try
            Return BLL.Get_agent(mode)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function



    Protected Sub agentID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim agentval As DropDownList = sender
        Dim agentlabel As Label = FormClientIns.FindControl("agent_annull")
        If agentval.SelectedValue = "" Then
            agentlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query = ctx.agents.Where(Function(p) p.ID = agentval.SelectedValue).FirstOrDefault

        If query.annull = True Then
            agentlabel.Visible = True
        Else
            agentlabel.Visible = False
        End If
    End Sub

    Public Function Get_payment() As List(Of payment)

        Dim mode As FormViewMode = FormClientIns.CurrentMode
        Try
            Return BLL.Get_payment(mode)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub pagamento_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim pagval As DropDownList = FormClientIns.FindControl("pagamento")
        Dim pagamlabel As Label = FormClientIns.FindControl("pagam_annull")
        If pagval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            pagamlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query = ctx.payments.Where(Function(p) p.ID = pagval.SelectedValue).FirstOrDefault

        If query.annull = True Then
            pagamlabel.Visible = True
        Else
            pagamlabel.Visible = False
        End If
    End Sub

    Public Function Get_transport() As List(Of transport)
        Dim mode As FormViewMode = FormClientIns.CurrentMode
        Try
            Return BLL.Get_transport(mode)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub trasporto_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim traspval As DropDownList = FormClientIns.FindControl("trasporto")
        Dim trasplabel As Label = FormClientIns.FindControl("trasp_annull")
        If traspval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            trasplabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query = ctx.transports.Where(Function(p) p.ID = traspval.SelectedValue).FirstOrDefault

        If query.annull = True Then
            trasplabel.Visible = True
        Else
            trasplabel.Visible = False
        End If

    End Sub



    Protected Sub duplicate_code_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim code As TextBox = FormClientIns.FindControl("codice")
        Dim validator As CustomValidator = FormClientIns.FindControl("duplicate_code")

        'Devo controllare che in fase di edit non venga cancellato il codice cliente, perchè in edit non genero il codice temporaneo
        If FormClientIns.CurrentMode = FormViewMode.Insert Then
            If String.IsNullOrEmpty(code.Text) Then
                args.IsValid = True
                Return
            Else
                validator.ErrorMessage = "Inserire un codice cliente"
                args.IsValid = False
                Return
            End If
        End If

        'se il codice presente nel viewstate, che proviene dalla pagina di dettaglio, è uguale al testo allora salto la convalida
        If code.Text = ViewState("codice_cliente") Then
            args.IsValid = True
            Return
        End If

        Dim ctx As New AcomContext
        Dim query As String

        Try
            query = ctx.clients.Where(Function(p) p.codice = args.Value).Select(Function(c) c.codice).FirstOrDefault
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return
        End Try

        If query Is Nothing Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If

    End Sub

    Protected Sub btn_stampa_anagrafica_Click(sender As Object, e As EventArgs)
        Dim id As Integer = Request.QueryString("ID")
        If id = 0 Then
            errmsg.Text = "Inserire un nuovo cliente"
            errmsg.Visible = True
            Return
        Else
            Try
                Dim bytes As Byte()
                bytes = BLL.GeneraPdfCliente(id, "StampaCliente", "ClientDataSet", "ClientReport")
            Catch ex As Exception
                errmsg.Text = ex.Message
                errmsg.Visible = True
                Return
            End Try
        End If

    End Sub

    Protected Sub ListViewContacts_ItemInserting(sender As Object, e As ListViewInsertEventArgs)
        'devo passare il valore dell'ID cliente al parametro @clientID nella query di inserimento nuovo contatto
        SqlDataSourceContacts.InsertParameters("clientID").DefaultValue = Request.QueryString("ID")
        SqlDataSourceContacts.InsertParameters("created_by").DefaultValue = User.Identity.Name
        SqlDataSourceContacts.InsertParameters("created_date").DefaultValue = Today
    End Sub

    Protected Sub SqlDataSourceContacts_Updating(sender As Object, e As SqlDataSourceCommandEventArgs)
        e.Command.Parameters("@updated_by").Value = User.Identity.Name
        e.Command.Parameters("@updated_date").Value = Today
    End Sub

End Class