Namespace Models
    Public Class order

        Public Property ID As Integer
        Public Property order_code As String 'autogenerato
        Public Property order_num As Integer 'autogenerato 
        Public Property order_sap As String 'numero ordine sap Daikin
        Public Property data As Nullable(Of Date)
        Public Property importo As Nullable(Of Decimal)
        Public Property rif_impianto As String 'riferimento numero impianto cliente
        Public Property rif_offerta As String 'riferimento offerta, offer_code
        Public Property rif_offertaest As String 'riferimento offerta esterna sap Daikin
        Public Property rif_ordinecliente As String 'riferimento ordine cliente, testuale libero
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe offer, relazione 1 a 1, obbligatoria?
        'Public Property offerID As Nullable(Of Integer)
        'chiave esterna a classe client
        Public Property clientID As Integer
        'chiave esterna a classe office, se necessaria
        Public Property officeID As Nullable(Of Integer)
        'chiave esterna a classe agent, se necessaria
        Public Property agentID As Nullable(Of Integer)

        'navigation property verso order_row
        Public Property order_rows As List(Of order_row)
        'navigation property verso client
        Public Property client As client
        'navigation property verso office
        Public Property office As office
        'navigation property verso agent
        Public Property agent As agent

    End Class

    Public Class order_row

        Public Property ID As Integer
        Public Property rigaID As Nullable(Of Integer)
        Public Property quantita As Nullable(Of Decimal)
        Public Property prezzo As Nullable(Of Decimal)
        Public Property totale As Nullable(Of Decimal)
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe order
        Public Property orderID As Integer
        'chiave esterna ad classe product
        Public Property productID As Integer
        Public Property familyID As Integer


        'navigation property verso order
        Public Property order As order
        'navigation property verso article
        Public Property product As product
        Public Property family As family

    End Class
End Namespace
