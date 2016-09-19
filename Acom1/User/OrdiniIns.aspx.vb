Imports Acom1.BLL
Imports Acom1.DAL
Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports System.Data.Entity.Infrastructure

Public Class OrdiniIns1
    Inherits System.Web.UI.Page

    Private ctx As New AcomContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            Dim id As Integer = Request.QueryString("ID")

            'se la pagina viene caricata senza riferimento all'id offerta, apro in modalità inserimento
            If id = 0 Then

                DetailsViewOrder.ChangeMode(DetailsViewMode.Insert)
                ListViewOrderRow.Visible = False 'la tabella di inserimento nuove righe ordine viene nascosta

            End If

            'If DetailsViewOrder.CurrentMode = DetailsViewMode.Insert Then
            'End If

            'nascondo il pulsante "nuovo" nella visualizzazione modifica della detailsview
            If DetailsViewOrder.CurrentMode = DetailsViewMode.ReadOnly Then
                DetailsViewOrder.AutoGenerateInsertButton = False
            End If
        End If

    End Sub

    ' Il parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    ' o essere decorato con un attributo del provider di valori, ad esempio <QueryString>ByVal id as Integer
    Public Function DetailsViewOrder_GetItem(<QueryString("ID")> ByVal id As Nullable(Of Integer)) As IQueryable(Of ViewOrderIns)
        Dim context As New AcomLinqContextDataContext
        Try
            Return context.ViewOrderIns.Where(Function(p) p.ID = id)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try
    End Function

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub DetailsViewOrder_UpdateItem(ByVal id As Integer)
        Dim item As New Acom1.Models.order
        item = ctx.orders.Where(Function(p) p.ID = id).FirstOrDefault

        If item Is Nothing Then
            ' Elemento non trovato
            ModelState.AddModelError("", String.Format("Elemento con id {0} non trovato", id))
            Return
        Else
            item.updated_by = User.Identity.Name
            item.updated_date = Now
        End If

        TryUpdateModel(item)
        If ModelState.IsValid Then

            Try

                ctx.SaveChanges()
                'Response.Write("<script type=text/javascript>alert('Ordine correttamente modificato')</script>")
                'DetailsViewOrder.DataBind()
            Catch ex As DbUpdateConcurrencyException
                errormsg.Text = "Un altro utente sta modificando questi dati, riprovare più tardi"
                errormsg.Visible = True
            Catch ex1 As Exception
                errormsg.Text = ex1.Message
                errormsg.Visible = True
            End Try

        Else
            errormsg.Text = "Attenzione, errore di aggiornamento nel modello"
            errormsg.Visible = True
            Return
        End If

        Response.Redirect("~/User/OrdiniIns?ID=" & id)


    End Sub

    Public Sub DetailsViewOrder_InsertItem()

        Dim item As New Acom1.Models.order

        Dim order As TextBox = DetailsViewOrder.FindControl("order_code")
        Dim order_num As TextBox = DetailsViewOrder.FindControl("order_num")
        Dim sap As TextBox = DetailsViewOrder.FindControl("order_sap")
        Dim data As TextBox = DetailsViewOrder.FindControl("data")
        Dim impianto As TextBox = DetailsViewOrder.FindControl("rif_impianto")
        Dim agente As DropDownList = DetailsViewOrder.FindControl("agentID")
        Dim cliente As DropDownList = DetailsViewOrder.FindControl("clienteID")
        Dim office As DropDownList = DetailsViewOrder.FindControl("officeID")
        Dim offer As DropDownList = DetailsViewOrder.FindControl("rif_offerta")
        Dim offer_est As TextBox = DetailsViewOrder.FindControl("rif_offertaest")
        Dim orderclient As TextBox = DetailsViewOrder.FindControl("rif_ordinecliente")
        Dim importo As TextBox = DetailsViewOrder.FindControl("importo")
        Dim note As TextBox = DetailsViewOrder.FindControl("note")

        item.order_sap = sap.Text
        item.data = data.Text
        item.rif_impianto = impianto.Text
        item.clientID = cliente.SelectedValue
        item.rif_offertaest = offer_est.Text
        item.rif_ordinecliente = orderclient.Text
        item.note = note.Text
        item.created_by = User.Identity.Name
        item.created_date = Now

        If Not agente.SelectedValue = "" Then
            item.agentID = agente.SelectedValue
        End If

        If Not office.SelectedValue = "" Then
            item.officeID = office.SelectedValue
        End If

        If Not offer.SelectedValue = "" Then
            item.rif_offerta = offer.SelectedValue
        End If

        If IsNumeric(importo.Text) Then
            item.importo = importo.Text
        Else
            item.importo = Nothing
        End If

        'creo il nuovo numero d'ordine
        Dim ordine As New order
        Try
            ordine = BLL.new_order
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        item.order_code = ordine.order_code
        item.order_num = ordine.order_num

        If item Is Nothing Then
            ModelState.AddModelError("", "Nessun elemento inserito")
            Return
        Else
            ctx.orders.Add(item)
        End If

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                ctx.SaveChanges()
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try

            Dim id As Integer = item.ID
            Response.Redirect("~/User/OrdiniIns?ID=" & id)

        Else
            errormsg.Text = "Attenzione, errore nel modello"
            errormsg.Visible = True
            Return
        End If


    End Sub

    Public Function Get_client() As List(Of client)
        Try
            Return BLL.Get_client(DetailsViewOrder.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try
    End Function

    Public Function Get_office() As List(Of office)
        Try
            Return BLL.Get_office(DetailsViewOrder.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try
    End Function

    Public Function Get_offer() As List(Of offer)
        Try
            Return BLL.Get_offer(DetailsViewOrder.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try
    End Function

    Public Function Get_product() As List(Of product)

        Try
            Return BLL.Get_products
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_family() As List(Of family)
        Try
            Return BLL.Get_families
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try
    End Function

    Public Function Get_agent() As List(Of agent)
        Try
            Return BLL.Get_agent(DetailsViewOrder.CurrentMode)
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try
    End Function

    Protected Sub DDLClient_SelectedIndexChanged(sender As Object, e As EventArgs)
        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If DetailsViewOrder.CurrentMode = DetailsViewMode.Edit Then

            Dim clientval As DropDownList = DetailsViewOrder.FindControl("clienteID")
            Dim clientlabel As Label = DetailsViewOrder.FindControl("client_annull")

            If clientval.SelectedValue = "" Then
                clientlabel.Visible = False
                Exit Sub
            End If

            Dim query As client
            Try
                query = ctx.clients.Where(Function(p) p.ID = clientval.SelectedValue).FirstOrDefault
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try

            If query.annull = True Then
                clientlabel.Visible = True
            Else
                clientlabel.Visible = False
            End If

            'popolo le DDL office e offer in base alla selezione di client
            Dim DDLoffice As DropDownList = DetailsViewOrder.FindControl("officeID")
            Dim DDLoffer As DropDownList = DetailsViewOrder.FindControl("rif_offerta")

            Try
                DDLoffice.Items.AddRange(BLL.Get_office_from_client(DetailsViewOrder))
                DDLoffer.Items.AddRange(BLL.Get_offer_from_client(DetailsViewOrder))
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try
            

        Else

            'popolo le DDL office e offer in base alla selezione di client
            Dim DDLoffice As DropDownList = DetailsViewOrder.FindControl("officeID")
            Dim DDLoffer As DropDownList = DetailsViewOrder.FindControl("rif_offerta")
            Try
                DDLoffice.Items.AddRange(BLL.Get_office_from_client(DetailsViewOrder))
                DDLoffer.Items.AddRange(BLL.Get_offer_from_client(DetailsViewOrder))
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try

        End If

    End Sub

    Protected Sub officeID_SelectedIndexChanged(sender As Object, e As EventArgs)


        'devo distinguere il caso del current mode perchè in insert non è necessario il label di annull
        If DetailsViewOrder.CurrentMode = DetailsViewMode.Edit Then

            Dim officeval As DropDownList = DetailsViewOrder.FindControl("officeID")
            Dim officelabel As Label = DetailsViewOrder.FindControl("office_annull")
            If officeval.SelectedValue = "" Then
                officelabel.Visible = False
                Exit Sub
            End If

            Dim query = ctx.offices.Where(Function(p) p.ID = officeval.SelectedValue).FirstOrDefault
            If query.annull = True Then
                officelabel.Visible = True
            Else
                officelabel.Visible = False
            End If

            'popolo la DDL offer in base alla selezione di office
            Dim DDLoffer As DropDownList = DetailsViewOrder.FindControl("rif_offerta")
            Try
                DDLoffer.Items.AddRange(BLL.Get_offer_from_client(DetailsViewOrder))
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try

        Else

            'popolo la DDL offer in base alla selezione di office
            Dim DDLoffer As DropDownList = DetailsViewOrder.FindControl("rif_offerta")
            Try
                DDLoffer.Items.AddRange(BLL.Get_offer_from_client(DetailsViewOrder))
            Catch ex As Exception
                errormsg.Text = ex.Message
                errormsg.Visible = True
                Return
            End Try


        End If

    End Sub

    Protected Sub DDLOffice_DataBinding(sender As Object, e As EventArgs)

        Dim DDLoffice As DropDownList = DetailsViewOrder.FindControl("officeID")
        Try
            DDLoffice.Items.AddRange(BLL.Get_office_from_client(DetailsViewOrder))
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try


    End Sub

    Protected Sub rif_offerta_DataBinding(sender As Object, e As EventArgs)

        Dim DDLoffer As DropDownList = DetailsViewOrder.FindControl("rif_offerta")
        Try
            DDLoffer.Items.AddRange(BLL.Get_offer_from_client(DetailsViewOrder))
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
        End Try

    End Sub

    Protected Sub ListViewOrderRow_ItemInserting(sender As Object, e As ListViewInsertEventArgs)

        SqlDataSourceOrderRow.InsertParameters("orderID").DefaultValue = Request.QueryString("ID")
        SqlDataSourceOrderRow.InsertParameters("created_by").DefaultValue = User.Identity.Name
        SqlDataSourceOrderRow.InsertParameters("created_date").DefaultValue = Today
    End Sub

    Protected Sub agentID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim agentval As DropDownList = DetailsViewOrder.FindControl("agentID")
        Dim agentlabel As Label = DetailsViewOrder.FindControl("agent_annull")
        If agentval.SelectedValue = "" Then 'nessun item selezionato, cancello anche eventuali messaggi di errore
            agentlabel.Visible = False
            Exit Sub
        End If

        Dim query As agent
        Try
            query = ctx.agents.Where(Function(p) p.ID = agentval.SelectedValue).FirstOrDefault
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

    Protected Sub rif_offerta_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim offerval As DropDownList = DetailsViewOrder.FindControl("rif_offerta")
        Dim offerlabel As Label = DetailsViewOrder.FindControl("offerta_annull")
        If offerval.SelectedValue = "" Then
            offerlabel.Visible = False
            Exit Sub
        End If

        Dim query As offer
        Try
            query = ctx.offers.Where(Function(p) p.offer_code = offerval.SelectedValue).FirstOrDefault
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return
        End Try

        If query.annull = True Then
            offerlabel.Visible = True
        Else
            offerlabel.Visible = False
        End If

    End Sub

    Protected Sub SqlDataSourceOrderRow_Updating(sender As Object, e As SqlDataSourceCommandEventArgs)

        e.Command.Parameters("@updated_by").Value = User.Identity.Name
        e.Command.Parameters("@updated_date").Value = Today


    End Sub

    Protected Sub ListViewOrderRow_ItemUpdated(sender As Object, e As ListViewUpdatedEventArgs)

        If e.AffectedRows = 0 Then
            concurrencyViolation.Text = "ATTENZIONE: un altro utente sta modificando questi dati, premere ANNULLA e riprovare"
            concurrencyViolation.Visible = True
            e.KeepInEditMode = True
        End If

    End Sub

    Protected Sub ListViewOrderRow_DataBound(sender As Object, e As EventArgs)

        Dim item As ListViewItem
        Dim prod As DropDownList
        Dim unactive As Label
        Dim index As Integer
        Dim prod_sel As Integer
        Dim query As New product

        For Each item In ListViewOrderRow.Items
            index = item.DataItemIndex
            prod = ListViewOrderRow.Items(index).FindControl("productID")
            unactive = ListViewOrderRow.Items(index).FindControl("annull")
            prod_sel = prod.SelectedValue
            Try
                query = ctx.products.Where(Function(p) p.ID = prod_sel).FirstOrDefault

                If query.annull = True Then
                    prod.BorderColor = Drawing.Color.Red
                    concurrencyViolation.Text = "I prodotti evidenziati non sono attivi"
                    concurrencyViolation.Visible = True
                Else
                    prod.BorderColor = Drawing.Color.Gray
                End If

            Catch ex1 As Exception
                concurrencyViolation.Text = ex1.Message
                concurrencyViolation.Visible = True
            End Try

            query = Nothing
        Next

    End Sub

    Protected Sub productID_SelectedIndexChanged(sender As Object, e As EventArgs)

        'identifico il controllo productID
        Dim prod As DropDownList = sender
        'identifico l'ID del prodotto selezionato nella dropdown
        Dim prod_sel As Integer = prod.SelectedValue
        Dim query As New product

        Try

            query = ctx.products.Where(Function(p) p.ID = prod_sel).FirstOrDefault

            If query.annull = True Then
                prod.BorderColor = Drawing.Color.Red
                'qui ci vorrebbe un messaggio a finestra
                concurrencyViolation.Text = "I prodotti evidenziati non sono attivi"
                concurrencyViolation.Visible = True
            Else
                prod.BorderColor = Drawing.Color.Gray
            End If

        Catch ex As Exception
            concurrencyViolation.Text = ex.Message
            concurrencyViolation.Visible = True
        End Try


    End Sub

    Protected Sub familyID_SelectedIndexChanged(sender As Object, e As EventArgs)
        'identifico il controllo familyID
        Dim family As DropDownList = sender
        'identifico l'ID della famiglia selezionata nella dropdown
        Dim fam_sel As Integer = family.SelectedValue
        Dim query As New family

        Try
            query = ctx.family.Where(Function(p) p.ID = fam_sel).FirstOrDefault

            If query.annull = True Then
                family.BorderColor = Drawing.Color.Red
                concurrencyViolation.Text = "Le famiglie evidenziate non sono attive"
                concurrencyViolation.Visible = True
            Else
                family.BorderColor = Drawing.Color.Gray
            End If
        Catch ex As Exception
            concurrencyViolation.Text = ex.Message
            concurrencyViolation.Visible = True
        End Try
    End Sub
End Class