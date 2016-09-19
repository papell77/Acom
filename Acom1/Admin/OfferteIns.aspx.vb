Imports Acom1.BLL
Imports Acom1.DAL
Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports System.Globalization
Imports System.Data.Entity.Infrastructure

Public Class OfferteIns
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Sub DetailsOfferIns_InsertItem()

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
        Dim bytes As Byte()
        Try
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
        Dim bytes As Byte()

        Try
            bytes = BLL.GeneraPdfOfferta(id, True)
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
End Class