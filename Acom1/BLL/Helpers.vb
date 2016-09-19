Imports Acom1.Models
Imports Acom1.DAL
Imports System.Data.Entity

Namespace BLL
    Public Class Helpers

        Public Function Get_payment() As IQueryable(Of payment)

            Dim context As New AcomContext
            Return context.payments.SqlQuery("SELECT * FROM dbo.payments")


        End Function

        Public Function Get_transport() As IQueryable(Of transport)

            Dim context As New AcomContext
            Return context.transports.SqlQuery("SELECT * FROM dbo.transports")

        End Function

        Public Function Get_provincia() As IQueryable(Of provincia)

            Dim context As New AcomContext
            Return context.provincie.SqlQuery("SELECT * FROM dbo.provincias")

        End Function

        Public Function Get_comune() As IQueryable(Of comune)

            Dim context As New AcomContext
            Return context.comuni.SqlQuery("SELECT * FROM dbo.comunes")

        End Function

        Public Function Get_canal() As IQueryable(Of canal)

            Dim context As New AcomContext
            Return context.canals.SqlQuery("SELECT * FROM dbo.canals")

        End Function
    End Class
End Namespace
