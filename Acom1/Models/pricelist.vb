
'da definire meglio in corrispondenza con article e al processo di importazione listino

Namespace Models
    Public Class pricelist 'listino

        Public Property ID As Integer
        Public Property article_code As String
        Public Property article_desc As String
        Public Property prezzo As Nullable(Of Decimal)
        Public Property data_decorrenza As Nullable(Of Date)
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe product, optional
        Public Property productID As Nullable(Of Integer)
        'chiave esterna a classe family, optional
        Public Property familyID As Nullable(Of Integer)

        'navigation property verso product
        Public Property product As product
        'navigation property cerso family
        Public Property family As family

    End Class

End Namespace
