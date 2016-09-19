Imports System.Web.Routing
Imports Microsoft.AspNet.FriendlyUrls
Imports Acom1.Models

Public Module RouteConfig
    Sub RegisterRoutes(ByVal routes As RouteCollection)
        Dim settings As FriendlyUrlSettings = New FriendlyUrlSettings()
        settings.AutoRedirectMode = RedirectMode.Permanent
        routes.EnableFriendlyUrls(settings, New MyWebFormsFriendlyUrlResolver)
    End Sub
End Module
