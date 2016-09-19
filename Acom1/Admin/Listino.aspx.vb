Imports Acom1.BLL
Imports Acom1.Models
Imports Acom1.DAL
Imports System.Web.ModelBinding
Imports Microsoft.AspNet.Identity

Public Class Listino
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub

    Public Function Get_products() As List(Of product)
        Return BLL.Get_products
    End Function

    Public Function Get_families() As List(Of family)
        Return BLL.Get_families
    End Function

    Protected Sub btncerca_Click(sender As Object, e As EventArgs)

        GridViewPrice.DataBind()

    End Sub

    Protected Sub calext_datadecorrenza_Load(sender As Object, e As EventArgs)

        If Not Page.IsPostBack Then
            Dim anno As Integer = Year(Now())
            Dim giorno As Date = DateValue("01/01/" & anno)
            data.Text = giorno
        End If
        
    End Sub


    Public Function GridViewPrice_GetData(<Control("textarticolo")> articolo As String, _
                                            <Control("textarticolo_desc")> articolo_desc As String, _
                                            <Control("DDLprod")> prodotto As Nullable(Of Integer), _
                                            <Control("DDLfam")> famiglia As Nullable(Of Integer), _
                                            <Control("data")> datadecor As String) As IQueryable(Of ViewPricelist)



        'se nessuno dei campi di ricerca è compilato non restituisco niente
        If String.IsNullOrEmpty(articolo) And _
            String.IsNullOrEmpty(articolo_desc) And _
            String.IsNullOrEmpty(datadecor) And _
            Not prodotto.HasValue And _
            Not famiglia.HasValue Then

            Return Nothing
            Exit Function
        End If

        Dim context As New AcomLinqContextDataContext
        Dim query = From p In context.ViewPricelist Select p

        'eseguo la query solo se almeno uno dei campi di ricerca è compilato: il campo data è precompilato con il 01/01 dell'anno in corso
        If Not String.IsNullOrEmpty(articolo) Then
            query = query.Where(Function(p) p.article_code.Contains(articolo))
        End If

        If Not String.IsNullOrEmpty(articolo_desc) Then
            query = query.Where(Function(p) p.article_desc.Contains(articolo_desc))
        End If

        If Not String.IsNullOrEmpty(datadecor) Then
            query = query.Where(Function(p) p.data_decorrenza >= datadecor)
        End If

        If prodotto.HasValue Then
            query = query.Where(Function(p) p.productID = prodotto)
        End If

        If famiglia.HasValue Then
            query = query.Where(Function(p) p.familyID = famiglia)
        End If

        Return query

    End Function

    ' Il nome del parametro id deve corrispondere al valore DataKeyNames impostato nel controllo
    Public Sub GridViewPrice_UpdateItem(ByVal article_code As String, ByVal data_decorrenza As String)

        Dim item As New Acom1.Models.pricelist
        Dim context As New AcomContext

        
        item = context.pricelists.Single(Function(p) p.article_code = article_code And p.data_decorrenza = data_decorrenza)
        item.updated_by = User.Identity.Name
        item.updated_date = Today

        If item Is Nothing Then
            ModelState.AddModelError("", String.Format("Articolo con codice {0} e data decorrenza {1} non trovato", article_code, data_decorrenza))
            Return
        End If

        TryUpdateModel(item)
        If ModelState.IsValid Then
            context.SaveChanges()
        End If

    End Sub

End Class