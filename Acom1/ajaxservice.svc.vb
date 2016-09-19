Imports System.ServiceModel
Imports System.ServiceModel.Activation
Imports System.ServiceModel.Web
Imports Acom1.DAL
Imports Acom1.Models

<ServiceContract(Namespace:="")>
<AspNetCompatibilityRequirements(RequirementsMode:=AspNetCompatibilityRequirementsMode.Allowed)>
Public Class ajaxservice

    ' Per utilizzare HTTP GET, aggiungere l'attributo <WebGet()>. (ResponseFormat predefinito è WebMessageFormat.Json)
    ' Per creare un'operazione che restituisca XML,
    '     aggiungere <WebGet(ResponseFormat:=WebMessageFormat.Xml)>,
    '     e includere la riga seguente nel corpo dell'operazione:
    '         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml"
    <OperationContract()>
    Public Sub DoWork()
        ' Aggiungere l'implementazione dell'operazione qui
    End Sub

    ' Aggiungere altre operazioni qui e contrassegnarle con <OperationContract()>
    Public Class AutoCompleteObject
        Public Property ID As Integer
        Public Property label As String
    End Class

    '<WebGet> _ sostituita da WebInvoke
    <OperationContract> _
    <WebInvoke(ResponseFormat:=WebMessageFormat.Json, RequestFormat:=WebMessageFormat.Json)> _
    Public Function AutoCompleteArticle(term As AutoCompleteObject) As List(Of String)
        Dim context As New AcomLinqContextDataContext
        'Dim query As List(Of String)
        'query = context.ViewArticle.Where(Function(p) p.article_code.StartsWith(term.label)).Take(term.ID).ToList

        'Return query.ToList

        Dim results As New List(Of String)
        results.Add("Milano")
        results.Add("Roma")
        results.Add("Rovigo")
        results.Add("Rodi Garganico")
        results.Add("Torino")
        results.Add("Venezia")



        Return results.Where(Function(element As String) element.StartsWith(term.label)).Take(term.ID).ToList

    End Function

    <OperationContract> _
    <WebGet> _
    Public Function AutoCompleteDesc(term As String) As String()

        Dim article As String() = Nothing

        article(0) = "pippo"
        article(1) = "pippone"
        article(2) = "pippero"
        article(3) = "paperino"
        article(4) = "Pluto"

        Return article.ToArray

    End Function

End Class
