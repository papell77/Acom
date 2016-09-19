

Namespace Models
    Public Class office 'rappresenta una sede secondaria o filiale di un client

        Public Property ID As Integer
        Public Property nome As String
        Public Property cap As String
        Public Property indirizzo As String
        Public Property telefono As String
        Public Property email As String
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe client
        Public Property clientID As Integer
        'chiave esterna a classe provincia
        Public Property provinciaID As Nullable(Of Integer)
        'chiave esterna a classe comune
        Public Property comuneID As Nullable(Of Integer)

        'navigation property verso client
        Public Property client As client
        'navigation property verso order
        Public Property contacts As List(Of contactname)
        'navigation property verso order
        Public Property orders As List(Of order)
        'navigation property verso offer
        Public Property offers As List(Of offer)
        'navigation property verso visit
        Public Property visits As List(Of visit)
        'navigation property verso comune
        Public Property comune As comune
        'navigation property verso comune
        Public Property provincia As provincia



    End Class

End Namespace
