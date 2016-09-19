Imports System
Imports System.Data.Entity
Imports System.Data.Entity.Database
Imports System.Linq
Imports Acom1.Models
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Owin


Namespace DAL

    Public Class AcomContext
        Inherits DbContext

        Public Sub New()
            'MyBase.New("name=AcomContext")
            MyBase.New("name=AcomdbConnectionString")
            SetInitializer(Of AcomContext)(Nothing)

        End Sub

        Public Property clients As DbSet(Of client)
        Public Property contacts As DbSet(Of contactname)
        Public Property offers As DbSet(Of offer)
        Public Property offer_rows As DbSet(Of offer_row)
        Public Property offices As DbSet(Of office)
        Public Property orders As DbSet(Of order)
        Public Property order_rows As DbSet(Of order_row)
        Public Property pricelists As DbSet(Of pricelist)
        Public Property visits As DbSet(Of visit)
        Public Property discounts As DbSet(Of discount_list)
        Public Property comuni As DbSet(Of comune)
        Public Property provincie As DbSet(Of provincia)
        Public Property agents As DbSet(Of agent)
        Public Property canals As DbSet(Of canal)
        Public Property payments As DbSet(Of payment)
        Public Property transports As DbSet(Of transport)
        Public Property products As DbSet(Of product)
        Public Property family As DbSet(Of family)
        Public Property rese As DbSet(Of resa)
        Public Property garanzie As DbSet(Of garanzia)

        'usato per spcificare le configurazioni in FluentApi
        Protected Overrides Sub OnModelCreating(ByVal modelBuilder As DbModelBuilder)

            modelBuilder.Configurations.Add(New clientconfig)
            modelBuilder.Configurations.Add(New contactnameconfig)
            modelBuilder.Configurations.Add(New offerconfig)
            modelBuilder.Configurations.Add(New offer_rowconfig)
            modelBuilder.Configurations.Add(New officeconfig)
            modelBuilder.Configurations.Add(New orderconfig)
            modelBuilder.Configurations.Add(New order_rowconfig)
            modelBuilder.Configurations.Add(New pricelistconfig)
            modelBuilder.Configurations.Add(New visitconfig)
            modelBuilder.Configurations.Add(New comuneconfig)
            modelBuilder.Configurations.Add(New provinciaconfig)
            modelBuilder.Configurations.Add(New agentconfig)
            modelBuilder.Configurations.Add(New canalconfig)
            modelBuilder.Configurations.Add(New productconfig)
            modelBuilder.Configurations.Add(New familyconfig)
            modelBuilder.Configurations.Add(New paymentconfig)
            modelBuilder.Configurations.Add(New transportconfig)
            modelBuilder.Configurations.Add(New resaconfig)
            modelBuilder.Configurations.Add(New garanziaconfig)
            'modelBuilder.Entity(Of client).MapToStoredProcedures()

            
            
            'questa convenzione ha a che fare con la conversione del tipo date di .net, vedi classe Datetime2Convention
            modelBuilder.Conventions.Add(New Datetime2Convention)

            'per escludere la classe article dal modello
            modelBuilder.Ignore(Of article)()

        End Sub

    End Class
End Namespace
