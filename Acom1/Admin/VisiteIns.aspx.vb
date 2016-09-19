Imports Acom1.BLL
Imports Acom1.DAL
Imports Acom1.Models
Imports System.Web.ModelBinding
Imports System.Data.Entity
Imports System.Globalization

Public Class VisiteIns
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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

    Protected Sub motivo_tipo_DataBinding(sender As Object, e As EventArgs)
        Dim DDLmotivo As DropDownList = DetailsViewVisit.FindControl("motivo_tipo")
        DDLmotivo.Items.Clear()
        DDLmotivo.DataSource = BLL.Enumeration.GetAll(Of motivo)()
        DDLmotivo.DataValueField = "Key"
        DDLmotivo.DataTextField = "Value"
        DDLmotivo.Items.Add("")

    End Sub
End Class