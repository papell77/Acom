Imports Acom1.BLL
Imports Acom1.DAL
Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports System.Globalization

Public Class VisiteIns1
    Inherits System.Web.UI.Page

    Private insert_id As Integer 'usato per memorizzare l'id del record appena inserito

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            'il posizionamento del Request fa una grande differenza, qui la pagina non torna sul record dopo l'inserimento
            Dim id As Integer = Request.QueryString("ID")

            If id = 0 Then

                DetailsViewVisit.ChangeMode(DetailsViewMode.Insert)
            Else
                DetailsViewVisit.ChangeMode(DetailsViewMode.Edit)
            End If

        End If
        If DetailsViewVisit.CurrentMode = DetailsViewMode.Edit Then
            DetailsViewVisit.AutoGenerateInsertButton = False
        End If

        If DetailsViewVisit.CurrentMode = DetailsViewMode.Insert Then
            lbltitle.InnerText = "Inserisci evento"
        End If

    End Sub

    Private Sub VisiteIns1_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

        If Page.IsPostBack And (DetailsViewVisit.CurrentMode = DetailsViewMode.Edit Or DetailsViewVisit.CurrentMode = DetailsViewMode.Insert) Then
            visit_logic2()
        End If

        If Not Page.IsPostBack And DetailsViewVisit.CurrentMode = DetailsViewMode.Edit Then

            visit_logic2()

        End If

    End Sub

    ' Il parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    ' o essere decorato con un attributo del provider di valori, ad esempio <QueryString>ByVal id as Integer
    Public Function DetailsViewVisit_GetItem(<QueryString("ID")> ByVal id As Nullable(Of Integer)) As List(Of Acom1.ViewVisit)
        Dim context As New AcomLinqContextDataContext
        If id Is Nothing Then 'arrivo probabilmente da un inserimento dati, verifico il viewstate per ID
            If ViewState("ID") Is Nothing Then 'errore
                errormsg.Text = "Attenzione nessun ID selezionato"
                errormsg.Visible = True
                Return Nothing
            Else
                id = ViewState("ID")
            End If
        End If

        Dim query As List(Of ViewVisit)
        Try
            query = context.ViewVisit.Where(Function(p) p.ID = id).ToList()
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

        Return query

    End Function

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub DetailsViewVisit_UpdateItem(ByVal id As Integer)

        Dim ctx As New AcomContext
        Dim item As New Acom1.Models.visit
        item = ctx.visits.Find(id)

        'Dim data1_orig As Date = item.data
        Dim data1 As TextBox = DetailsViewVisit.FindControl("data")
        Dim data2 As TextBox = DetailsViewVisit.FindControl("data_prossima")
        Dim motivodesc As TextBox = DetailsViewVisit.FindControl("motivo_descrizione")
        Dim offerta As TextBox = DetailsViewVisit.FindControl("preventivo_num")
        Dim stato As DropDownList = DetailsViewVisit.FindControl("stato")
        Dim annull As CheckBox = DetailsViewVisit.FindControl("annull")
        Dim dataevent As Date

        If Date.TryParseExact(data1.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataevent) = False Then
            errormsg.Text = "Attenzione il formato di Data evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
            errormsg.Visible = True
            Exit Sub
        Else
            item.data = dataevent
        End If



        'item.data = dataevent
        item.motivo_desc = motivodesc.Text
        item.preventivo_num = offerta.Text
        item.stato = stato.SelectedValue
        item.annull = annull.Checked
        item.data_upd = Today
        item.updatedby = User.Identity.Name

        If Not String.IsNullOrEmpty(data2.Text) Then
            Dim dataproxevent As Date

            If Date.TryParseExact(data2.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataproxevent) = False Then
                errormsg.Text = "Attenzione il formato di Data prossimo evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
                errormsg.Visible = True
                Exit Sub
            Else
                item.data_prossima = dataproxevent
            End If

            stato.ClearSelection()
            stato.Items.FindByValue("closed").Enabled = True
            stato.Items.FindByValue("closed").Selected = True
            stato.Enabled = False
            item.stato = "closed" 'se la data pross evento è compilata chiudo questo evento e ne aprirò un altro di sistema
        End If

        If Not String.IsNullOrEmpty(offerta.Text) Then
            stato.ClearSelection()
            stato.Items.FindByValue("closed").Enabled = True
            stato.Items.FindByValue("closed").Selected = True
            stato.Enabled = False
            item.stato = "closed" 'se il numero offerta è compilato chiudo direttamente l'evento
        End If

        If item Is Nothing Then
            ' Elemento non trovato
            ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
            Return
        End If

        Try
            ctx.SaveChanges()
            If stato.SelectedValue = "closed" And item.stato = "closed" Then
                popPanelLabel.Text = "Evento chiuso, non sarà più visibile in home. <br/> Inserire un nuovo evento?"
                modalpop.Show()
                'Response.Write("<script type=text/javascript>if(confirm('Evento chiuso, non sarà più visibile in Home')) document.location = 'Home.aspx';</script>")
                'ShowMessageBox("Evento chiuso, non sarà più mostrato in Home")
            ElseIf annull.Checked = True Then
                popPanelLabel.Text = "Evento annullato non sarà più visibile in Home. <br/> Inserire un nuovo evento?"
                modalpop.Show()
                'Response.Write("<script type=text/javascript>if(confirm('Evento annullato, non sarà più visibile in Home')) document.location = 'Home.aspx';</script>")
            Else
                popPanelLabel.Text = "Evento modificato. <br/> Inserire un nuovo evento?"
                modalpop.Show()
                'Response.Write("<script type=text/javascript>if(confirm('Evento correttamente modificato')) document.location = 'Home.aspx';</script>")
            End If
        Catch ex As DBConcurrencyException
            errormsg.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
            errormsg.Visible = True
        Catch ex1 As Exception
            errormsg.Text = ex1.Message
            errormsg.Visible = True
        End Try

        'uso ancora il controllo su data pross evento per verificare se è necessario generare nuovo evento e chiudere il corrente
        If Not String.IsNullOrEmpty(data2.Text) Then
            Dim childitem As New Acom1.Models.visit
            childitem.agentID = item.agentID
            childitem.clientID = item.clientID
            childitem.officeID = item.officeID
            childitem.data = item.data_prossima
            childitem.motivo_type = item.motivo_type
            childitem.motivo_desc = "Autogenerato " & item.motivo_desc
            childitem.preventivo_num = item.preventivo_num
            childitem.stato = "pending"
            childitem.createdby = "System"
            childitem.data_ins = Today

            If Not childitem Is Nothing Then
                ctx.visits.Add(childitem)
            End If

            Try
                ctx.SaveChanges()
                popPanelLabel.Text = "Nuovo evento di sistema generato. <br/> Inserire un nuovo evento?"
                modalpop.Show()
                'Response.Write("<script type=text/javascript>if(confirm('Nuovo evento di sistema generato')) document.location = 'Home.aspx';</script>")
                'ShowMessageBox("Nuovo evento di sistema generato")
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
            End Try

        End If

    End Sub

    Protected Sub DetailsViewVisit_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs)

        If e.AffectedRows <= 0 And Not e.Exception Is Nothing Then
            e.KeepInEditMode = True
        End If


    End Sub

    Public Sub DetailsViewVisit_InsertItem()

        Dim ctx As New AcomContext

        Dim agent As DropDownList = DetailsViewVisit.FindControl("agentID")
        Dim cliente As DropDownList = DetailsViewVisit.FindControl("clienteID")
        Dim filiale As DropDownList = DetailsViewVisit.FindControl("officeID")
        Dim data As TextBox = DetailsViewVisit.FindControl("data")
        Dim motivotipo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        Dim motivodesc As TextBox = DetailsViewVisit.FindControl("motivo_descrizione")
        'Dim ordine As TextBox = DetailsViewVisit.FindControl("ordine_num")
        Dim offerta As TextBox = DetailsViewVisit.FindControl("preventivo_num")
        'Dim offertaest As TextBox = DetailsViewVisit.FindControl("offerta_est")
        Dim dataprossima As TextBox = DetailsViewVisit.FindControl("data_prossima")
        Dim stato As DropDownList = DetailsViewVisit.FindControl("stato")

        Dim item = New Acom1.Models.visit

        Dim dataval As Date
        If Date.TryParseExact(data.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataval) = False Then
            errormsg.Text = "Attenzione il formato di Data evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
            errormsg.Visible = True
            Exit Sub
        Else
            item.data = dataval
        End If

        item.agentID = agent.SelectedValue
        item.clientID = cliente.SelectedValue
        item.motivo_type = motivotipo.SelectedValue
        item.motivo_desc = motivodesc.Text
        item.preventivo_num = offerta.Text
        item.stato = stato.SelectedValue
        item.createdby = User.Identity.Name
        item.data_ins = Today
        'item.ordine_num = ordine.Text
        'item.offerta_est = offertaest.Text

        If Not filiale.SelectedValue = "" Then
            item.officeID = filiale.SelectedValue
        End If

        'se la data prossimo evento è valorizzata, imposto lo stato direttamente a closed e genero il nuovo evento di sistema
        If Not String.IsNullOrEmpty(dataprossima.Text) Then
            Dim dataproxevent As Date
            If Date.TryParseExact(dataprossima.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataproxevent) = False Then
                errormsg.Text = "Attenzione il formato di Data prossimo evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
                errormsg.Visible = True
                Exit Sub
            Else
                item.data_prossima = dataproxevent
            End If

            stato.ClearSelection()
            stato.Items.FindByValue("closed").Enabled = True
            stato.Items.FindByValue("closed").Selected = True
            stato.Enabled = False
            item.stato = "closed"
        End If



        'se il campo offerta è valorizzato e sono in preventivo, imposto lo stato direttamente a closed
        If Not String.IsNullOrEmpty(offerta.Text) And motivotipo.SelectedValue = 2 Then
            stato.ClearSelection()
            stato.Items.FindByValue("closed").Enabled = True
            stato.Items.FindByValue("closed").Selected = True
            stato.Enabled = False
            item.stato = "closed"
        End If

        If item Is Nothing Then
            ModelState.AddModelError("", "Nessun elemento inserito")
            Return
        Else 'creo il childitem e aggiungo l'item al context
            ctx.visits.Add(item)
        End If

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                ctx.SaveChanges()
                If stato.SelectedValue = "closed" And item.stato = "closed" Then
                    popPanelLabel.Text = "Evento chiuso, non sarà più visibile in Home" & "<br />" & "Inserire nuovo evento?"
                    modalpop.Show()
                    '    Response.Write("<script type=text/javascript>if(confirm('Evento chiuso, non sarà visibile in Home')) document.location = 'Home.aspx';</script>")
                    '    'ShowMessageBox("Evento chiuso, non sarà più mostrato in Home")
                Else
                    popPanelLabel.Text = "Evento inserito, inserire nuovo evento?"
                    modalpop.Show()
                    '    Response.Write("<script type=text/javascript>if(confirm('Evento inserito')) document.location = 'Home.aspx';</script>")
                End If
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
            End Try

            Dim id = item.ID

            'il viewstate serve per passare l'ID alla sub DetailsViewVisit_GetItem altrimenti va in errore
            ViewState("ID") = id

        End If

        'uso il controllo su dataprossima per avviare la generazione dell'evento di sistema
        If Not String.IsNullOrEmpty(dataprossima.Text) Then
            'creo il childitem
            Dim childitem As New Acom1.Models.visit
            childitem.agentID = agent.SelectedValue
            childitem.clientID = cliente.SelectedValue
            childitem.officeID = item.officeID
            childitem.data = item.data_prossima
            childitem.motivo_type = motivotipo.SelectedValue
            childitem.motivo_desc = "Autogenerato " & motivodesc.Text
            childitem.preventivo_num = offerta.Text
            childitem.stato = "pending"
            childitem.createdby = "System"
            childitem.data_ins = Today

            If Not childitem Is Nothing Then
                ctx.visits.Add(childitem)
            End If
            TryUpdateModel(childitem)
            If ModelState.IsValid Then
                Try
                    ctx.SaveChanges()
                    popPanelLabel.Text = "Nuovo evento di sistema generato, inserire nuovo evento?"
                    modalpop.Show()
                    'Response.Write("<script type=text/javascript>if(confirm('Nuovo evento di sistema generato')) document.location = 'Home.aspx';</script>")
                    'ShowMessageBox("Nuovo evento di sistema generato")
                Catch ex As Exception
                    errormsg.Text = ex.Message
                    errormsg.Visible = True
                End Try
            End If

        End If

    End Sub

    Protected Sub DetailsViewVisit_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs)

        If e.AffectedRows < 0 And Not e.Exception Is Nothing Then
            e.KeepInInsertMode = True
        End If

    End Sub

    Protected Sub DetailsViewVisit_ItemCommand(sender As Object, e As DetailsViewCommandEventArgs)

        If e.CommandName() = "Cancel" Then
            If User.IsInRole("User") Then
                Response.Redirect("~/User/Home.aspx")
            ElseIf User.IsInRole("DataEntry") Then
                Response.Redirect("~/User/HomeDE.aspx")
            End If

        End If

    End Sub

    Public Function Get_client()
        Try
            Return BLL.Get_client(DetailsViewVisit.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub clientID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim clientval As DropDownList = DetailsViewVisit.FindControl("clienteID")
        Dim clientlabel As Label = DetailsViewVisit.FindControl("client_annull")

        If clientval.SelectedValue = "" Then
            clientlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As client
        Try
            query = ctx.clients.Where(Function(p) p.ID = clientval.SelectedValue).FirstOrDefault
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If DetailsViewVisit.CurrentMode = DetailsViewMode.Edit Then

            If query.annull = True Then
                clientlabel.Visible = True
            Else
                clientlabel.Visible = False
            End If

        End If

        'popolo le dropdown office e contact in base alla selezione
        Dim DDLoffice As DropDownList = DetailsViewVisit.FindControl("officeID")
        Try
            DDLoffice.Items.AddRange(BLL.Get_office_from_client(DetailsViewVisit))
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try


    End Sub

    Protected Sub officeID_SelectedIndexChanged(sender As Object, e As EventArgs)
        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If DetailsViewVisit.CurrentMode = DetailsViewMode.Edit Then

            Dim officeval As DropDownList = DetailsViewVisit.FindControl("officeID")
            Dim officelabel As Label = DetailsViewVisit.FindControl("office_annull")
            If officeval.SelectedValue = "" Then
                officelabel.Visible = False
                Exit Sub
            End If

            Dim ctx As New AcomContext
            Dim query As office
            Try
                query = ctx.offices.Where(Function(p) p.ID = officeval.SelectedValue).FirstOrDefault
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try

            If query.annull = True Then
                officelabel.Visible = True
            Else
                officelabel.Visible = False
            End If
        End If
    End Sub

    Protected Sub officeID_DataBinding(sender As Object, e As EventArgs)
        Dim DDLoffice As DropDownList = DetailsViewVisit.FindControl("officeID")
        Try
            DDLoffice.Items.AddRange(BLL.Get_office_from_client(DetailsViewVisit))
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

    End Sub

    Public Function Get_agent()
        Try
            Return BLL.Get_agent(DetailsViewVisit.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub agentID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim agentval As DropDownList = DetailsViewVisit.FindControl("agentID")
        Dim agentlabel As Label = DetailsViewVisit.FindControl("agent_annull")
        If agentval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            agentlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As agent
        Try
            query = ctx.agents.Where(Function(p) p.ID = agentval.SelectedValue).Single
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        If query.annull = True Then
            agentlabel.Visible = True
        Else
            agentlabel.Visible = False
        End If

    End Sub

    Protected Sub motivo_tipo_DataBinding(sender As Object, e As EventArgs)
        Dim DDLmotivo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        DDLmotivo.Items.Clear()
        DDLmotivo.DataSource = BLL.Enumeration.GetAll(Of motivo)()
        DDLmotivo.DataValueField = "Key"
        DDLmotivo.DataTextField = "Value"
        DDLmotivo.Items.Add("")

    End Sub

    'sub accessibile solo in fase di insert
    Protected Sub motivo_tipo_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim data_visit As TextBox = DetailsViewVisit.FindControl("data")
        'controllo se la data evento è stata inserita, per evitare errori di runtime
        If String.IsNullOrEmpty(data_visit.Text) Then
            errormsg.Visible = True
            errormsg.Text = "Inserire data evento"
            data_visit.Focus()
            Exit Sub
        End If

        Dim motivo As DropDownList = sender
        If motivo.SelectedValue = "" Then Exit Sub
        Dim prev_num As TextBox = DetailsViewVisit.FindControl("preventivo_num")
        If motivo.SelectedValue = 1 Then
            prev_num.Enabled = False
        Else
            prev_num.Enabled = True
        End If

        'visit_logic(sender.ID)
    End Sub

    'sub accessibile sia in insert che in update
    Protected Sub stato_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim data_visit As TextBox = DetailsViewVisit.FindControl("data")
        'controllo se la data evento è stata inserita, per evitare errori di runtime
        If String.IsNullOrEmpty(data_visit.Text) Then
            errormsg.Visible = True
            errormsg.Text = "Inserire data evento"
            data_visit.Focus()
            Exit Sub
        End If

        Dim motivo_tipo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        'controllo se il motivo tipo è inserito
        If motivo_tipo.SelectedValue = "" Then
            errormsg.Visible = True
            errormsg.Text = "Inserire motivo evento"
            motivo_tipo.Focus()
            Exit Sub
        End If

        'adesso che ho due parametri definiti sicuramente, vado a visit_logic

        'visit_logic(sender.ID)
    End Sub

    'sub accessibile in fase di insert; in fase di update solo se motivo è preventivo
    Protected Sub preventivo_num_TextChanged(sender As Object, e As EventArgs)

        Dim data_visit As TextBox = DetailsViewVisit.FindControl("data")
        'controllo se la data evento è stata inserita, per evitare errori di runtime
        If String.IsNullOrEmpty(data_visit.Text) Then
            errormsg.Visible = True
            errormsg.Text = "Inserire data evento"
            data_visit.Focus()
            Exit Sub
        End If

        Dim motivo_tipo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        'controllo se il motivo tipo è inserito
        If motivo_tipo.SelectedValue = "" Then
            errormsg.Visible = True
            errormsg.Text = "Inserire motivo evento"
            motivo_tipo.Focus()
            Exit Sub
        End If

        'adesso che ho due parametri definiti sicuramente, vado a visit_logic
        'visit_logic(sender.ID)

    End Sub

    Public Function visit_logic(senderID As String) As Boolean

        Dim data_visit As TextBox = DetailsViewVisit.FindControl("data")
        Dim motivo_tipo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        Dim stato As DropDownList = DetailsViewVisit.FindControl("stato")
        Dim prev_num As TextBox = DetailsViewVisit.FindControl("preventivo_num")
        Dim data_pross As TextBox = DetailsViewVisit.FindControl("data_prossima")
        Dim data_prox As RequiredFieldValidator = DetailsViewVisit.FindControl("Required_data_prossima")
        Dim prev_num_req As RequiredFieldValidator = DetailsViewVisit.FindControl("Required_offerta")
        Dim dataevent As Date
        Date.TryParseExact(data_visit.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataevent)
        
        Select Case senderID

            Case data_visit.ID 'arrivo da selezione di data evento

                If dataevent > Today Then 'la data è futura, oggi è passato
                    'controllo il valore selezionato nello stato e lo setto su pending non modificabile
                    If stato.Items.FindByValue("pending").Enabled = False Then
                        stato.Enabled = True
                        stato.Items.FindByValue("pending").Enabled = True
                        stato.SelectedValue = "pending"
                        stato.Enabled = False
                    Else
                        stato.Enabled = True
                        stato.Items.FindByValue("pending").Enabled = True
                        stato.SelectedValue = "pending"
                        stato.Enabled = False
                    End If
                    'se la data è futura non ha senso mettere una data prossimo evento, la disabilito
                    data_pross.Enabled = False
                    data_prox.Enabled = False
                    Return True
                Else 'la data è passata, devo controllare motivo e stato
                    Select Case motivo_tipo.SelectedValue
                        Case 1 'public relation, attivo stato e disattivo lo stato pending, attivo data prossimo evento e il suo validator, disattivo preventivo_num
                            stato.Enabled = True
                            stato.Items.FindByValue("pending").Enabled = False
                            stato.Items.FindByValue("review").Selected = True
                            data_pross.Enabled = True
                            data_prox.Enabled = True
                            prev_num.Enabled = False
                        Case 2
                            'preventivo, controllo se preventivo è compilato e attivo/disattivo stato di conseguenza
                            prev_num.Enabled = True
                            If String.IsNullOrEmpty(prev_num.Text) Then 'nessun preventivo inserito, seleziono pending e disattivo stato
                                stato.Items.FindByValue("pending").Enabled = True
                                stato.SelectedValue = "pending"
                                stato.Enabled = False
                            Else 'preventivo inserito, attivo stato e disattivo il pending e attivo data prossimo evento e relativo validator
                                stato.Enabled = True
                                stato.Items.FindByValue("pending").Enabled = False
                                stato.Items.FindByValue("review").Selected = True
                                data_pross.Enabled = True
                                data_prox.Enabled = True
                            End If
                        Case Else
                            'nessun motivo selezionato, abilito data prossimo evento e ritorno senza fare nulla
                            data_pross.Enabled = True
                    End Select

                    Return True
                End If

            Case motivo_tipo.ID 'arrivo da selezione di motivo, ci arrivo sicuramente SOLO da inserimento
                Select Case motivo_tipo.SelectedValue
                    Case 1 'public relation, attivo stato e disattivo lo stato pending, seleziono review e rendo obbligatori la data prossimo evento
                        If dataevent > Today Then 'data futura, imposto stato a pending e lo disattivo, disattivo data prossimo evento
                            stato.Enabled = True
                            stato.Items.FindByValue("pending").Selected = True
                            stato.Enabled = False
                            data_pross.Enabled = False
                        Else 'data passata, attivo lo stato e disattivo il pending, attivo data prossimo evento e relativo validator
                            stato.Enabled = True
                            stato.Items.FindByValue("pending").Enabled = False
                            stato.Items.FindByValue("review").Selected = True
                            data_pross.Enabled = True
                            data_prox.Enabled = True
                        End If
                        'disattivo in ogni caso il campo preventivo numero
                        prev_num.Enabled = False
                    Case 2 'preventivo, controllo se preventivo è compilato e attivo/disattivo stato di conseguenza
                        If dataevent > Today Then 'la data è futura quindi non posso inserire data prossimo evento
                            data_pross.Enabled = False
                            data_prox.Enabled = False
                        Else 'data passata, riattivo data prossimo evento
                            data_pross.Enabled = True
                            data_prox.Enabled = True
                        End If
                        If String.IsNullOrEmpty(prev_num.Text) Then 'nessun preventivo inserito, seleziono stato pending e disattivo stato
                            stato.Enabled = True
                            stato.Items.FindByValue("pending").Enabled = True
                            stato.SelectedValue = "pending"
                            stato.Enabled = False
                        Else 'preventivo inserito, attivo stato e disattivo il pending, attivo data prossimo evento e relativo validator. 
                            'ATTENZIONE SE DATA E' FUTURA
                            stato.Enabled = True
                            stato.Items.FindByValue("pending").Enabled = False
                            If dataevent > Today Then 'con preventivo compilato e data futura l'unica opzione è chiudere l'evento
                                stato.Items.FindByValue("closed").Selected = True
                                stato.Enabled = False
                            Else 'con preventivo compilato e data passata posso impostare una data prossimo evento, che genererà un nuovo evento al salvataggio
                                stato.Items.FindByValue("review").Selected = True
                                data_pross.Enabled = True
                                data_prox.Enabled = True
                            End If
                        End If
                    Case Else 'nessun motivo selezionato, verrò rimandato qui da altre modifiche perchè motivo deve essere inserito
                        Return False
                End Select

            Case prev_num.ID 'arrivo da inserimento numero preventivo, che se è abilitato vuol dire che sono in motivo preventivo
                If dataevent > Today Then 'la data è futura quindi non posso inserire data prossimo evento
                    data_pross.Enabled = False
                    data_prox.Enabled = False
                Else 'data passata, riattivo data prossimo evento
                    data_pross.Enabled = True
                    data_prox.Enabled = True
                End If
                If String.IsNullOrEmpty(prev_num.Text) Then 'nessun preventivo inserito, disattivo stato e selezioni stato pending
                    stato.Enabled = True
                    stato.Items.FindByValue("pending").Enabled = True
                    stato.SelectedValue = "pending"
                    stato.Enabled = False
                Else 'preventivo inserito
                    If dataevent > Today Then 'la data è futura quindi non posso inserire data prossimo evento
                        stato.Enabled = True
                        stato.SelectedValue = "closed"
                        stato.Enabled = False
                        data_pross.Enabled = False
                        data_prox.Enabled = False
                    Else 'data passata, riattivo data prossimo evento
                        stato.Enabled = True
                        stato.Items.FindByValue("pending").Enabled = False
                        stato.SelectedValue = "review"
                        data_pross.Enabled = True
                        data_prox.Enabled = True
                    End If
                End If

            Case data_pross.ID 'arrivo da inserimento data prossimo evento, posso essere sia in preventivo che public relation, di sicuro non in data futura, cambio lo stato in review fisso

                If String.IsNullOrEmpty(data_pross.Text) Then 'senza data prossimo evento lo stato può essere qualunque
                    stato.Enabled = True
                    data_prox.Enabled = True
                Else 'con data prossimo evento lo stato viene impostato fisso su review, che causerà il lancio di un evento di sistema
                    stato.Enabled = True
                    stato.Items.FindByValue("review").Enabled = True
                    stato.SelectedValue = "review"
                    stato.Enabled = False
                End If

            Case stato.ID
                If dataevent > Today Then Return False
                Select Case stato.SelectedValue
                    Case "review"
                        data_pross.Enabled = True
                        data_prox.Enabled = True
                    Case "closed"
                        If motivo_tipo.SelectedValue = 2 Then 'preventivo, lo stato non può essere closed senza un numero di offerta
                            If String.IsNullOrEmpty(prev_num.Text) Then
                                prev_num_req.Enabled = True
                            End If
                        End If
                        Return True
                    Case Else 'in fase di update posso avere la combinazione PR-Pending che devo evitare
                        If motivo_tipo.SelectedValue = 1 Then 'Public relation
                            If stato.SelectedValue = "pending" Then
                                errormsg.Visible = True
                                errormsg.Text = "L'evento pubbliche relazioni non può essere lasciato in attesa"
                            End If
                        End If
                        Return False
                End Select

            Case Else
                Return False
        End Select

        Return True

    End Function

    Public Function new_system_event(id As Integer) As Boolean

        Dim motivo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        Dim offerta As TextBox = DetailsViewVisit.FindControl("preventivo_num")
        Dim data_prox As TextBox = DetailsViewVisit.FindControl("data_prossima")
        Dim status As DropDownList = DetailsViewVisit.FindControl("stato")

        'Dim agentectrl As Control = DetailsViewVisit.FindControl("agentID")
        'Dim clientectrl As Control = DetailsViewVisit.FindControl("clienteID")
        'Dim filialectrl As Control = DetailsViewVisit.FindControl("officeID")
        'Dim motivodesc As TextBox = DetailsViewVisit.FindControl("motivo_descrizione")
        'Dim data As TextBox = DetailsViewVisit.FindControl("data")
        'Dim ordine As TextBox = DetailsViewVisit.FindControl("ordine_num")
        'Dim offertaest As TextBox = DetailsViewVisit.FindControl("offerta_est")

        'If agentectrl.GetType.Name = "Label" Then
        'Dim agente As Label = agentectrl
        'Dim agentetxt As String = agente.Text
        'ElseIf agentectrl.GetType.Name = "DropDownList" Then
        'Dim agente As DropDownList = agentectrl
        'Dim agenteval As Integer = agente.SelectedValue
        'End If


        If status.SelectedValue = "review" Then 'lo stato è in review

            If Not String.IsNullOrEmpty(data_prox.Text) Then 'ho compilato il campo data prossimo evento

                'If motivo.SelectedValue = 1 Or (motivo.SelectedValue = 2 And Not String.IsNullOrEmpty(offerta.Text)) Then 'il motivo deve essere PR o preventivo con numero preventivo compilato

                'cerco il record dell'evento padre tramite l'id e ne modifico lo stato in closed
                Dim ctx As New AcomContext
                Dim fatherItem As New Acom1.Models.visit
                fatherItem = ctx.visits.Single(Function(p) p.ID = id)

                fatherItem.stato = "closed"
                fatherItem.updatedby = "System"
                fatherItem.data_upd = Today

                If fatherItem Is Nothing Then
                    ' Elemento non trovato
                    ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
                    Return False
                End If

                TryUpdateModel(fatherItem)
                If ModelState.IsValid Then
                    Try
                        ctx.SaveChanges()
                    Catch ex As DBConcurrencyException
                        errormsg.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
                        errormsg.Visible = True
                    Catch ex1 As Exception
                        errormsg.Text = ex1.Message
                        errormsg.Visible = True
                    End Try
                End If

                'inserisco l'evento di sistema con data = data prossimo
                Dim item As New Acom1.Models.visit

                item.agentID = fatherItem.agentID
                item.clientID = fatherItem.clientID
                item.officeID = fatherItem.officeID
                item.motivo_type = fatherItem.motivo_type
                item.motivo_desc = "Autogenerato - " & fatherItem.motivo_desc
                item.stato = "pending"
                item.createdby = "System"
                item.data_ins = Today

                'item.data = Date.Parse(data_prox.Text)
                If Date.TryParseExact(data_prox.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, item.data) = False Then
                    errormsg.Text = "Attenzione il formato di Data prossimo evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
                    errormsg.Visible = True
                    Return False
                End If

            If item Is Nothing Then
                ModelState.AddModelError("", "Nessun elemento inserito")
                Return False
            Else
                ctx.visits.Add(item)
            End If

            TryUpdateModel(item)
            If ModelState.IsValid Then
                Try
                    ctx.SaveChanges()
                Catch ex As Exception
                    errormsg.Text = ex.Message
                    errormsg.Visible = True
                End Try
            End If
            'Else 'il motivo non è PR o non è preventivo e il numero preventivo non è stato compilato
            'Return False
            'End If
        Else 'data prossimo non è compilato, ritorno false che mi serve per reindirizzare alla pagina giusta
            Return False
        End If
        Else 'lo stato non è di review, ritorno false per reindirizzare alla pagina giusta
        Return False
        End If

        Return True

    End Function

    Protected Sub data_TextChanged(sender As Object, e As EventArgs)
        Dim data As TextBox = DetailsViewVisit.FindControl("data")
        Dim dataevent As Date

        If Date.TryParseExact(data.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataevent) = False Then
            errormsg.Text = "Attenzione il formato di Data evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
            errormsg.Visible = True
            Exit Sub
        End If


    End Sub


    Protected Sub data_prossima_TextChanged(sender As Object, e As EventArgs)

        Dim data As TextBox = DetailsViewVisit.FindControl("data")
        Dim dataprossima As TextBox = DetailsViewVisit.FindControl("data_prossima")
        Dim dataevent As Date
        Dim dataproxevent As Date

        If Date.TryParseExact(data.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataevent) = False Then
            errormsg.Text = "Attenzione il formato di Data evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
            errormsg.Visible = True
            Exit Sub
        End If

        If Date.TryParseExact(dataprossima.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataproxevent) = False Then
            errormsg.Text = "Attenzione il formato di Data prossimo evento non è valido, il formato corretto è gg/mm/aaaa hh:mm"
            errormsg.Visible = True
            Exit Sub
        End If
        
        'controllo se data prossima esiste ed è successiva a data
        If Not String.IsNullOrEmpty(dataprossima.Text) Then
            If dataproxevent < dataevent Then
                errormsg.Visible = True
                errormsg.Text = "Attenzione, la data prossimo evento non può essere antecedente la data dell'evento"
                Exit Sub
            End If
        End If

    End Sub

    Sub ShowMessageBox(ByVal message As String)
        Response.Write(String.Format("<script type=text/javascript>alert('{0}')</script>", message))
    End Sub

    Public Function visit_logic2()

        Dim data_visit As TextBox = DetailsViewVisit.FindControl("data")
        Dim motivo_tipo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        Dim stato As DropDownList = DetailsViewVisit.FindControl("stato")
        Dim prev_num As TextBox = DetailsViewVisit.FindControl("preventivo_num")
        Dim data_pross As TextBox = DetailsViewVisit.FindControl("data_prossima")
        Dim data_prox As RequiredFieldValidator = DetailsViewVisit.FindControl("Required_data_prossima")
        Dim prev_num_req As RequiredFieldValidator = DetailsViewVisit.FindControl("Required_offerta")
        Dim dataevent As Date

        Date.TryParseExact(data_visit.Text, "dd/MM/yyyy HH:mm", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataevent)

        If dataevent > Today Then 'data futura
            data_pross.Text = ""
            data_pross.Enabled = False 'non posso aggiungere una data prossimo evento ad un evento futuro
            Select Case motivo_tipo.SelectedValue
                Case 1 'public relation
                    prev_num.Enabled = False
                    stato.Enabled = True
                    stato.ClearSelection()
                    stato.Items.FindByValue("pending").Enabled = True
                    stato.Items.FindByValue("pending").Selected = True
                    stato.Enabled = False
                Case 2 'preventivo
                    prev_num.Enabled = True
                    If String.IsNullOrEmpty(prev_num.Text) Then 'preventivo vuoto, stato in attesa finchè non lo riempio
                        stato.Enabled = True
                        stato.ClearSelection()
                        stato.Items.FindByValue("pending").Enabled = True
                        stato.Items.FindByValue("pending").Selected = True
                        stato.Enabled = False
                    Else 'preventivo compilato, stato closed non modificabile, ma dovrebbe già essere closed!!!
                        stato.Enabled = True
                        stato.ClearSelection()
                        stato.Items.FindByValue("closed").Enabled = True
                        stato.Items.FindByValue("closed").Selected = True
                        stato.Enabled = False
                    End If
            End Select
        Else 'la data è passata
            data_pross.Enabled = True
            Select Case motivo_tipo.SelectedValue
                Case 1 'public relation
                    prev_num.Enabled = False
                    If Not String.IsNullOrEmpty(data_pross.Text) Then 'c'è data prossimo evento, imposto lo stato a review 
                        stato.Enabled = True
                        stato.ClearSelection()
                        stato.Items.FindByValue("pending").Enabled = False
                        stato.Items.FindByValue("review").Enabled = True
                        stato.Items.FindByValue("review").Selected = True
                        stato.Enabled = False
                    Else 'non c'è data prossimo evento, imposto lo stato a pending e disabilito review perchè non c'è la data
                        'posso comunque chiudere l'evento così com'è
                        stato.Enabled = True
                        stato.ClearSelection()
                        stato.Items.FindByValue("pending").Enabled = True
                        stato.Items.FindByValue("review").Enabled = False
                        stato.Items.FindByValue("pending").Selected = True
                    End If
                Case 2 'preventivo
                    prev_num.Enabled = True
                    If String.IsNullOrEmpty(prev_num.Text) Then 'preventivo vuoto, stato in attesa finchè non lo riempio, data pross disabilitata perchè priorità all'associazione ad un preventivo
                        data_pross.Enabled = False
                        stato.Enabled = True
                        stato.ClearSelection()
                        stato.Items.FindByValue("pending").Selected = True
                        stato.Enabled = False
                    Else 'preventivo compilato, stato closed non modificabile
                        If String.IsNullOrEmpty(data_pross.Text) Then 'data pross vuoto, stato closed non modificabile
                            stato.Enabled = True
                            stato.ClearSelection()
                            stato.Items.FindByValue("closed").Selected = True
                            stato.Enabled = False
                        Else 'data pross inserita, stato review non modificabile, lo stato verrà cambiato in automatico a closed all'aggiornamento
                            stato.Enabled = True
                            stato.ClearSelection()
                            stato.Items.FindByValue("review").Selected = True
                            stato.Enabled = False
                        End If
                    End If
            End Select
        End If

        Return True
    End Function


    Protected Sub btnok_Click(sender As Object, e As EventArgs)
        modalpop.Hide()
        Response.Redirect("~/User/VisiteIns.aspx")

    End Sub

    Protected Sub btnNo_Click(sender As Object, e As EventArgs)
        modalpop.Hide()
        If User.IsInRole("User") Then
            Response.Redirect("~/User/Home.aspx")
        ElseIf User.IsInRole("DataEntry") Then
            Response.Redirect("~/User/HomeDE.aspx")
        End If

    End Sub

End Class