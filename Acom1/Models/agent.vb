Namespace Models
    Public Class agent

        Public Property ID As Integer
        Public Property name As String
        Public Property username As String 'è lo username associato all'agente
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property aggiorn_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'navigation property verso client
        Public Property clients As List(Of client)

    End Class
End Namespace
