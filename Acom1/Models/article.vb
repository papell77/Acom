'Da definire meglio in corrispondenza a pricelist e al processo di importazione del listino

Namespace Models

    Public Class article

        Public Property ID As Integer
        Public Property article_code As String
        Public Property article_desc As String
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'navigation property verso offer_row
        Public Property offer_rows As List(Of offer_row)


    End Class
End Namespace
