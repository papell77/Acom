Namespace Models

    Public Class client

        Public Property ID As Integer
        Public Property codice As String
        Public Property ragione_sociale As String
        Public Property CF As String
        Public Property piva As String
        Public Property pivaCEE As String
        Public Property cap As String
        Public Property indirizzo As String
        Public Property telefono As String
        Public Property email As String

        Public Property invio_fattura As String 'preferenze di invio fatture, posta email fax
        Public Property note As String
        Public Property banca As String
        Public Property iban As String
        Public Property fatturato As Nullable(Of Decimal) 'stima del fatturato annuale
        Public Property fatturato_potenz As Nullable(Of Decimal) 'fatturato potenziale con Daikin
        Public Property fido_richiesto As Nullable(Of Decimal)
        Public Property fido_concesso As Nullable(Of Decimal) 'valore statico
        Public Property scadenza_fido As Nullable(Of Date)
        Public Property fondazione As Nullable(Of Date) 'Data di nascita o anno di nascita, cambiare tipo
        Public Property possedimenti As String 'proprietà dell'azienda, terreni, fabbricati ecc.
        Public Property dipendenti As Nullable(Of Integer) 'numero dipendenti
        Public Property annull As Boolean

        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property data_aggiornamento As Nullable(Of Date)  'data ultimo aggiornamento
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe provincia
        Public Property provinciaID As Nullable(Of Integer)
        'chiave esterna a classe comune
        Public Property comuneID As Nullable(Of Integer)
        'chiave esterna a classe canal
        Public Property canalID As Nullable(Of Integer)
        'chiave esterna a classe payment
        Public Property paymentID As Nullable(Of Integer)
        'chiave esterna a classe transport
        Public Property transportID As Nullable(Of Integer)
        'chiave esterna a classe agent
        Public Property agentID As Nullable(Of Integer)

        'navigation property verso office
        Public Property offices As List(Of office)
        'navigation property verso contact
        Public Property contacts As List(Of contactname)
        'navigation property verso discount_list
        Public Property discount_lists As List(Of discount_list)
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
        'navigation property verso canal
        Public Property canal As canal
        'navigation property verso payment
        Public Property payment As payment
        'navigation property verso transport
        Public Property transport As transport
        'navigation property verso agent
        Public Property agent As agent


    End Class

    Public Class discount_list

        Public Property ID As Integer
        Public Property discount As Nullable(Of Decimal)
        Public Property product As product
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe client
        Public Property clientID As Integer

        'navigation property verso client
        Public Property client As client
        'da valutare la necessità di sconti per filiale, e quindi aggiungere il campo office come chiave esterna


    End Class
End Namespace
