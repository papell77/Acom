
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Web.Script.Services
Imports System.ComponentModel

' Per consentire la chiamata di questo servizio Web dallo script utilizzando ASP.NET AJAX, rimuovere il commento dalla riga seguente.
<System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebService1
    Inherits System.Web.Services.WebService

    Public Class AutoCompleteObject
        Public Property ID As Integer
        Public Property label As String
    End Class

    '<ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    <WebMethod()> _
    Public Function AutoCompleteArticle(term As String, count As Integer) As List(Of String)
        Dim context As New AcomLinqContextDataContext
        'Dim query As List(Of AutoCompleteObject)
        Dim query = From p In context.ViewArticle
                        Where p.article_desc.Contains(term)
                       Select p.article_desc

        Return query.ToList
    End Function

    '<ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    <WebMethod()> _
    Public Function AutoCompleteDesc(term As String) As List(Of String)

        Dim article As New List(Of String)

        article.Add("pippo")
        article.Add("pippone")
        article.Add("pippero")
        article.Add("pluto")

        Return article.Where(Function(p) p.Contains(term)).ToList

    End Function

End Class