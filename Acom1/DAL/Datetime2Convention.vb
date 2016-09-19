Imports System.Data.Entity.ModelConfiguration.Conventions

Namespace DAL

    'converte tutti i campi date di .net in datetime2(7), segue impostazione della convenzione in classe AcomContext
    Public Class Datetime2Convention
        Inherits Convention

        Public Sub New()
            Properties(Of Date)().Configure(Function(c) c.HasColumnType("datetime2"))

        End Sub
    End Class
End Namespace