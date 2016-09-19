Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Globalization
Imports System.Collections.Generic
Imports Acom1.SiteMaster
Imports Acom1.DAL

Public Class Home
    Inherits System.Web.UI.Page

    Private ctx As AcomLinqContextDataContext

    Public Sub New()
        ctx = New AcomLinqContextDataContext
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Get_incomplete_order()

    End Sub

   
    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    Public Function GridVisite_GetData() As IQueryable(Of ViewAdminAgent)

        Dim query As IQueryable(Of ViewAdminAgent)
        Try
            query = ctx.ViewAdminAgent
            Return query
        Catch ex As Exception
            lbl_errmsg_gridvisite.Text = ex.Message
            errmsg_gridvisite.Visible = True
            Return Nothing
        End Try

    End Function

    Public Function Get_incomplete_order() As Integer

        Dim query As Integer
        Try
            query = ctx.ViewOrderNoProduct.Count()
        Catch ex As Exception
            errmsg_ordini.Text = ex.Message
            errmsg_ordini.Visible = True
            Return Nothing
        End Try

        If query = 0 Then
            lbl_ordini.Text = "Non sono presenti ordini in sospeso"
            lbl_ordini.Visible = True
        ElseIf query > 0 Then
            lbl_ordini.Text = "Sono presenti " & query & " ordini senza prodotti associati"
            lbl_ordini.Visible = True
        Else
            errmsg_ordini.Text = "Attenzione: errore in fase di conteggio ordini"
            errmsg_ordini.Visible = True
        End If

        Return query

    End Function
    ' Il tipo restituito può essere modificato in IEnumerable. Tuttavia, per supportare
    'il paging e l'ordinamento di ' è necessario aggiungere i parametri seguenti:
    '     ByVal maximumRows as Integer
    '     ByVal startRowIndex as Integer
    '     ByRef totalRowCount as Integer
    '     ByVal sortByExpression as String
    'Public Function GridPreventivi_GetData(<Control("DropDownAgent")> agent As Nullable(Of Integer), <Control("DropDownGGPreventivi")> days As Integer) As IQueryable
    '    Dim dataodierna As Date = Today 'Date.Now
    '    Dim datalimite As Date
    '    datalimite = DateAdd(DateInterval.Day, days, dataodierna)

    '    Dim ctx As New AcomLinqContextDataContext
    '    Dim offer = ctx.ViewOfferInsert

    '    'seleziono le offerte scadute e con scadenza nel periodo fino a datalimite, non annullate, per l'agente selezionato e con stato in attesa
    '    Dim query = From p In offer Select p
    '                Where p.data_valid <= datalimite And p.annull = False And p.agentID = agent And p.stato = "In attesa"
    '                Order By p.data_valid Ascending
    '    Return query
    'End Function

    'Protected Sub GridPreventivi_DataBound(sender As Object, e As EventArgs)

    '    'per ogni riga del gridview, cerco il campo data validità e lo evidenzio in rosso se è passata
    '    Dim row As GridViewRow

    '    For Each row In GridPreventivi.Rows

    '        Dim dataval As Label = row.FindControl("dataval")

    '        If Not String.IsNullOrEmpty(dataval.Text) Then
    '            If dataval.Text < Today Then
    '                dataval.ForeColor = Drawing.Color.Red
    '            ElseIf dataval.Text = Today Then
    '                dataval.ForeColor = Drawing.Color.Blue
    '            End If
    '        End If

    '    Next

    'End Sub

    'Protected Sub GridVisite_DataBound(sender As Object, e As EventArgs)
    '    'per ogni riga del gridview, cerco il campo data validità e lo evidenzio in rosso se è passata
    '    Dim row As GridViewRow

    '    For Each row In GridVisite.Rows

    '        Dim dataval As Label = row.FindControl("data")

    '        If Not String.IsNullOrEmpty(dataval.Text) Then
    '            If dataval.Text < Today Then
    '                dataval.ForeColor = Drawing.Color.Red
    '            ElseIf dataval.Text = Today Then
    '                dataval.ForeColor = Drawing.Color.Blue
    '            End If
    '        End If

    '    Next


    'End Sub

End Class