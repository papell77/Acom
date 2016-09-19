Imports Acom1.BLL
Imports Acom1.DAL
Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports Microsoft.Reporting.WebForms
Imports System.IO

Public Class OfferteDettaglio
    Inherits System.Web.UI.Page

    Private ctx As New AcomContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id As Integer = Request.QueryString("ID")

        If Not Page.IsPostBack Then
            If id <> 0 Then
                DetailsViewOffer.ChangeMode(DetailsViewMode.Edit)
                'il campo hidden offertaID mi serve per inviare l'ID in post al click di StampaOfferta
                offertaID.Value = Request.QueryString("ID")
            End If
        End If


    End Sub

    Public Function DetailsViewOffer_GetItem(<QueryString("ID")> ByVal id As Nullable(Of Integer)) As IQueryable(Of ViewOfferInsert)
        Dim context As New AcomLinqContextDataContext
        Dim query = context.ViewOfferInsert.Where(Function(p) p.ID = id)

        'il viewstate serve per memorizzare i valori di clientID e numero offerta da utilizzare in duplica preventivo e crea nuova versione
        ViewState("clientID") = query.Select(Function(p) p.clientID).FirstOrDefault
        ViewState("offer_num") = query.Select(Function(p) p.offer_num).FirstOrDefault
        ViewState("agentID") = query.Select(Function(p) p.agentID).FirstOrDefault
        ViewState("familyID") = query.Select(Function(p) p.familyID).FirstOrDefault

        Return query

    End Function

    Public Function GridViewRows_GetData(<QueryString("ID")> ByVal ID As Nullable(Of Integer)) As IQueryable(Of Acom1.ViewOfferRowDetail)

        Dim context As New AcomLinqContextDataContext
        Dim query = context.ViewOfferRowDetail.Where(Function(p) p.offerID = ID)

        'Dim query = ctx.offer_rows.Where(Function(p) p.offerID = ID)

        If query.Count = 0 Then
            Return Nothing
        Else
            'per aggiornare il totale dell'offerta
            TotOfferta_calc(ID)
            Return query
        End If


    End Function

    Protected Function TotOfferta_calc(ByVal id As Nullable(Of Integer))

        If id = 0 Or id Is Nothing Then
            Return Nothing
        Else
            Dim context As New AcomLinqContextDataContext
            Try
                Dim query = context.ViewOfferTot.Where(Function(p) p.offerID = id).Select(Function(c) c.totale_offer).Single
                Return query
            Catch ex As InvalidOperationException
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return Nothing
            Catch ex1 As Exception
                errormsg.Text = ex1.Message
                errormsg.Visible = True
                Return Nothing
            End Try
        End If

    End Function

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
        item.familyID = familyID
        item.data_valid = Today
        item.stato = "In attesa"
        item.created_by = User.Identity.Name
        item.created_date = Now

        If item Is Nothing Then
            Return
        End If

        ctx.offers.Add(item)

        If ModelState.IsValid Then

            Try
                ctx.SaveChanges()
            Catch ex As Exception
                Return
            End Try

        End If

        Dim offerID As Integer
        offerID = item.ID
        Dim query As List(Of offer_row)
        'Nel duplicato non vengono inserite le righe annullate
        query = ctx.offer_rows.Where(Function(p) p.offerID = ID And p.annull = False).ToList

        'per ogni record in query aggiorno i valori che mi servono nel duplicato
        For Each p In query
            query.First(Function(c) c.offerID = ID).updated_by = ""
            query.First(Function(c) c.offerID = ID).updated_date = Nothing
            query.First(Function(c) c.offerID = ID).created_by = User.Identity.Name
            query.First(Function(c) c.offerID = ID).created_date = Now

            'sostituisco il valore originale di offerID con il nuovo valore della offerta duplicata
            query.First(Function(c) c.offerID = ID).offerID = offerID
        Next

        ctx.offer_rows.AddRange(query)

        Try
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

        Dim numero_offerta As Nullable(Of Integer) = ViewState("offer_num")

        If ID = 0 Or ID Is Nothing Then
            Exit Sub
        End If

        If numero_offerta = 0 Or numero_offerta Is Nothing Then
            Exit Sub
        End If

        Dim offerta As offer = BLL.new_offer(numero_offerta)

        Dim query_offer As New offer
        query_offer = ctx.offers.Where(Function(p) p.ID = ID).FirstOrDefault

        'sostituisco i valori della versione padre con i nuovi valori
        query_offer.offer_code = offerta.offer_code
        query_offer.offer_num = offerta.offer_num
        query_offer.offer_vers = offerta.offer_vers
        query_offer.created_by = User.Identity.Name
        query_offer.created_date = Now
        query_offer.updated_by = ""
        query_offer.updated_date = Nothing

        ctx.offers.Add(query_offer)

        Try
            ctx.SaveChanges()
        Catch ex As Exception
            Return
        End Try

        Dim offerID As Integer
        offerID = query_offer.ID
        Dim query_rows As List(Of offer_row)
        'Nella nuova versione non vengono inserite le righe annullate
        query_rows = ctx.offer_rows.Where(Function(p) p.offerID = ID And p.annull = False).ToList

        'per ogni record in query aggiorno i valori che mi servono nel duplicato
        For Each p In query_rows
            query_rows.First(Function(c) c.offerID = ID).updated_by = ""
            query_rows.First(Function(c) c.offerID = ID).updated_date = Nothing
            query_rows.First(Function(c) c.offerID = ID).created_by = User.Identity.Name
            query_rows.First(Function(c) c.offerID = ID).created_date = Now

            'sostituisco il valore originale di offerID con il nuovo valore della offerta duplicata
            query_rows.First(Function(c) c.offerID = ID).offerID = offerID
        Next

        ctx.offer_rows.AddRange(query_rows)

        If ModelState.IsValid Then

            Try
                ctx.SaveChanges()
            Catch ex As Exception
                Return
            End Try

            Response.Redirect("/User/OfferteIns?ID=" & offerID)

        End If

    End Sub

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub DetailsViewOffer_UpdateItem(ByVal id As Integer)

        Dim item As New Acom1.Models.offer
        Dim annull As CheckBox = DetailsViewOffer.FindControl("annull")
        Dim importo As Label = DetailsViewOffer.FindControl("importo")
        Dim costotrasp As Label = DetailsViewOffer.FindControl("costo_trasporto")

        item = ctx.offers.Where(Function(p) p.ID = id).FirstOrDefault
        item.updated_by = User.Identity.Name
        item.updated_date = Today
        item.annull = annull.Checked
        If Not item.importo Is Nothing Then
            item.importo = FormatNumber(importo.Text, 2)
        End If
        If Not item.costo_trasporto Is Nothing Then
            item.costo_trasporto = FormatNumber(costotrasp.Text, 2)
        End If

        If item Is Nothing Then
            ' Elemento non trovato
            ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
            Return
        End If
        TryUpdateModel(item)
        If ModelState.IsValid Then

            Try
                ctx.SaveChanges()
                Response.Write("<script type=text/javascript>if(confirm('Offerta correttamente modificata')) document.location = 'Home.aspx';</script>")
            Catch ex As DBConcurrencyException
                errormsg.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
                errormsg.Visible = True
            Catch ex1 As Exception
                errormsg.Text = ex1.Message
                errormsg.Visible = True
            End Try

        Else
            errormsg.Text = "Attenzione, errore durante l'aggiornamento del modello"
            errormsg.Visible = True
        End If

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
        'Response.ClearHeaders()
        'Response.ClearContent()
        'Response.ContentType = "application/ms-word"
        'Response.AddHeader("content-disposition", "attachment;filename=Offerta.doc")
        'Response.BinaryWrite(bytes)

        'Response.AppendHeader("Content-Lenght", bytes.Length.ToString)
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

    Protected Sub DDLClient_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim clientval As DropDownList = DetailsViewOffer.FindControl("clienteID")
        Dim clientlabel As Label = DetailsViewOffer.FindControl("client_annull")

        If clientval.SelectedValue = "" Then
            clientlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New client

        Try
            query = ctx.clients.Where(Function(p) p.ID = clientval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            Throw New ArgumentException(ex.Message, ex)
        End Try

        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If DetailsViewOffer.CurrentMode = DetailsViewMode.Edit Then

            If query.annull = True Then
                clientlabel.Visible = True
            Else
                clientlabel.Visible = False
            End If

        End If

        'popolo le dropdown office e contact in base alla selezione
        Dim DDLoffice As DropDownList = DetailsViewOffer.FindControl("officeID")
        Dim DDLcontact As DropDownList = DetailsViewOffer.FindControl("contactID")
        DDLoffice.Items.AddRange(BLL.Get_office_from_client(DetailsViewOffer))
        DDLcontact.Items.AddRange(BLL.Get_contact_from_client(DetailsViewOffer))

        'seleziono il valore di payment e transport nelle rispettive DDL in base al cliente selezionato
        Dim DDLpayment As DropDownList = DetailsViewOffer.FindControl("paymentID")
        Dim DDLtransport As DropDownList = DetailsViewOffer.FindControl("transportID")
        If Not query.paymentID Is Nothing Then
            DDLpayment.SelectedValue = query.paymentID
        End If
        If Not query.transportID Is Nothing Then
            DDLtransport.SelectedValue = query.transportID
        End If

    End Sub

    Protected Sub DDLoffice_DataBinding(sender As Object, e As EventArgs)
        Dim DDLoffice As DropDownList = DetailsViewOffer.FindControl("officeID")
        Try
            DDLoffice.Items.AddRange(BLL.Get_office_from_client(DetailsViewOffer))
        Catch ex As Exception
            Throw New ArgumentException(ex.Message, ex)
        End Try

    End Sub

    Protected Sub officeID_SelectedIndexChanged(sender As Object, e As EventArgs)
        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If DetailsViewOffer.CurrentMode = DetailsViewMode.Edit Then

            Dim officeval As DropDownList = DetailsViewOffer.FindControl("officeID")
            Dim officelabel As Label = DetailsViewOffer.FindControl("office_annull")
            If officeval.SelectedValue = "" Then
                officelabel.Visible = False
                Exit Sub
            End If

            Dim ctx As New AcomContext
            Dim query As New office

            Try
                query = ctx.offices.Where(Function(p) p.ID = officeval.SelectedValue).FirstOrDefault()
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

            If query.annull = True Then
                officelabel.Visible = True
            Else
                officelabel.Visible = False
            End If

            'popolo la dropdown contacts in base al valore di office selezionato
            Dim DDLcontact As DropDownList = DetailsViewOffer.FindControl("contactID")
            DDLcontact.Items.AddRange(BLL.Get_contact_from_client(DetailsViewOffer))

        ElseIf DetailsViewOffer.CurrentMode = DetailsViewMode.Insert Then '

            'popolo la dropdown contacts in base al valore di office selezionato
            Dim DDLcontact As DropDownList = DetailsViewOffer.FindControl("contactID")
            DDLcontact.Items.AddRange(BLL.Get_contact_from_client(DetailsViewOffer))

        End If
    End Sub

    Protected Sub DDLContact_DataBinding(sender As Object, e As EventArgs)
        Dim DDLcontact As DropDownList = DetailsViewOffer.FindControl("contactID")
        Try
            DDLcontact.Items.AddRange(BLL.Get_contact_from_client(DetailsViewOffer))
        Catch ex As Exception
            Throw New ArgumentException(ex.Message, ex)
        End Try
    End Sub

    Protected Sub contactID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim contactval As DropDownList = DetailsViewOffer.FindControl("contactID")
        Dim contactlabel As Label = DetailsViewOffer.FindControl("contact_annull")
        If contactval.SelectedValue = "" Then
            contactlabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New contactname
        Try
            ctx.contacts.Where(Function(p) p.ID = contactval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            Throw New ArgumentException
        End Try

        If query.annull = True Then
            contactlabel.Visible = True
        Else
            contactlabel.Visible = False
        End If
    End Sub

    Protected Sub familyID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim familyval As DropDownList = DetailsViewOffer.FindControl("familyID")
        Dim familylabel As Label = DetailsViewOffer.FindControl("family_annull")
        If familyval.SelectedValue = "" Then
            familylabel.Visible = False
            Exit Sub
        End If

        Dim ctx As New AcomContext
        Dim query As New family

        Try
            ctx.family.Where(Function(p) p.ID = familyval.SelectedValue).FirstOrDefault()
        Catch ex As Exception
            Throw New ArgumentException(ex.Message, ex)
        End Try

        If query.annull = True Then
            familylabel.Visible = True
        Else
            familylabel.Visible = False
        End If

    End Sub
End Class