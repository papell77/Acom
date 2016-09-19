
Namespace Models
    Public Class canal
        Public Property ID As Integer
        Public Property canal_code As String
        Public Property canal_desc As String
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