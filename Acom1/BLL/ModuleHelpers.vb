Imports Acom1.DAL
Imports Acom1.Models
Imports System.Data.Entity
Imports System.Globalization
Imports Microsoft.Reporting.WebForms
Imports System.IO
Imports System.Web
Imports System.Diagnostics
Imports System.Data.OleDb
Imports OfficeOpenXml 'serve per l'importazione del file excel senza l'utilizzo di Oledb


Namespace BLL
    Module ModuleHelpers
        'Private context As New AcomContext

        Public Function Get_username()

            Dim ctx As New AcomContext
            Dim query As List(Of String)
            Try
                query = ctx.agents.Select(Function(p) p.username).ToList()
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

            Return query
        End Function

        Public Function Get_payment(Optional ByVal mode As Integer = 1) As List(Of payment) 'mode=1 è edit

            Dim context As New AcomContext
            If mode = 2 Then 'mode=insert
                Try
                    Return context.payments.Where(Function(p) p.annull = False).OrderBy(Function(p) p.pagamento).ToList()
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.payments.OrderBy(Function(p) p.pagamento).ToList()
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        Public Function Get_transport(Optional ByVal mode As Integer = 1) As List(Of transport) 'mode=1 è edit
            Dim context As New AcomContext
            If mode = 2 Then 'mode=insert
                Try
                    Return context.transports.Where(Function(p) p.annull = False).OrderBy(Function(p) p.trasporto).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.transports.OrderBy(Function(p) p.trasporto).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If

        End Function

        Public Function Get_provincia() As List(Of provincia)
            Dim context As New AcomContext
            Try
                Return context.provincie.Where(Function(p) p.annull = False).OrderBy(Function(p) p.nome).ToList
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try
        End Function

        Public Function Get_comune() As List(Of comune)
            Dim context As New AcomContext
            Try
                Return context.comuni.Where(Function(p) p.annull = False).OrderBy(Function(p) p.nome).ToList
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try
        End Function

        Public Function Get_canal(Optional ByVal mode As Integer = 1) As List(Of canal) 'mode=1 è edit
            Dim context As New AcomContext

            If mode = 2 Then 'mode=insert
                Try
                    Return context.canals.Where(Function(p) p.annull = False).OrderBy(Function(p) p.canal_code).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.canals.OrderBy(Function(p) p.canal_code).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        Public Function Get_agent(Optional ByVal mode As Integer = 1) As List(Of agent) 'mode=1 è edit
            Dim context As New AcomContext

            If mode = 2 Then 'mode=insert
                Try
                    Return context.agents.Where(Function(p) p.annull = False).OrderBy(Function(p) p.name).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.agents.OrderBy(Function(p) p.name).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        Public Function Get_client(Optional ByVal mode As Integer = 1) As List(Of client)'mode=1 è edit
            Dim ctx As New AcomContext
            If mode = 2 Then 'mode=insert
                Try
                    Return ctx.clients.Where(Function(p) p.annull = False).OrderBy(Function(p) p.ragione_sociale).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return ctx.clients.OrderBy(Function(p) p.ragione_sociale).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        Public Function Get_office(Optional ByVal mode As Integer = 1) As List(Of office) 'mode=1 è edit
            Dim context As New AcomContext

            If mode = 2 Then 'mode=insert
                Try
                    Return context.offices.Where(Function(p) p.annull = False).OrderBy(Function(p) p.nome).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.offices.OrderBy(Function(p) p.nome).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        'per popolare la DDL filiali partendo dal valore selezionato di cliente, attenzione a chiamare i controlli clientID e officeID
        Public Function Get_office_from_client(ByVal ctrl As Control)

            'trovo il DDL cliente e office
            Dim DDLclient As DropDownList = ctrl.FindControl("clienteID")
            Dim DDLoffice As DropDownList = ctrl.FindControl("officeID")
            'memorizzo il valore e lo setto a nothing se è stringa vuota
            Dim valclient = DDLclient.SelectedValue
            If valclient = "" Then valclient = Nothing

            'inizializzo la query per ricavarne valori inseribili nella DDLoffice
            Dim ctx As New AcomLinqContextDataContext
            Dim query = From p In ctx.ViewOffice
                        Where p.clientID = valclient And p.annull = False
                        Order By p.nome
                        Select New ListItem(p.nome, p.ID)


            'svuoto la DDLoffice
            DDLoffice.Items.Clear()

            'se valclient è nullo setto a nothing anche la DDLoffice per non mandare in errore in Edititemtemplate
            If valclient = Nothing Then
                DDLoffice.SelectedValue = Nothing
            Else 'altrimenti aggiungo l'elemento vuoto al primo posto
                DDLoffice.Items.Add("")
            End If

            Try
                Return query.ToArray
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

        End Function

        Public Function Get_contact(Optional ByVal mode As Integer = 1) As List(Of contactname) 'mode=1 è edit
            Dim context As New AcomContext

            If mode = 2 Then 'mode=insert
                Try
                    Return context.contacts.Where(Function(p) p.annull = False).OrderBy(Function(p) p.cognome).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.contacts.OrderBy(Function(p) p.cognome).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        'per popolare la DDLcontact in base ai valori delle DDLclient e DDLoffice, funziona come Get_office_from_client con un parametro in più
        Public Function Get_contact_from_client(ByVal ctrl As Control)

            Dim DDLclient As DropDownList = ctrl.FindControl("clienteID")
            Dim DDLoffice As DropDownList = ctrl.FindControl("officeID")
            Dim DDLcontact As DropDownList = ctrl.FindControl("contactID")
            Dim ctx As New AcomLinqContextDataContext

            DDLcontact.Items.Clear()

            Dim valclient = DDLclient.SelectedValue
            If valclient = "" Then
                valclient = Nothing
                DDLcontact.SelectedValue = Nothing
            Else
                DDLcontact.Items.Add("")
            End If

            Dim valoffice = DDLoffice.SelectedValue
            If valoffice = "" Then
                valoffice = Nothing
                'attenzione alla clausola where, il parametro officeID usa HasValue per verificare se è null il campo, Nothing o IsNothing o IsDbNull non funzionano
                Dim query = From p In ctx.contactnames
                           Where p.clientID = valclient And Not p.officeID.HasValue And p.annull = False
                           Order By p.cognome
                           Select New ListItem(p.cognome & " " & p.nome, p.ID)
                Try
                    Return query.ToArray
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try

            Else
                Dim query = From p In ctx.contactnames
                           Where p.clientID = valclient And p.officeID = valoffice And p.annull = False
                           Order By p.cognome
                           Select New ListItem(p.cognome & " " & p.nome, p.ID)
                Try
                    Return query.ToArray
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try

            End If

        End Function

        Public Function Get_offer(Optional ByVal mode As Integer = 1) As List(Of offer) 'mode=1 è edit
            Dim context As New AcomContext

            If mode = 2 Then 'mode=insert
                Try
                    Return context.offers.Where(Function(p) p.annull = False).OrderBy(Function(p) p.offer_code).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.offers.OrderBy(Function(p) p.offer_code).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        Public Function Get_order() As List(Of order)
            Dim context As New AcomContext
            Try
                Return context.orders.Where(Function(p) p.annull = False).OrderBy(Function(p) p.order_code).ToList
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try
        End Function

        Public Function Get_products(Optional ByVal mode As Integer = 1) As List(Of product) 'mode=1 è edit
            Dim context As New AcomContext
            If mode = 2 Then 'mode=insert
                Try
                    Return context.products.Where(Function(p) p.annull = False).OrderBy(Function(p) p.product_name).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.products.OrderBy(Function(p) p.product_name).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        Public Function Get_families(Optional ByVal mode As Integer = 1) As List(Of family) 'mode=1 è edit
            Dim context As New AcomContext
            If mode = 2 Then 'mode=insert
                Try
                    Return context.family.Where(Function(p) p.annull = False).OrderBy(Function(p) p.family_name).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.family.OrderBy(Function(p) p.family_name).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If

        End Function

        Public Function Get_resa(Optional ByVal mode As Integer = 1) As List(Of resa) 'mode=1 è edit
            Dim context As New AcomContext
            If mode = 2 Then 'mode=insert
                Try
                    Return context.rese.Where(Function(p) p.annull = False).OrderBy(Function(p) p.resa_desc).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.rese.OrderBy(Function(p) p.resa_desc).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        Public Function Get_garanzia(Optional ByVal mode As Integer = 1) As List(Of garanzia) 'mode=1 è edit
            Dim context As New AcomContext
            If mode = 2 Then 'mode=insert
                Try
                    Return context.garanzie.Where(Function(p) p.annull = False).OrderBy(Function(p) p.garanzia_desc).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            Else
                Try
                    Return context.garanzie.OrderBy(Function(p) p.garanzia_desc).ToList
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try
            End If
        End Function

        'per popolare la DDL comuni partendo dal valore del controllo provincia, attenzione a chiamare i controlli provinciaID e comuneID
        Public Function Get_comune_from_provincia(ByVal ctrl As Control)

            'trovo il controllo relativo alla provincia e al comune
            Dim DDLprov As DropDownList = ctrl.FindControl("provinciaID")
            Dim DDLcomuni As DropDownList = ctrl.FindControl("comuneID")
            'memorizzo il valore
            Dim valprov = DDLprov.SelectedValue
            If valprov = "" Then valprov = Nothing

            'ho provato ad utilizzare LINQ to Entities ma restituisce un'eccezione per il tipo listitem nella query
            Dim ctx As New AcomLinqContextDataContext

            'converto la query in una lista di oggetti inseribili nella DDLcomuni
            Dim query = From p In ctx.comunes
                        Where p.provinciaID = valprov And p.annull = False
                        Order By p.nome
                        Select New ListItem(p.nome, p.ID)

            'svuoto la DDLcomuni
            DDLcomuni.Items.Clear()

            'se nessuna provincia è selezionata la DDLcomuni resta vuota
            If valprov = Nothing Then
                DDLcomuni.SelectedValue = Nothing 'questo serve per non mandare in errore il binding in EditItemTemplate
            Else 'altrimenti aggiungo il valore "" a cui si accoderanno i valori della query
                DDLcomuni.Items.Add("")
            End If

            Try
                Return query.ToArray
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

        End Function

        'per la generazione di numero d'offerta di variante 0
        Public Function new_offer()

            Dim offerta As New offer
            Dim anno As Integer = Year(Now)
            Dim context As New AcomContext

            'il risultato della query sulla tabella vuota da un'eccezione InvalidOperationException che non riesco a gestire se non con un'eccezione generica
            Try
                offerta.offer_num = context.offers.Where(Function(p) Year(p.data) = anno).Max(Function(c) c.offer_num)
                If offerta.offer_num = 0 Then
                    offerta.offer_num = 1
                Else
                    offerta.offer_num = offerta.offer_num + 1
                End If

                Dim num As String = Format(offerta.offer_num, "00000")
                offerta.offer_code = anno & "-" & num & "-00"

            Catch ex As InvalidOperationException

                offerta.offer_num = 1
                Dim num As String = Format(offerta.offer_num, "00000")
                offerta.offer_code = anno & "-" & num & "-00"

            Catch ex1 As Exception
                Throw New ArgumentException(ex1.Message, ex1)
            End Try

            Return offerta

        End Function

        'per la generazione di numero d'offerta di variante maggiore di zero
        Public Function new_offer(ByVal codeoffer As String, ByVal numoffer As Integer)
            Dim offerta As New offer
            Dim variante = offerta.offer_vers
            Dim anno As Integer = CType(Left(codeoffer, 4), Integer)
            Dim context As New AcomContext

            'inizializzo numero d'offerta con numoffer
            offerta.offer_num = numoffer

            Try
                offerta.offer_vers = context.offers.Where(Function(p) Year(p.data) = anno And p.offer_num = numoffer).Max(Function(c) c.offer_vers)
                If offerta.offer_vers = 0 Then
                    offerta.offer_vers = 1
                Else
                    offerta.offer_vers = offerta.offer_vers + 1
                End If

                Dim strvariante As String = Format(offerta.offer_vers, "00")
                Dim strofferta As String = Format(numoffer, "00000")
                offerta.offer_code = anno & "-" & strofferta & "-" & strvariante

            Catch ex As Exception
                If variante = 0 Then
                    variante = 1
                Else
                    Return Nothing
                End If

                Dim strvariante As String = Format(offerta.offer_vers, "00")
                Dim strofferta As String = Format(numoffer, "00000")
                offerta.offer_code = anno & "-" & strofferta & "-" & strvariante

            End Try

            Return offerta

        End Function

        'per calcolare il valore della nuova riga di offerta
        Public Function new_offer_row(ByVal numoffer As Integer) As Integer
            Dim context As New AcomContext
            Dim offerrow As New offer_row

            Try
                offerrow.rigaID = context.offer_rows.Where(Function(p) p.offerID = numoffer).Max(Function(c) c.rigaID)
                offerrow.rigaID = offerrow.rigaID + 1
            Catch ex As InvalidOperationException
                offerrow.rigaID = 1
            Catch ex1 As Exception
                Throw New ArgumentException(ex1.Message, ex1)
            End Try

            Return offerrow.rigaID

        End Function

        Public Function new_order()

            Dim ordine As New order
            Dim anno As Integer = Year(Now)
            Dim context As New AcomContext

            Try
                'quando la query non trova ordini con l'anno indicato genera una invalidOperationException che mi fa partire la numerazione degli ordini da 1
                ordine.order_num = context.orders.Where(Function(p) Year(p.data) = anno).Max(Function(c) c.order_num)
                If ordine.order_num = 0 Then
                    ordine.order_num = 1
                Else
                    ordine.order_num = ordine.order_num + 1
                End If

                Dim num As String = Format(ordine.order_num, "0000")
                ordine.order_code = anno & "-" & num

            Catch ex As InvalidOperationException

                ordine.order_num = 1
                Dim num As String = Format(ordine.order_num, "0000")
                ordine.order_code = anno & "-" & num

            Catch ex1 As Exception
                Throw New ArgumentException(ex1.Message, ex1)
            End Try

            Return ordine

        End Function

        Public Function new_order_row(ByVal numorder As Integer) As Integer

            Dim orderrow As New order_row
            Dim context As New AcomContext

            Try
                orderrow.rigaID = context.order_rows.Where(Function(p) p.orderID = numorder).Max(Function(c) c.rigaID)
                orderrow.rigaID = orderrow.rigaID + 1
            Catch ex As InvalidOperationException
                orderrow.rigaID = 1
            Catch ex1 As Exception
                Throw New ArgumentException(ex1.Message, ex1)
            End Try

            Return orderrow.rigaID

        End Function

        'per trovare il prezzo dell'articolo in base all'ID
        Public Function Get_price_from_article(ByVal articleID As Integer)

            Dim ctx As New AcomLinqContextDataContext
            Dim price = ctx.ViewArticle.Where(Function(p) p.ID = articleID).Select(Function(c) c.prezzo)

            'l'attributo single è FONDAMENTALE per rendere leggibile il valore alla textbox di destinazione
            Try
                Return price.FirstOrDefault
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try


        End Function

        'per trovare la data di decorrenza di un articolo a listino
        Public Function Get_date_from_article(ByVal articleID As Integer) As Date

            Dim ctx As New AcomLinqContextDataContext

            Try
                Return ctx.ViewArticle.Where(Function(p) p.ID = articleID).Select(Function(c) c.data_decorrenza).FirstOrDefault
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

        End Function

        'per popolare la DDL articoli dal listino più recente
        Public Function Get_article_from_pricelist() As List(Of ViewArticle)
            Dim ctx As New AcomLinqContextDataContext

            Try
                Return ctx.ViewArticle.OrderBy(Function(p) p.article_code).ToList
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try


        End Function

        'per popolare la DDL rif_offer con i valori di codice offerta in base alla selezione di cliente e filiale
        Public Function Get_offer_from_client(ByVal ctrl As Control)

            Dim DDLclient As DropDownList = ctrl.FindControl("clienteID")
            Dim DDLoffice As DropDownList = ctrl.FindControl("officeID")
            Dim DDLoffer As DropDownList = ctrl.FindControl("rif_offerta")
            Dim datadiff As Date = Date.Now.AddMonths(-12) 'le offerte visualizzate sono a partire da 12 mesi prima della data odierna, per non caricare troppi dati
            Dim ctx As New AcomLinqContextDataContext

            DDLoffer.Items.Clear()

            Dim valclient = DDLclient.SelectedValue
            If valclient = "" Then
                valclient = Nothing
                DDLoffer.SelectedValue = Nothing
            Else
                DDLoffer.Items.Add("")
            End If

            Dim valoffice = DDLoffice.SelectedValue
            If valoffice = "" Then
                valoffice = Nothing
                'attenzione alla clausola where, il parametro officeID usa HasValue per verificare se è null il campo, Nothing o IsNothing o IsDbNull non funzionano
                Dim query = From p In ctx.ViewOffer
                            Where p.clientID = valclient And Not p.officeID.HasValue And p.annull = False And p.data > datadiff
                            Order By p.data Descending
                            Group p By p.offer_code Into Group
                            Select New ListItem(offer_code)
                Try
                    Return query.ToArray
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try

            Else
                Dim query = From p In ctx.ViewOffer
                           Where p.clientID = valclient And p.officeID = valoffice And p.annull = False And p.data > datadiff
                           Order By p.data Descending
                           Group p By p.offer_code Into Group
                           Select New ListItem(offer_code)
                Try
                    Return query.ToArray
                Catch ex As Exception
                    Throw New ArgumentException(ex.Message, ex)
                End Try

            End If

        End Function

        'per popolare una dropdownlist con i valori di una classe enum con value e text
        Public NotInheritable Class Enumeration
            Private Sub New()
            End Sub
            Public Shared Function GetAll(Of TEnum As Structure)() As IDictionary(Of Integer, String)
                Dim enumerationType = GetType(TEnum)

                If Not enumerationType.IsEnum Then
                    Throw New ArgumentException("Enumeration type is expected.")
                End If

                Dim dictionary = New Dictionary(Of Integer, String)()

                For Each value As Integer In [Enum].GetValues(enumerationType)
                    Dim name = [Enum].GetName(enumerationType, value)
                    dictionary.Add(value, name)
                Next

                Return dictionary
            End Function
        End Class

        Public Function ConvertDate(datatxt As String) As Date

            Dim dataval As Date
            Date.TryParseExact(datatxt, "dd/MM/yyyy", CultureInfo.CurrentCulture, DateTimeStyles.AssumeLocal, dataval)

            Return dataval

        End Function

        Public Function GetDataForOfferReport(id As Integer) As List(Of ViewReportOffer)

            Dim ctx As New AcomLinqContextDataContext
            Dim query = ctx.ViewReportOffer.Where(Function(p) p.ID = id)

            Try
                query.ToList()
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

            Return query.ToList
        End Function

        Public Function GetDataForClientReport(id As Integer) As List(Of ViewClientDettaglio)

            Dim ctx As New AcomLinqContextDataContext
            Dim query = ctx.ViewClientDettaglio.Where(Function(p) p.ID = id)

            Try
                query.ToList()
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

            Return query.ToList
        End Function

        Public Function GeneraPdfOfferta(ByVal id As Integer, dett_sconti As Boolean) As Byte()

            Dim filename As String
            Dim ctx As New AcomContext
            Try
                filename = ctx.offers.Where(Function(p) p.ID = id).Select(Function(c) c.offer_code).FirstOrDefault
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
            End Try

            Dim warn As Warning() = Nothing
            Dim streamids As String() = Nothing
            Dim mimetype As String = String.Empty
            Dim encoding As String = String.Empty
            Dim extension As String = String.Empty

            Dim viewer As New ReportViewer
            Dim datasourcereport As New ReportDataSource

            viewer.ProcessingMode = ProcessingMode.Local
            If dett_sconti = False Then
                datasourcereport.Name = ("OfferDataSet")
                datasourcereport.Value = BLL.GetDataForOfferReport(id)
                viewer.LocalReport.ReportPath = "OfferReport2.rdlc" 'HttpContext.Current.Server.MapPath("OfferReport2.rdlc")
            Else
                datasourcereport.Name = ("OfferReportSconti")
                datasourcereport.Value = BLL.GetDataForOfferReport(id)
                viewer.LocalReport.ReportPath = "OfferReportSconti.rdlc"
            End If
            viewer.LocalReport.DataSources.Add(datasourcereport)

            Dim bytes As Byte() = Nothing
            Try
                'in PDF
                bytes = viewer.LocalReport.Render("PDF", Nothing, mimetype, encoding, extension, streamids, warn)
                'in WORD
                'bytes = viewer.LocalReport.Render("WORD", Nothing, mimetype, encoding, extension, streamids, warn)
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
                Return Nothing
            End Try

            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.ClearContent()
            HttpContext.Current.Response.ClearHeaders()

            'in WORD
            'HttpContext.Current.Response.ContentType = "application/ms-word"
            'HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" & filename & ".doc")

            'in PDF
            HttpContext.Current.Response.ContentType = "application/pdf"
            'per aprire il pdf nel browser senza salvarlo
            'HttpContext.Current.Response.AddHeader("content-lenght", bytes.Length.ToString)
            'per aprire il file in un nuovo pannello e fare il download del pdf nella cartella download
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" & filename & ".pdf")

            HttpContext.Current.Response.BinaryWrite(bytes)

            ''PER APRIRE IL FILE CREATO NELL'APPLICAZIONE PREDEFINITA
            'Dim filename As String = Path.GetTempPath & "Offerta.doc"
            'Using fs As FileStream = File.Create(filename)
            '    fs.Write(bytes, 0, bytes.Length)
            '    fs.Close()
            'End Using
            'Process.Start(filename)

            Return bytes

        End Function

        Public Function GeneraPdfCliente(ByVal id As Integer, ByVal filename As String, ByVal dataset As String, ByVal report_name As String)

            Dim warn As Warning() = Nothing
            Dim streamids As String() = Nothing
            Dim mimetype As String = String.Empty
            Dim encoding As String = String.Empty
            Dim extension As String = String.Empty

            Dim viewer As New ReportViewer
            Dim datasourcereport As New ReportDataSource

            viewer.ProcessingMode = ProcessingMode.Local
            datasourcereport.Name = (dataset)
            datasourcereport.Value = BLL.GetDataForClientReport(id)
            'viewer.LocalReport.ReportPath = HttpContext.Current.Server.MapPath(report_name & ".rdlc")
            viewer.LocalReport.ReportPath = report_name & ".rdlc" '
            viewer.LocalReport.DataSources.Add(datasourcereport)

            Dim bytes As Byte() = Nothing
            Try
                'in PDF
                bytes = viewer.LocalReport.Render("PDF", Nothing, mimetype, encoding, extension, streamids, warn)
                'in WORD 
                'bytes = viewer.LocalReport.Render("WORD", Nothing, mimetype, encoding, extension, streamids, warn)
            Catch ex As Exception
                Throw New ArgumentException(ex.Message, ex)
                Return Nothing
            End Try

            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.ClearContent()
            HttpContext.Current.Response.ClearHeaders()

            'in WORD
            'HttpContext.Current.Response.ContentType = "application/ms-word"
            'HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" & filename & ".doc")

            'in PDF
            HttpContext.Current.Response.ContentType = "application/pdf"
            'per aprire il pdf nel browser senza salvarlo
            'HttpContext.Current.Response.AddHeader("content-lenght", bytes.Length.ToString)
            'per aprire il file in un nuovo pannello e per fare il download del pdf
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" & filename & ".pdf")

            HttpContext.Current.Response.BinaryWrite(bytes)

            Return bytes

        End Function

        Public Function GenRandom() As String
            Dim s As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            Dim r As New Random
            Dim sb As New StringBuilder
            For i As Integer = 1 To 6
                Dim idx As Integer = r.Next(0, 35)
                sb.Append(s.Substring(idx, 1))
            Next

            Return sb.ToString

        End Function

        'la funzione è utilizzabile se sul server è installabile office
        Public Function ImportExcelOledb(fileupload As System.Web.UI.WebControls.FileUpload, ByVal filename As String, ByVal sheet As String, ByVal User As String) As DataTable

            'copio il file in una cartella temporanea
            Dim filepath As String = Path.GetTempPath()
            fileupload.SaveAs(filepath & filename)
            Dim tempfilename = filepath & filename

            Dim dt As New DataTable
            'apro la connessione con il file excel e imposto il comando di select
            Dim connExcel As New OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & tempfilename & ";Extended Properties=""Excel 12.0;HDR=Yes;IMEX=2""")
            Try
                connExcel.Open()
            Catch ex As Exception
                Throw New Exception("Connessione con il file excel non riuscita")
                Return dt
            End Try

            Dim cmdExcel As New OleDbCommand("Select * from [" & sheet & "$]", connExcel)

            'aggiungo le colonne per identificare data e autore creazione
            dt.Columns.Add("created_by").DefaultValue = User
            dt.Columns.Add("created_date").DefaultValue = Today

            'riempio il datatable
            Dim da As New OleDbDataAdapter(cmdExcel)
            Try
                da.Fill(dt)
            Catch ex As Exception
                Throw New Exception("Copia dei dati da file excel non riuscita")
                Return dt
            End Try


            'cancello il file temporaneo e chiudo la connessione con excel
            Try
                File.Delete(tempfilename)
            Catch ex As Exception
                Throw New Exception("Il file temporaneo non è stato cancellato")
            End Try

            connExcel.Close()

            Return dt

            'si può fare anche con un reader, restituendo un reader anzichè una datatable, ma non posso inserire user e data creazione
            'Dim readerExcel As OleDbDataReader
            'readerExcel = cmdExcel.ExecuteReader

        End Function

        Public Function ImportExcelEPPlus(package As ExcelPackage, sheet As String, data_decorrenza As Date, user As String) As DataTable

            Dim dt As New DataTable
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets(sheet)

            If worksheet Is Nothing Then
                Throw New Exception("Il foglio per l'importazione non è stato individuato nel file")
                Return Nothing
            End If
            
            'aggiungo le colonne al datatable così come sono nel foglio excel
            Dim firstrowcells As ExcelRangeBase
            For Each firstrowcells In worksheet.Cells(1, 1, 1, worksheet.Dimension.End.Column)
                dt.Columns.Add(firstrowcells.Text)
            Next

            'aggiungo le colonne per identificare data e autore dell'importazione
            dt.Columns.Add("Data decorrenza").DefaultValue = data_decorrenza
            dt.Columns.Add("created_by").DefaultValue = user
            dt.Columns.Add("created_date").DefaultValue = Today
            dt.Columns.Add("annull", Type.GetType("System.Boolean")).DefaultValue = 0

            'aggiungo i dati al datatable ciclando ogni riga del foglio excel
            Dim rowNumber As Integer
            For rowNumber = 2 To worksheet.Dimension.End.Row

                Dim row = worksheet.Cells(rowNumber, 1, rowNumber, worksheet.Dimension.End.Column)
                Dim newrow = dt.NewRow()
                For Each cell In row
                    newrow(cell.Start.Column - 1) = cell.Text
                Next

                Try
                    dt.Rows.Add(newrow)
                Catch ex As Exception
                    Throw New Exception(ex.Message)
                    Return Nothing
                End Try

            Next

            Return dt

        End Function
    End Module
End Namespace
