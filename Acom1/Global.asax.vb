Imports System.Web.Optimization
Imports Acom1.Models
Imports Acom1.DAL
Imports System.Data.Entity

Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)
        ' Generato all'avvio dell'applicazione
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)

       
    End Sub

End Class