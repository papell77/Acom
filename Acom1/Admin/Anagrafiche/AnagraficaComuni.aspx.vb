Imports System
Imports System.Data.Entity
Imports System.Linq
Imports System.Data.SqlClient
Imports Acom1.DAL
Imports Acom1.Models
Imports Acom1.BLL

Public Class AnagraficaComuni
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ButtonInsComuni_Click(sender As Object, e As EventArgs)

        Dim context As New AcomContext
        Dim com = New comune
        Dim comtxt As String = TextComuneIns.Text
        Dim cap As String = txtCAP.Text

        If String.IsNullOrEmpty(comtxt) Then
            LabelComIns.Text = "Inserire comune"
            LabelComIns.Visible = True
            Exit Sub
        Else
            Dim query As New List(Of comune)
            query = context.comuni.Where(Function(p) p.nome = comtxt And p.provinciaID = DropDownProv.SelectedValue).ToList

            If Not query.Count = 0 Then
                LabelComIns.Text = "Il comune inserito esiste già"
                LabelComIns.Visible = True
                Exit Sub
            Else
                query = Nothing
            End If
        End If

        If String.IsNullOrEmpty(cap) Then
            LabelComIns.Text = "Inserire cap"
            LabelComIns.Visible = True
            Exit Sub
        Else
            Dim query As New List(Of comune)
            query = context.comuni.Where(Function(p) p.CAP = cap And p.provinciaID = DropDownProv.SelectedValue).ToList

            If Not query.Count = 0 Then
                LabelComIns.Text = "Il cap inserito è già utilizzato"
                LabelComIns.Visible = True
                Exit Sub
            Else
                query = Nothing
            End If
        End If

        'se la stringa del nuovo comune da inserire non è nulla controllo se è già inserita, se no la inserisco
        com.nome = comtxt
        com.CAP = cap
        com.provinciaID = DropDownProv.SelectedValue

        context.comuni.Add(com)

        Try
            context.SaveChanges()
            TextComuneIns.Text = ""
            txtCAP.Text = ""
            ListView1.DataBind()
        Catch ex As Exception
            LabelComIns.Text = ex.Message
            LabelComIns.Visible = True
        End Try

    End Sub

    Public Function Get_provincia()
        Return BLL.Get_provincia
    End Function

    Protected Sub TextComuneIns_TextChanged(sender As Object, e As EventArgs)

        Dim comune As TextBox = sender
        Dim ctx As New AcomContext

        If Not String.IsNullOrEmpty(comune.Text) Then
            Dim query As New List(Of comune)
            query = ctx.comuni.Where(Function(p) p.nome = comune.Text And p.provinciaID = DropDownProv.SelectedValue).ToList

            If Not query.Count = 0 Then
                LabelComIns.Text = "Il comune inserito esiste già"
                LabelComIns.Visible = True
                Exit Sub
            Else
                query = Nothing
            End If


        End If


    End Sub

    Protected Sub txtCAP_TextChanged(sender As Object, e As EventArgs)

        Dim cap As TextBox = sender
        Dim ctx As New AcomContext

        If Not String.IsNullOrEmpty(cap.Text) Then
            Dim query As New List(Of comune)
            query = ctx.comuni.Where(Function(p) p.nome = cap.Text And p.provinciaID = DropDownProv.SelectedValue).ToList

            If Not query.Count = 0 Then
                LabelComIns.Text = "Il cap inserito esiste già"
                LabelComIns.Visible = True
                Exit Sub
            Else
                query = Nothing
            End If


        End If


    End Sub
End Class