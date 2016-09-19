Namespace Models
    Public Class product
        Public Property ID As Integer
        Public Property product_name As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'navigation property verso pricelist
        Public Property pricelist As List(Of pricelist)


    End Class
End Namespace