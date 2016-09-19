Imports Acom1.BLL
Imports Acom1.DAL
Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports System.Data.Entity.Infrastructure

Public Class OrdiniIns
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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

    Protected Sub ListViewOrderRow_DataBound(sender As Object, e As EventArgs)

        Dim item As ListViewItem
        Dim prod As DropDownList
        Dim unactive As Label
        Dim index As Integer
        Dim prod_sel As Integer
        Dim query As New product
        Dim ctx As New AcomContext

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

    Public Function Get_product() As List(Of product)

        Try
            Return BLL.Get_products
        Catch ex As Exception
            errormsg.Text = ex.Message
            errormsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub productID_SelectedIndexChanged(sender As Object, e As EventArgs)

        'identifico il controllo productID
        Dim prod As DropDownList = sender
        'identifico l'ID del prodotto selezionato nella dropdown
        Dim prod_sel As Integer = prod.SelectedValue
        Dim query As New product
        Dim ctx As New AcomContext
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


End Class