Imports System
Imports Acom1.BLL
Imports Acom1.DAL
Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports System.Globalization
Imports AjaxControlToolkit
Imports System.Data.Entity.Infrastructure


Public Class OfferteIns1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not Page.IsPostBack Then

            Dim id As Integer = Request.QueryString("ID")

            'se la pagina viene caricata senza riferimento all'id offerta, apro in modalità inserimento
            If id = 0 Then

                FormOfferIns.ChangeMode(DetailsViewMode.Insert)
                UpdatePanelInsertRow.Visible = False 'tutto il pannello di inserimento di nuovi record viene nascosto

            End If

            'se sono in modalità insert 
            If FormOfferIns.CurrentMode = DetailsViewMode.Insert Then

            End If


        End If

    End Sub

    Private Sub OfferteIns1_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

    End Sub


    ' Il parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    ' o essere decorato con un attributo del provider di valori, ad esempio <QueryString>ByVal id as Integer
    Public Function FormOfferIns_GetItem(<QueryString("ID")> ByVal id As Nullable(Of Integer)) As Object
        Dim context As New AcomLinqContextDataContext
        Dim query As IQueryable(Of ViewOfferInsert)

        Try
            query = context.ViewOfferInsert.Where(Function(p) p.ID = id)
            'il viewstate serve per memorizzare i valori di clientID e numero offerta da utilizzare in duplica preventivo e crea nuova versione
            ViewState("clientID") = query.Select(Function(p) p.clientID).FirstOrDefault
            ViewState("offer_num") = query.Select(Function(p) p.offer_num).FirstOrDefault
            ViewState("offer_code") = query.Select(Function(p) p.offer_code).FirstOrDefault
            ViewState("agentID") = query.Select(Function(p) p.agentID).FirstOrDefault
            ViewState("familyID") = query.Select(Function(p) p.familyID).FirstOrDefault

            Return query

        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Sub FormOfferIns_InsertItem()
        Dim ctx As New AcomContext
        Dim item As New Acom1.Models.offer()

        Dim offer_code As TextBox = FormOfferIns.FindControl("offer_code")
        Dim agent As DropDownList = FormOfferIns.FindControl("agentID")
        Dim data As TextBox = FormOfferIns.FindControl("data")
        Dim client As DropDownList = FormOfferIns.FindControl("clienteID")
        Dim office As DropDownList = FormOfferIns.FindControl("officeID")
        Dim contact As DropDownList = FormOfferIns.FindControl("contactID")
        Dim riferimento As TextBox = FormOfferIns.FindControl("riferimento")
        Dim family As DropDownList = FormOfferIns.FindControl("familyID")
        Dim stato As DropDownList = FormOfferIns.FindControl("stato")
        Dim importo As TextBox = FormOfferIns.FindControl("importo")
        Dim consegna As TextBox = FormOfferIns.FindControl("consegna")
        Dim offer_est As TextBox = FormOfferIns.FindControl("offerta_est")
        Dim pay As DropDownList = FormOfferIns.FindControl("paymentID")
        Dim trasp As DropDownList = FormOfferIns.FindControl("transportID")
        Dim costo_trasp As TextBox = FormOfferIns.FindControl("costo_trasp")
        Dim resa As DropDownList = FormOfferIns.FindControl("resaID")
        Dim garanzia As DropDownList = FormOfferIns.FindControl("garanziaID")
        Dim validita As TextBox = FormOfferIns.FindControl("data_val")
        Dim imballo As TextBox = FormOfferIns.FindControl("imballo")
        Dim note As TextBox = FormOfferIns.FindControl("note")
        'Dim annull As CheckBox = FormOfferIns.FindControl("annull")
        Dim offer_num As TextBox = FormOfferIns.FindControl("offer_num")
        Dim offer_vers As TextBox = FormOfferIns.FindControl("offer_vers")

        Dim dataoffer As Date = ConvertDate(data.Text)
        Dim datavalid As Date = ConvertDate(validita.Text)

        If item Is Nothing Then
            ModelState.AddModelError("", "Nessun elemento inserito")
            Return
        Else
            'client è campo obbligatorio
            item.clientID = client.SelectedValue
            'controllo se le altre DDL sono state selezionate
            If Not office.SelectedValue = "" Then
                item.officeID = office.SelectedValue
            End If
            If Not contact.SelectedValue = "" Then
                item.contactID = contact.SelectedValue
            End If
            If Not agent.SelectedValue = "" Then
                item.agentID = agent.SelectedValue
            End If
            If Not family.SelectedValue = "" Then
                item.familyID = family.SelectedValue
            End If
            If Not stato.SelectedValue = "" Then
                item.stato = stato.SelectedValue
            End If
            If Not pay.SelectedValue = "" Then
                item.paymentID = pay.SelectedValue
            End If
            If Not trasp.SelectedValue = "" Then
                item.transportID = trasp.SelectedValue
            End If
            If Not resa.SelectedValue = "" Then
                item.resaID = resa.SelectedValue
            End If
            If Not garanzia.SelectedValue = "" Then
                item.garanziaID = garanzia.SelectedValue
            End If

            item.data = dataoffer
            item.riferimento = riferimento.Text

            If IsNumeric(importo.Text) Then
                item.importo = importo.Text
            Else
                item.importo = Nothing
            End If
            item.consegna = consegna.Text
            item.offer_est = offer_est.Text
            If IsNumeric(costo_trasp.Text) Then
                item.costo_trasporto = costo_trasp.Text
            Else
                item.costo_trasporto = Nothing
            End If
            item.data_valid = datavalid
            item.imballo = imballo.Text
            item.note = note.Text
            'item.annull = annull.Checked
            item.created_by = User.Identity.Name
            item.created_date = Now

            Dim offerta As New offer
            Try
                offerta = BLL.new_offer
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try

            item.offer_code = offerta.offer_code
            item.offer_num = offerta.offer_num
            item.offer_vers = offerta.offer_vers

            ctx.offers.Add(item)
        End If

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                ctx.SaveChanges()
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
            End Try

            Dim id = item.ID
            Response.Redirect("~/User/OfferteIns?ID=" & id)

        End If

    End Sub

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub FormOfferIns_UpdateItem(ByVal id As Integer)
        Dim ctx As New AcomContext
        Dim item As Acom1.Models.offer = Nothing

        Try
            item = ctx.offers.Where(Function(p) p.ID = id).FirstOrDefault
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        item.updated_by = User.Identity.Name
        item.updated_date = Now

        If item Is Nothing Then
            ' Elemento non trovato
            ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
            Return
        End If

        TryUpdateModel(item)
        If ModelState.IsValid Then

            Try
                ctx.SaveChanges()
            Catch ex As DbUpdateConcurrencyException
                errormsg.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
                errormsg.Visible = True
            Catch ex1 As Exception
                errormsg.Text = ex1.Message
                errormsg.Visible = True
            End Try
        Else
            ModelState.AddModelError("", "Errore nel modello dati, nessun dato modificato")
        End If

    End Sub

    Protected Sub FormOfferIns_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        If e.AffectedRows < 0 Then
            e.KeepInInsertMode = True

        End If
    End Sub

    Protected Sub FormOfferIns_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        If e.AffectedRows = 0 Then
            e.KeepInEditMode = True
        End If
    End Sub

    Protected Sub cmd_modifica_Click(sender As Object, e As EventArgs)
        FormOfferIns.ChangeMode(FormViewMode.Edit)
    End Sub

    Protected Sub cmd_aggiorna_Click(sender As Object, e As EventArgs)
        FormOfferIns.UpdateItem(True)
    End Sub

    Protected Sub cmd_cancella_Click(sender As Object, e As EventArgs)
        If FormOfferIns.CurrentMode = FormViewMode.Insert Then
            Response.Redirect("~/User/OfferteIns")
        Else
            FormOfferIns.ChangeMode(FormViewMode.ReadOnly)
        End If
    End Sub

    Protected Sub cmd_insert_Click(sender As Object, e As EventArgs)
        FormOfferIns.InsertItem(True)
    End Sub

    Public Function Get_agent() As List(Of agent)
        Try
            Return BLL.Get_agent(FormOfferIns.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try
    End Function

    Protected Sub agentID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim agentval As DropDownList = FormOfferIns.FindControl("agentID")
        Dim agentlabel As Label = FormOfferIns.FindControl("agent_annull")
        If agentval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            agentlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New agent

        Try
            query = ctx.agents.Where(Function(p) p.ID = agentval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        If query.annull = True Then
            agentlabel.Visible = True
        Else
            agentlabel.Visible = False
        End If

    End Sub

    Public Function Get_client() As List(Of client)
        Try
            Return BLL.Get_client(FormOfferIns.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub DDLClient_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim clientval As DropDownList = FormOfferIns.FindControl("clienteID")
        Dim clientlabel As Label = FormOfferIns.FindControl("client_annull")

        If clientval.SelectedValue = "" Then
            clientlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New client

        Try
            query = ctx.clients.Where(Function(p) p.ID = clientval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If FormOfferIns.CurrentMode = DetailsViewMode.Edit Then

            If query.annull = True Then
                clientlabel.Visible = True
            Else
                clientlabel.Visible = False
            End If

        End If

        'popolo le dropdown office e contact in base alla selezione
        Dim DDLoffice As DropDownList = FormOfferIns.FindControl("officeID")
        Dim DDLcontact As DropDownList = FormOfferIns.FindControl("contactID")
        DDLoffice.Items.AddRange(BLL.Get_office_from_client(FormOfferIns))
        DDLcontact.Items.AddRange(BLL.Get_contact_from_client(FormOfferIns))

        'seleziono il valore di payment e transport nelle rispettive DDL in base al cliente selezionato
        Dim DDLpayment As DropDownList = FormOfferIns.FindControl("paymentID")
        Dim DDLtransport As DropDownList = FormOfferIns.FindControl("transportID")
        If Not query.paymentID Is Nothing Then
            DDLpayment.SelectedValue = query.paymentID
        End If
        If Not query.transportID Is Nothing Then
            DDLtransport.SelectedValue = query.transportID
        End If

    End Sub

    Public Function Get_office() As List(Of office)
        Try
            Return BLL.Get_office(FormOfferIns.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub officeID_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim officeval As DropDownList = FormOfferIns.FindControl("officeID")
        Dim officelabel As Label = FormOfferIns.FindControl("office_annull")
        Dim DDLcontact As DropDownList = FormOfferIns.FindControl("contactID")

        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If FormOfferIns.CurrentMode = DetailsViewMode.Edit Then

            If officeval.SelectedValue = "" Then
                officelabel.Visible = False
                'ripopolo la dropdown contatti con ciò che è selezionato in cliente
                DDLcontact.Items.AddRange(BLL.Get_contact_from_client(FormOfferIns))
                Exit Sub
            End If

            Dim ctx As New AcomContext
            Dim query As New office

            Try
                query = ctx.offices.Where(Function(p) p.ID = officeval.SelectedValue).FirstOrDefault()
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
            End Try

            If query.annull = True Then
                officelabel.Visible = True
            Else
                officelabel.Visible = False
            End If

            'popolo la dropdown contacts in base al valore di office selezionato
            DDLcontact.Items.AddRange(BLL.Get_contact_from_client(FormOfferIns))

        ElseIf FormOfferIns.CurrentMode = DetailsViewMode.Insert Then '

            'popolo la dropdown contacts in base al valore di office selezionato
            DDLcontact.Items.AddRange(BLL.Get_contact_from_client(FormOfferIns))

        End If

    End Sub

    Protected Sub DDLOffice_DataBinding(sender As Object, e As EventArgs)

        Dim DDLoffice As DropDownList = FormOfferIns.FindControl("officeID")
        Try
            DDLoffice.Items.AddRange(BLL.Get_office_from_client(FormOfferIns))
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

    End Sub

    Public Function Get_contact() As List(Of contactname)
        Try
            Return BLL.Get_contact(FormOfferIns.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub DDLContact_DataBinding(sender As Object, e As EventArgs)

        Dim DDLcontact As DropDownList = FormOfferIns.FindControl("contactID")
        Try
            DDLcontact.Items.AddRange(BLL.Get_contact_from_client(FormOfferIns))
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

    End Sub

    Protected Sub contactID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim contactval As DropDownList = FormOfferIns.FindControl("contactID")
        Dim contactlabel As Label = FormOfferIns.FindControl("contact_annull")
        If contactval.SelectedValue = "" Then
            contactlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New contactname
        Try
            query = ctx.contacts.Where(Function(p) p.ID = contactval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        If query.annull = True Then
            contactlabel.Visible = True
        Else
            contactlabel.Visible = False
        End If

    End Sub

    Public Function Get_families() As List(Of family)
        Try
            Return BLL.Get_families(FormOfferIns.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub familyID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim familyval As DropDownList = FormOfferIns.FindControl("familyID")
        Dim familylabel As Label = FormOfferIns.FindControl("family_annull")
        If familyval.SelectedValue = "" Then
            familylabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New family

        Try
            query = ctx.family.Where(Function(p) p.ID = familyval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        If query.annull = True Then
            familylabel.Visible = True
        Else
            familylabel.Visible = False
        End If
    End Sub

    Public Function Get_payment() As List(Of payment)
        Dim mode As DetailsViewMode = FormOfferIns.CurrentMode
        Try
            Return BLL.Get_payment(mode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub paymentID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim pagval As DropDownList = FormOfferIns.FindControl("paymentID")
        Dim pagamlabel As Label = FormOfferIns.FindControl("pagam_annull")
        If pagval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            pagamlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New payment

        Try
            query = ctx.payments.Where(Function(p) p.ID = pagval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        If query.annull = True Then
            pagamlabel.Visible = True
        Else
            pagamlabel.Visible = False
        End If

    End Sub

    Public Function Get_transport() As List(Of transport)
        Dim mode As DetailsViewMode = FormOfferIns.CurrentMode
        Try
            Return BLL.Get_transport(mode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub transportID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim traspval As DropDownList = FormOfferIns.FindControl("transportID")
        Dim trasplabel As Label = FormOfferIns.FindControl("trasp_annull")
        If traspval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            trasplabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New transport
        Try
            query = ctx.transports.Where(Function(p) p.ID = traspval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        If query.annull = True Then
            trasplabel.Visible = True
        Else
            trasplabel.Visible = False
        End If


    End Sub

    Public Function Get_resa()
        Try
            Return BLL.Get_resa(FormOfferIns.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub resaID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim resaval As DropDownList = FormOfferIns.FindControl("resaID")
        Dim resalabel As Label = FormOfferIns.FindControl("resa_annull")
        If resaval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            resalabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New resa
        Try
            query = ctx.rese.Where(Function(p) p.ID = resaval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        If query.annull = True Then
            resalabel.Visible = True
        Else
            resalabel.Visible = False
        End If


    End Sub

    Public Function Get_garanzia()
        Try
            Return BLL.Get_garanzia(FormOfferIns.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub garanziaID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim garanziaval As DropDownList = FormOfferIns.FindControl("garanziaID")
        Dim garanzialabel As Label = FormOfferIns.FindControl("garanzia_annull")
        If garanziaval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            garanzialabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New garanzia
        Try
            query = ctx.garanzie.Where(Function(p) p.ID = garanziaval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

        If query.annull = True Then
            garanzialabel.Visible = True
        Else
            garanzialabel.Visible = False
        End If

    End Sub

    ' Il parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    ' o essere decorato con un attributo del provider di valori, ad esempio <QueryString>ByVal id as Integer
    Public Function DetailsViewOffer_GetItem(<QueryString("ID")> ByVal id As Nullable(Of Integer)) As IQueryable(Of ViewOfferInsert)
        Dim context As New AcomLinqContextDataContext
        Dim query As IQueryable(Of ViewOfferInsert)

        Try
            query = context.ViewOfferInsert.Where(Function(p) p.ID = id)
            'il viewstate serve per memorizzare i valori di clientID e numero offerta da utilizzare in duplica preventivo e crea nuova versione
            ViewState("clientID") = query.Select(Function(p) p.clientID).FirstOrDefault
            ViewState("offer_num") = query.Select(Function(p) p.offer_num).FirstOrDefault
            ViewState("agentID") = query.Select(Function(p) p.agentID).FirstOrDefault
            ViewState("familyID") = query.Select(Function(p) p.familyID).FirstOrDefault

            Return query

        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try


    End Function

    'per controllare che non siano presenti righe di offerta se il campo è compilato
    Protected Sub offerta_est_TextChanged(sender As Object, e As EventArgs)

        Dim gridrows As GridView = UpdatePanelInsertRow.FindControl("GridViewRows")
        Dim offest As TextBox = sender
        Dim importo As TextBox = FormOfferIns.FindControl("importo")

        If Not String.IsNullOrEmpty(offest.Text) Then
            If gridrows.Rows.Count > 0 Then
                errormsg.Text = "L'offerta è compilata con articoli, non è possibile fare riferimento ad un'offerta esterna"
                errormsg.Visible = True
                importo.Enabled = False
                offest.Focus()
            Else
                importo.Enabled = True
            End If
        Else
            importo.Enabled = False
        End If

    End Sub

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub DetailsViewOffer_UpdateItem(ByVal id As Integer)

        'Dim ctx As New AcomContext
        'Dim item As New Acom1.Models.offer
        'item = ctx.offers.Where(Function(p) p.ID = id).FirstOrDefault
        'item.updated_by = User.Identity.Name
        'item.updated_date = Now

        'If item Is Nothing Then
        '    ' Elemento non trovato
        '    ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
        '    Return
        'End If
        'TryUpdateModel(item)
        'If ModelState.IsValid Then

        '    Try
        '        ctx.SaveChanges()
        '    Catch ex As DbUpdateConcurrencyException
        '        errormsg.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
        '        errormsg.Visible = True
        '    Catch ex1 As Exception
        '        errormsg.Text = ex1.Message
        '        errormsg.Visible = True
        '    End Try

        'End If

    End Sub

    'da provare a sviluppare sfruttando itemtype
    Public Sub DetailsViewOffer_InsertItem()

        '    Dim ctx As New AcomContext
        '    Dim item As New Acom1.Models.offer()

        '    Dim offer_code As TextBox = DetailsViewOffer.FindControl("offer_code")
        '    Dim agent As DropDownList = DetailsViewOffer.FindControl("agentID")
        '    Dim data As TextBox = DetailsViewOffer.FindControl("data")
        '    Dim client As DropDownList = DetailsViewOffer.FindControl("clienteID")
        '    Dim office As DropDownList = DetailsViewOffer.FindControl("officeID")
        '    Dim contact As DropDownList = DetailsViewOffer.FindControl("contactID")
        '    Dim riferimento As TextBox = DetailsViewOffer.FindControl("riferimento")
        '    Dim family As DropDownList = DetailsViewOffer.FindControl("familyID")
        '    Dim stato As DropDownList = DetailsViewOffer.FindControl("stato")
        '    Dim importo As TextBox = DetailsViewOffer.FindControl("importo")
        '    Dim consegna As TextBox = DetailsViewOffer.FindControl("consegna")
        '    Dim offer_est As TextBox = DetailsViewOffer.FindControl("offerta_est")
        '    Dim pay As DropDownList = DetailsViewOffer.FindControl("paymentID")
        '    Dim trasp As DropDownList = DetailsViewOffer.FindControl("transportID")
        '    Dim costo_trasp As TextBox = DetailsViewOffer.FindControl("costo_trasp")
        '    Dim resa As DropDownList = DetailsViewOffer.FindControl("resaID")
        '    Dim garanzia As DropDownList = DetailsViewOffer.FindControl("garanziaID")
        '    Dim validita As TextBox = DetailsViewOffer.FindControl("data_val")
        '    Dim imballo As TextBox = DetailsViewOffer.FindControl("imballo")
        '    Dim note As TextBox = DetailsViewOffer.FindControl("note")
        '    Dim annull As CheckBox = DetailsViewOffer.FindControl("annull")
        '    Dim offer_num As TextBox = DetailsViewOffer.FindControl("offer_num")
        '    Dim offer_vers As TextBox = DetailsViewOffer.FindControl("offer_vers")

        '    Dim dataoffer As Date = ConvertDate(data.Text)
        '    Dim datavalid As Date = ConvertDate(validita.Text)

        '    If item Is Nothing Then
        '        ModelState.AddModelError("", "Nessun elemento inserito")
        '        Return
        '    Else
        '        'client è campo obbligatorio
        '        item.clientID = client.SelectedValue
        '        'controllo se le altre DDL sono state selezionate
        '        If Not office.SelectedValue = "" Then
        '            item.officeID = office.SelectedValue
        '        End If
        '        If Not contact.SelectedValue = "" Then
        '            item.contactID = contact.SelectedValue
        '        End If
        '        If Not agent.SelectedValue = "" Then
        '            item.agentID = agent.SelectedValue
        '        End If
        '        If Not family.SelectedValue = "" Then
        '            item.familyID = family.SelectedValue
        '        End If
        '        If Not stato.SelectedValue = "" Then
        '            item.stato = stato.SelectedValue
        '        End If
        '        If Not pay.SelectedValue = "" Then
        '            item.paymentID = pay.SelectedValue
        '        End If
        '        If Not trasp.SelectedValue = "" Then
        '            item.transportID = trasp.SelectedValue
        '        End If
        '        If Not resa.SelectedValue = "" Then
        '            item.resaID = resa.SelectedValue
        '        End If
        '        If Not garanzia.SelectedValue = "" Then
        '            item.garanziaID = garanzia.SelectedValue
        '        End If

        '        item.data = dataoffer
        '        item.riferimento = riferimento.Text
        '        If IsNumeric(importo.Text) Then
        '            item.importo = importo.Text
        '        Else
        '            item.importo = Nothing
        '        End If
        '        item.consegna = consegna.Text
        '        item.offer_est = offer_est.Text
        '        If IsNumeric(costo_trasp.Text) Then
        '            item.costo_trasporto = costo_trasp.Text
        '        Else
        '            item.costo_trasporto = Nothing
        '        End If
        '        item.data_valid = datavalid
        '        item.imballo = imballo.Text
        '        item.note = note.Text
        '        item.annull = annull.Checked
        '        item.created_by = User.Identity.Name
        '        item.created_date = Now

        '        Dim offerta As New offer
        '        Try
        '            offerta = BLL.new_offer
        '        Catch ex As Exception
        '            errormsg.Text = ex.Message
        '            errormsg.Visible = True
        '            Return
        '        End Try

        '        item.offer_code = offerta.offer_code
        '        item.offer_num = offerta.offer_num
        '        item.offer_vers = offerta.offer_vers

        '        ctx.offers.Add(item)
        '    End If

        '    TryUpdateModel(item)
        '    If ModelState.IsValid Then
        '        Try
        '            ctx.SaveChanges()
        '        Catch ex As Exception
        '            errormsg.Text = ex.Message
        '            errormsg.Visible = True
        '        End Try

        '        Dim id = item.ID
        '        Response.Redirect("~/User/OfferteIns?ID=" & id)

        '    End If
    End Sub

    'per riempire la textbox prezzo con il prezzo dell'articolo selezionato e data decorrenza con la data dell'articolo selezionato
    Protected Sub articleID_SelectedIndexChanged(sender As Object, e As EventArgs)


        Dim DDLart As ComboBox = sender
        Dim articleid As Integer
        Try
            If IsNumeric(DDLart.SelectedValue) Then 'devo controllare anche se il numero corrisponde ad un articolo codificato
                Dim ctx As New AcomContext
                Dim query = ctx.pricelists.Where(Function(p) p.ID = ddarticle.SelectedValue).FirstOrDefault
                If query Is Nothing Then
                    errmsginsert.Text = "Nessun articolo selezionato, nessuna riga inserita"
                    errmsginsert.Visible = True
                    Return
                ElseIf query.annull = True Then
                    errmsginsert.Text = "Articolo fuori produzione, impossibile inserirlo in offerta"
                    errmsginsert.Visible = True
                    Return
                Else
                    articleid = DDLart.SelectedValue
                End If
            ElseIf DDLart.SelectedValue = "" Then
                Exit Sub
            Else
                errmsginsert.Text = "Articolo non codificato, selezionare un articolo in elenco"
                errmsginsert.Visible = True
                Return
            End If
        Catch ex As Exception
            errmsginsert.Text = ex.Message
            errmsginsert.Visible = True
        End Try

        Dim price = Get_price_from_article(articleid)
        Dim data = Get_date_from_article(articleid)
        Dim anno = Year(Now)
        Dim anno_data = Year(data)

        If DDLart.ID = "ddarticle" Then 'sono in inserimento

            prezzo.Text = FormatCurrency(price, 2)
            'se l'anno in corso è maggiore dell'anno di decorrenza del prezzo dell'articolo inserito, lo segnalo in rosso
            If anno > anno_data Then
                data_decorrenza.BackColor = Drawing.Color.Red
                data_decorrenza.Text = data
                Exit Sub
            Else
                data_decorrenza.BackColor = Drawing.Color.White
                data_decorrenza.Text = data
            End If

            'Aggiorno il totale: questo calcolo non viene più effettuato qui per evitare continui aggiornamenti della pagina
            'totale.Text = calc_tot(quantita, prezzo, totale, sconto1, sconto2, sconto3, sconto4, sconto5, sconto6)

        ElseIf DDLart.ID = "articleID" Then 'sono in gridview di modifica

            'individuo la riga in editing e trovo i controlli coinvolti nel calcolo del totale
            Dim row As GridViewRow = GridViewRows.Rows(GridViewRows.EditIndex)
            Dim prezzo_grid As TextBox = row.FindControl("prezzo")
            Dim totale_grid As TextBox = row.FindControl("totale")
            Dim quantita_grid As TextBox = row.FindControl("quantita")
            Dim sconto1_grid As TextBox = row.FindControl("sconto1")
            Dim sconto2_grid As TextBox = row.FindControl("sconto2")
            Dim sconto3_grid As TextBox = row.FindControl("sconto3")
            Dim sconto4_grid As TextBox = row.FindControl("sconto4")
            Dim sconto5_grid As TextBox = row.FindControl("sconto5")
            Dim sconto6_grid As TextBox = row.FindControl("sconto6")

            prezzo_grid.Enabled = True
            prezzo_grid.Text = price

            'se l'anno in corso è maggiore dell'anno di decorrenza del prezzo dell'articolo inserito, lo segnalo in rosso
            If anno > anno_data Then
                prezzo_grid.ForeColor = Drawing.Color.Red
                row.BackColor = Drawing.Color.Red
            Else
                prezzo_grid.ForeColor = Drawing.Color.Black
                row.BackColor = Drawing.Color.White
            End If

            totale_grid.Enabled = True
            totale_grid.Text = calc_tot(quantita_grid, prezzo_grid, sconto1_grid, sconto2_grid, sconto3_grid, sconto4_grid, sconto5_grid, sconto6_grid)

            'ripristino i controlli prezzo e totale come non modificabili
            prezzo_grid.Enabled = False
            totale_grid.Enabled = False

        End If


    End Sub

    'Inserimento di nuova riga d'offerta
    Protected Sub insertButton_Click(sender As Object, e As EventArgs)


        'uso linq perchè tryupdatemodel funziona solo con detailsview o gridview
        Dim context As New AcomLinqContextDataContext
        Dim item As New linq_offer_row
        Dim riga As Integer
        Dim offertaest As String = FormOfferIns.FindControl("offerta_est").GetType.Name
        Dim id As Integer = Request.QueryString("ID")

        'se offerta esterna è compilata non posso inserire nessuna riga d'offerta
        If Not offertaest Is Nothing Then
            Select Case offertaest
                Case "TextBox"
                    Dim offerta_est As TextBox = FormOfferIns.FindControl("offerta_est")
                    If Not String.IsNullOrEmpty(offerta_est.Text) Then
                        errmsginsert.Text = "Offerta esterna, impossibile aggiungere righe di offerta"
                        errmsginsert.Visible = True
                        Return
                    End If
                Case "Label"
                    Dim offerta_est As Label = FormOfferIns.FindControl("offerta_est")
                    If Not String.IsNullOrEmpty(offerta_est.Text) Then
                        errmsginsert.Text = "Offerta esterna, impossibile aggiungere righe di offerta"
                        errmsginsert.Visible = True
                        Return
                    End If
            End Select
        End If

        If id = 0 Then
            errmsginsert.Text = "Nessuna intestazione di offerta inserita"
            errmsginsert.Visible = True
            Return
        Else
            item.offerID = id
        End If

        'queste variabili mi servono per aggiornare il campo importo nella detailsview
        Dim ctx As New AcomContext
        Dim importo As Nullable(Of Decimal) = Nothing
        Dim itemoffer As Acom1.Models.offer

        Try
            itemoffer = ctx.offers.Where(Function(p) p.ID = id).FirstOrDefault()
        Catch ex As Exception
            errmsginsert.Text = ex.Message
            errmsginsert.Visible = True
            Return
        End Try

        'controllo su articolo, se è nullo o se è fuori produzione o se il listino è antecedente all'anno in corso
        Dim articleID As Integer
        If IsNumeric(ddarticle.SelectedValue) Then
            articleID = ddarticle.SelectedValue
        ElseIf ddarticle.SelectedValue = "" Then
            ddarticle.SelectedValue = Nothing
            Return
        Else 'qualunque altra cosa al difuori di nothing e numeric non è valida
            errmsginsert.Text = "Articolo non codificato, selezionare un articolo in elenco"
            errmsginsert.Visible = True
            Return
        End If
        'controllo se l'articolo selezionato è valido
        Dim query = ctx.pricelists.Where(Function(p) p.ID = ddarticle.SelectedValue).FirstOrDefault
        If query Is Nothing Then 'nessun articolo corrispondente all'ID inserito
            errmsginsert.Text = "Nessun articolo selezionato, nessuna riga inserita"
            errmsginsert.Visible = True
            Return
        ElseIf query.annull = True Then
            errmsginsert.Text = "Articolo fuori produzione, non è possibile inserirlo"
            errmsginsert.Visible = True
            Return
        ElseIf Year(query.data_decorrenza) < Year(Now) Then 'proseguo comunque con l'inserimento
            errmsginsert.Text = "Attenzione, il prezzo dell'articolo selezionato è relativo ad un listino superato"
            errmsginsert.Visible = True
            item.articleID = query.ID
        Else
            item.articleID = query.ID
        End If

        'Predispongo le variabili per il calcolo del totale
        Dim totale As Decimal = calc_tot(quantita, prezzo, sconto1, sconto2, sconto3, sconto4, sconto5, sconto6)
        Dim net_price As Decimal = calc_net_price(prezzo, sconto1, sconto2, sconto3, sconto4, sconto5, sconto6)

        'controllo se il totale è maggiore di zero
        If totale = 0 Then
            errmsginsert.Text = "Totale uguale a zero, nessuna riga inserita"
            errmsginsert.Visible = True
            Return
        Else
            item.totale = totale
        End If

        'numerazione della riga
        Try
            riga = BLL.new_offer_row(Request.QueryString("ID"))
        Catch ex As Exception
            errmsginsert.Text = ex.Message
            errmsginsert.Visible = True
            Return
        End Try

        If riga = 0 Then
            errmsginsert.Text = "Numerazione riga non riuscita"
            errmsginsert.Visible = True
            Return
        Else
            item.rigaID = riga
        End If

        If sconto1.Text = "" Then
            item.sconto1 = 0
        Else
            item.sconto1 = sconto1.Text
        End If

        If sconto2.Text = "" Then
            item.sconto2 = 0
        Else
            item.sconto2 = sconto2.Text
        End If

        If sconto3.Text = "" Then
            item.sconto3 = 0
        Else
            item.sconto3 = sconto3.Text
        End If

        If sconto4.Text = "" Then
            item.sconto4 = 0
        Else
            item.sconto4 = sconto4.Text
        End If

        If sconto5.Text = "" Then
            item.sconto5 = 0
        Else
            item.sconto5 = sconto5.Text
        End If

        If sconto6.Text = "" Then
            item.sconto6 = 0
        Else
            item.sconto6 = sconto6.Text
        End If

        item.quantita = quantita.Text
        item.note = note.Text
        item.prezzo = prezzo.Text
        item.created_by = User.Identity.Name
        item.created_date = Today

        If item Is Nothing Then
            ModelState.AddModelError("", "Nessuna riga di offerta inserita")
            Return
        End If

        context.linq_offer_row.InsertOnSubmit(item)

        If ModelState.IsValid Then
            Try
                context.SubmitChanges()
                importo = TotOfferta_calc(id)
                itemoffer.importo = importo
                itemoffer.updated_by = User.Identity.Name
                itemoffer.updated_date = Today
                ctx.SaveChanges()

                'Response.Redirect("/User/OfferteIns?ID=" & id)
                GridViewRows.DataBind()
                UpdatePanelDetail.DataBind()
                'FormOfferIns.DataBind()
            Catch ex As Exception
                errmsginsert.Text = ex.Message
                errmsginsert.Visible = True
            End Try
        Else
            ModelState.AddModelError("", "Errore durante il model binding")
            Return
        End If

        note.Text = ""
        ddarticle.Text = Nothing
        quantita.Text = 0
        sconto1.Text = 0
        sconto2.Text = 0
        sconto3.Text = 0
        sconto4.Text = 0
        sconto5.Text = 0
        sconto6.Text = 0
        'totale.Text = 0

    End Sub

    'inutilizzata
    'Funzione per calcolo del prezzo netto dati quantità, prezzo e sconti
    Private Function calc_net_price(price As TextBox, sconto1 As TextBox, _
                              sconto2 As TextBox, sconto3 As TextBox, sconto4 As TextBox, sconto5 As TextBox, sconto6 As TextBox)

        Dim m_price = price.Text
        Dim m_tot As Decimal
        Dim sc1 As Decimal
        Dim sc2 As Decimal
        Dim sc3 As Decimal
        Dim sc4 As Decimal
        Dim sc5 As Decimal
        Dim sc6 As Decimal

        'devo verificare se la stringa è vuota altrimenti al postback va in errore
        If m_price = 0 Or String.IsNullOrEmpty(m_price) Then
            m_tot = 0
            Return m_tot
        End If

        sc1 = If(sconto1.Text = "", 1, (1 - sconto1.Text / 100))
        sc2 = If(sconto2.Text = "", 1, (1 - sconto2.Text / 100))
        sc3 = If(sconto3.Text = "", 1, (1 - sconto3.Text / 100))
        sc4 = If(sconto4.Text = "", 1, (1 - sconto4.Text / 100))
        sc5 = If(sconto5.Text = "", 1, (1 - sconto5.Text / 100))
        sc6 = If(sconto6.Text = "", 1, (1 - sconto6.Text / 100))

        m_tot = Math.Round(m_price * sc1 * sc2 * sc3 * sc4 * sc5 * sc6, 2)

        Return m_tot
    End Function

    'Funzione per calcolo del totale dati quantità, prezzo e sconti
    Private Function calc_tot(qta As TextBox, price As TextBox, sconto1 As TextBox, _
                              sconto2 As TextBox, sconto3 As TextBox, sconto4 As TextBox, sconto5 As TextBox, sconto6 As TextBox)
        Dim m_qta = qta.Text
        Dim m_price = price.Text
        Dim m_tot As Decimal
        Dim sc1 As Decimal
        Dim sc2 As Decimal
        Dim sc3 As Decimal
        Dim sc4 As Decimal
        Dim sc5 As Decimal
        Dim sc6 As Decimal

        'devo verificare se la stringa è vuota altrimenti al postback va in errore
        If m_qta = "" Then
            m_tot = 0
            Return m_tot
        ElseIf m_qta = 0 Or String.IsNullOrEmpty(m_qta) Or m_qta = "" Then
            m_tot = 0
            Return m_tot
        End If
        If m_price = 0 Or String.IsNullOrEmpty(m_price) Then
            m_tot = 0
            Return m_tot
        End If

        sc1 = If(sconto1.Text = "", 1, (1 - sconto1.Text / 100))
        sc2 = If(sconto2.Text = "", 1, (1 - sconto2.Text / 100))
        sc3 = If(sconto3.Text = "", 1, (1 - sconto3.Text / 100))
        sc4 = If(sconto4.Text = "", 1, (1 - sconto4.Text / 100))
        sc5 = If(sconto5.Text = "", 1, (1 - sconto5.Text / 100))
        sc6 = If(sconto6.Text = "", 1, (1 - sconto6.Text / 100))

        m_tot = Math.Round(m_qta * m_price * sc1 * sc2 * sc3 * sc4 * sc5 * sc6, 2)

        Return m_tot
    End Function

    'Utilizzata per aggiornare il campo totale in inserimento nuova riga
    Protected Sub quantita_TextChanged(sender As Object, e As EventArgs)
        'L'aggiornamento del totale non viene più fatto qui
        'totale.Text = calc_tot(quantita, prezzo, totale, sconto1, sconto2, sconto3, sconto4, sconto5, sconto6)
    End Sub

    'Per riempire la gridview con le righe di offerta
    Public Function GridViewRows_GetData(<QueryString("ID")> ByVal ID As Nullable(Of Integer)) As IQueryable(Of Acom1.ViewOfferRowDetail)

        Dim ctx As New AcomLinqContextDataContext

        Try
            Return ctx.ViewOfferRowDetail.Where(Function(p) p.offerID = ID And p.annull = False).OrderBy(Function(p) p.rigaID)
        Catch ex As Exception
            errmsginsert.Text = ex.Message
            errmsginsert.Visible = True
            Return Nothing
        End Try


    End Function

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub GridViewRows_UpdateItem(ByVal id As Integer)

        Dim ctx As New AcomContext
        Dim offerID As Integer = Request.QueryString("ID")
        Dim item As Acom1.Models.offer_row = ctx.offer_rows.Where(Function(p) p.ID = id).FirstOrDefault
        Dim itemoffer As Acom1.Models.offer
        Try
            itemoffer = ctx.offers.Where(Function(p) p.ID = offerID).FirstOrDefault()
        Catch ex As Exception
            errmsginsert.Text = ex.Message
            errmsginsert.Visible = True
            Return
        End Try

        item.updated_by = User.Identity.Name
        item.updated_date = Now


        If item Is Nothing Or itemoffer Is Nothing Then
            ' Elemento non trovato
            ModelState.AddModelError("", "Offerta non trovata")
            Return
        End If
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                ctx.SaveChanges()
                GridViewRows.DataBind()
                'Response.Redirect("/User/OfferteIns?ID=" & offerID)
            Catch ex As DbUpdateConcurrencyException
                errmsginsert.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
                errmsginsert.Visible = True
            Catch ex1 As Exception
                errmsginsert.Text = ex1.Message
                errmsginsert.Visible = True
            End Try
        Else
            errmsginsert.Text = "Problemi in fase di aggiornamento, modello non valido"
            errmsginsert.Visible = True
            Return
        End If

        ModelState.Clear()

        'aggiorno il valore di importo nella detailsview
        itemoffer.importo = TotOfferta_calc(offerID)
        itemoffer.updated_by = User.Identity.Name
        itemoffer.updated_date = Today

        'Try
        '    TryUpdateModel(itemoffer)
        'Catch ex As Exception
        '    errmsginsert.Text = ex.Message
        '    errmsginsert.Visible = True
        '    Return
        'End Try

        'If ModelState.IsValid Then
        Try
            ctx.SaveChanges()
            UpdatePanelDetail.DataBind()
            'Response.Redirect("/User/OfferteIns?ID=" & offerID)
        Catch ex As DBConcurrencyException
            errmsginsert.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
            errmsginsert.Visible = True
        Catch ex1 As Exception
            errmsginsert.Text = ex1.Message
            errmsginsert.Visible = True
        End Try
        'Else
        'errmsginsert.Text = "Problemi in fase di aggiornamento, modello non valido"
        'errmsginsert.Visible = True
        'Return
        'End If


    End Sub

    Public Function Get_article_from_pricelist()
        Try
            Return BLL.Get_article_from_pricelist
        Catch ex As Exception
            errmsginsert.Text = ex.Message
            errmsginsert.Visible = True
            Return Nothing
        End Try

    End Function

    'per aggiornare il campo totale in fase di editing nel gridview 
    Protected Sub quantitaEdit_TextChanged(sender As Object, e As EventArgs)

        'individuo la riga in editing del gridview e trovo i vari controlli coinvolti nel calcolo del totale
        Dim row As GridViewRow = GridViewRows.Rows(GridViewRows.EditIndex)
        Dim quantita As TextBox = row.FindControl("quantita")
        Dim price As TextBox = row.FindControl("prezzo")
        Dim tot As TextBox = row.FindControl("totale")
        Dim sconto1 As TextBox = row.FindControl("sconto1")
        Dim sconto2 As TextBox = row.FindControl("sconto2")
        Dim sconto3 As TextBox = row.FindControl("sconto3")
        Dim sconto4 As TextBox = row.FindControl("sconto4")
        Dim sconto5 As TextBox = row.FindControl("sconto5")
        Dim sconto6 As TextBox = row.FindControl("sconto6")

        tot.Text = calc_tot(quantita, price, sconto1, sconto2, sconto3, sconto4, sconto5, sconto6)

    End Sub

    Protected Function TotOfferta_calc(ByVal id As Nullable(Of Integer)) As Decimal

        If id = 0 Or id Is Nothing Then
            Return Nothing
        Else
            Dim context As New AcomLinqContextDataContext
            Try
                Dim query = context.ViewOfferTot.Where(Function(p) p.offerID = id).Select(Function(c) c.totale_offer).FirstOrDefault
                Return query
            Catch ex As InvalidOperationException
                errmsginsert.Text = ex.Message
                errmsginsert.Visible = True
                Return Nothing
            Catch ex1 As Exception
                errmsginsert.Text = ex1.Message
                errmsginsert.Visible = True
                Return Nothing
            End Try
        End If

    End Function

    'questo evento si scateba alla pressione del tasto modifica. e.NewEditIndex è l'indice della riga in modifica
    Protected Sub GridViewRows_RowEditing(sender As Object, e As GridViewEditEventArgs)

    End Sub


    'per calcolare la data di validità a +30gg rispetto alla data dell'offerta
    Public Function select_validita() As Date

        Dim dataval As Date = Nothing
        Dim data As TextBox = FormOfferIns.FindControl("data")

        If Not String.IsNullOrEmpty(data.Text) Then
            Dim datains As Date = ConvertDate(data.Text)
            dataval = DateAdd(DateInterval.Day, 30, datains)
        End If

        Return dataval

    End Function

    Protected Sub data_TextChanged(sender As Object, e As EventArgs)

        'RICHIAMA la funzione per valorizzare la data di validità
        Dim datavalid As TextBox = FormOfferIns.FindControl("data_val")
        datavalid.Text = select_validita()

    End Sub

    Protected Sub GridViewRows_DataBound(sender As Object, e As EventArgs)


        Dim grid As GridView = sender
        'in fase di inserimento di nuova offerta il footer non esiste, quindi mi fermo qui
        If grid.FooterRow Is Nothing Then Exit Sub

        'prendo l'id e lo passo per il calcolo del totale di offerta
        Dim id As Integer = Request.QueryString("ID")
        Dim totoff As Nullable(Of Decimal) = TotOfferta_calc(id)


        'se sono in inserimento id=0, quindi mi fermo qui
        If Not id = 0 Then

            'aggiungo al footer del gridview il valore totale
            Dim foot As Label = grid.FooterRow.FindControl("totale")
            If Not totoff Is Nothing Then
                foot.Text = FormatCurrency(totoff, 2)
            End If

            'ciclo sulle righe di offerta per verificare se c'è qualche articolo inserito che è fuori produzione, utile in fase di duplica o nuova versione
            Dim ctx As New AcomContext
            Dim row As GridViewRow
            Dim articolo As TextBox
            Dim artID As Integer
            Dim resultArticolo As Boolean

            For Each row In GridViewRows.Rows
                articolo = row.FindControl("articleID")
                artID = articolo.Text
                Try
                    resultArticolo = ctx.pricelists.Where(Function(p) p.ID = artID).Select(Function(p) p.annull).FirstOrDefault
                Catch ex As Exception
                    errmsginsert.Text = ex.Message
                    errmsginsert.Visible = True
                    Return
                End Try

                If resultArticolo = True Then
                    row.BackColor = Drawing.Color.Red
                End If
            Next

        End If
    End Sub

    Protected Sub cmdStampaOfferta_Click(sender As Object, e As EventArgs)
        Dim id As Integer = Request.QueryString("ID")
        If id = 0 Then Return

        Try
            Dim bytes As Byte()
            bytes = BLL.GeneraPdfOfferta(id, False)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try
        'Response.Clear()
        'Response.ContentType = System.Net.Mime.MediaTypeNames.Application.Pdf
        'Response.AppendHeader("Content-Lenght", bytes.Length.ToString)
        'Response.BinaryWrite(bytes)
        'Response.Output.Flush()
        'Response.End()


    End Sub

    Protected Sub cmdStampaOffertaSconti_Click(sender As Object, e As EventArgs)
        Dim id As Integer = Request.QueryString("ID")
        If id = 0 Then Return

        Try
            Dim bytes As Byte()
            bytes = BLL.GeneraPdfOfferta(id, True)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try
    End Sub

    Protected Sub cmdDuplica_Click(sender As Object, e As EventArgs)

        Dim ID As Nullable(Of Integer) = Request.QueryString("ID")
        If ID Is Nothing Or ID = 0 Then Return

        Dim offerta As offer = BLL.new_offer
        Dim clientID As Integer = ViewState("clientID")
        Dim agentID As Integer = ViewState("agentID")
        Dim familyID As Integer = ViewState("familyID")

        Dim item As New offer
        item.offer_num = offerta.offer_num
        item.offer_code = offerta.offer_code
        item.offer_vers = offerta.offer_vers
        item.data = Now
        item.clientID = clientID
        item.agentID = agentID
        If familyID = 0 Then
            item.familyID = Nothing
        Else
            item.familyID = familyID
        End If

        item.data_valid = Today
        item.stato = "In attesa"
        item.created_by = User.Identity.Name
        item.created_date = Now

        If item Is Nothing Then
            Return
        End If

        Dim ctx As New AcomContext
        ctx.offers.Add(item)

        If ModelState.IsValid Then

            Try
                ctx.SaveChanges()
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try

        End If

        Dim offerID As Integer
        offerID = item.ID
        Dim query As List(Of offer_row)
        'Nel duplicato non vengono inserite le righe annullate
        Try
            query = ctx.offer_rows.Where(Function(p) p.offerID = ID And p.annull = False).ToList
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        'per ogni record in query aggiorno i valori che mi servono nel duplicato
        For Each p In query
            query.First(Function(c) c.offerID = ID).updated_by = ""
            query.First(Function(c) c.offerID = ID).updated_date = Nothing
            query.First(Function(c) c.offerID = ID).created_by = User.Identity.Name
            query.First(Function(c) c.offerID = ID).created_date = Now

            'sostituisco il valore originale di offerID con il nuovo valore della offerta duplicata
            query.First(Function(c) c.offerID = ID).offerID = offerID
        Next

        Try
            ctx.offer_rows.AddRange(query)
            ctx.SaveChanges()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        Response.Redirect("/User/OfferteIns?ID=" & offerID)

    End Sub

    Protected Sub cmdNewVers_Click(sender As Object, e As EventArgs)

        Dim ID As Nullable(Of Integer) = Request.QueryString("ID")
        If ID Is Nothing Or ID = 0 Then Return

        Dim codice_offerta As String = ViewState("offer_code")
        Dim numero_offerta As Nullable(Of Integer) = ViewState("offer_num")

        If ID = 0 Or ID Is Nothing Then
            Exit Sub
        End If

        If numero_offerta = 0 Or numero_offerta Is Nothing Then
            Exit Sub
        End If

        Dim offerta As offer = BLL.new_offer(codice_offerta, numero_offerta)
        Dim ctx As New AcomContext
        Dim query_offer As New offer
        Try
            query_offer = ctx.offers.Where(Function(p) p.ID = ID).FirstOrDefault
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        'sostituisco i valori della versione padre con i nuovi valori
        query_offer.offer_code = offerta.offer_code
        query_offer.offer_num = offerta.offer_num
        query_offer.offer_vers = offerta.offer_vers
        query_offer.created_by = User.Identity.Name
        query_offer.created_date = Now
        query_offer.updated_by = ""
        query_offer.updated_date = Nothing

        Try
            ctx.offers.Add(query_offer)
            ctx.SaveChanges()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        Dim offerID As Integer
        offerID = query_offer.ID
        Dim query_rows As List(Of offer_row)
        'Nella nuova versione non vengono inserite le righe annullate
        Try
            query_rows = ctx.offer_rows.Where(Function(p) p.offerID = ID And p.annull = False).ToList
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        'per ogni record in query aggiorno i valori che mi servono nel duplicato
        For Each p In query_rows
            query_rows.First(Function(c) c.offerID = ID).updated_by = ""
            query_rows.First(Function(c) c.offerID = ID).updated_date = Nothing
            query_rows.First(Function(c) c.offerID = ID).created_by = User.Identity.Name
            query_rows.First(Function(c) c.offerID = ID).created_date = Now

            'sostituisco il valore originale di offerID con il nuovo valore della offerta duplicata
            query_rows.First(Function(c) c.offerID = ID).offerID = offerID
        Next

        Try
            ctx.offer_rows.AddRange(query_rows)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try


        If ModelState.IsValid Then

            Try
                ctx.SaveChanges()
            Catch ex As Exception
                Return
            End Try

            Response.Redirect("/User/OfferteIns?ID=" & offerID)
        Else
            ModelState.AddModelError("", "Problemi nel modello dati, aggiornamento non riuscito")

        End If

    End Sub

End Class