Namespace Models

    Public Class contactname 'contatto associato ad un cliente o sede/filiale

        Public Property ID As Integer
        Public Property nome As String
        Public Property cognome As String
        Public Property telefono As String
        Public Property cellulare As String
        Public Property email As String
        Public Property funzione As String
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna verso classe client
        Public Property clientID As Nullable(Of Integer)
        'chiave esterna verso classe office, optional
        Public Property officeID As Nullable(Of Integer)

        'navigation property verso client
        Public Property client As client
        'navigation property verso office
        Public Property office As office

    End Class

End Namespace