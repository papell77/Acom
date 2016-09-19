Imports System.Web.ModelBinding
Imports Acom1.DAL

Public Class FilialiIns1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub

    Public Function DetailsViewOffice_GetItem(<QueryString("ID_of")> ByVal id As Nullable(Of Integer)) As IQueryable(Of ViewOfficeDettaglio)

        Dim context As New AcomLinqContextDataContext
        Dim query As IQueryable(Of ViewOfficeDettaglio)

        Try
            query = context.ViewOfficeDettaglio.Where(Function(p) p.ID = id)
            Return query
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
            Return Nothing
        End Try

    End Function

    Protected Sub cmd_attiva_Click(sender As Object, e As EventArgs)
        Dim ctx As New AcomContext
        Dim id As Integer = Request.QueryString("ID_of")
        Dim idClient As Integer = Request.QueryString("ID_cl")
        Dim item As Acom1.Models.office = Nothing
        item = ctx.offices.Where(Function(p) p.ID = id).FirstOrDefault

        item.annull = False
        Try
            ctx.SaveChanges()
            Response.Redirect("~/Admin/FilialiIns?ID_of=" & id & "&" & "ID_cl=" & idClient)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        End Try
    End Sub

    Protected Sub cmd_disattiva_Click(sender As Object, e As EventArgs)
        Dim ctx As New AcomContext
        Dim id As Integer = Request.QueryString("ID_of")
        Dim idClient As Integer = Request.QueryString("ID_cl")
        Dim item As Acom1.Models.office = Nothing
        item = ctx.offices.Where(Function(p) p.ID = id).FirstOrDefault

        item.annull = True
        Try
            ctx.SaveChanges()
            Response.Redirect("~/Admin/FilialiIns?ID_of=" & id & "&" & "ID_cl=" & idClient)
        Catch ex As Exception
            errmsg.Text = ex.Message
            errmsg.Visible = True
        End Try
    End Sub
End Class