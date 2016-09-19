Public Class MyWebFormsFriendlyUrlResolver
    Inherits Microsoft.AspNet.FriendlyUrls.Resolvers.WebFormsFriendlyUrlResolver

    Protected Overrides Function TrySetMobileMasterPage(httpContext As HttpContextBase, page As Page, mobileSuffix As String) As Boolean
        If mobileSuffix = "Mobile" Then
            Return False
        Else
            Return MyBase.TrySetMobileMasterPage(httpContext, page, mobileSuffix)
        End If
    End Function

End Class
