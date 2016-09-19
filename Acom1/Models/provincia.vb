Namespace Models

    Public Class provincia

        Public Property ID As Integer
        Public Property nome As String
        Public Property sigla As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'navigation property verso client
        Public Property clients As List(Of client)
        'navigation property verso office
        Public Property offices As List(Of office)
        'navigation property verso comune
        Public Property comuni As List(Of comune)

    End Class
End Namespace

