Imports Acom1.DAL

Namespace Models
    Public Class offer

        Public Property ID As Integer
        Public Property offer_num As Integer
        Public Property offer_vers As Integer
        Public Property offer_code As String
        Public Property offer_est As String 'codice sap di offerte eseguite tramite gestionale Daikin, campo testuale libero
        Public Property data As Date
        Public Property data_valid As Nullable(Of Date)
        Public Property riferimento As String
        Public Property stato As String
        Public Property importo As Nullable(Of Decimal) 'questo campo dovrebbe contenere l'importo totale
        Public Property costo_trasporto As Nullable(Of Decimal) 'importo totale del costo di trasporto se previsto
        Public Property annull As Boolean
        Public Property consegna As String
        Public Property imballo As String
        Public Property note As String
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe client
        Public Property clientID As Integer
        'chiave esterna a classe office
        Public Property officeID As Nullable(Of Integer)
        'chiave esterna a classe family
        Public Property familyID As Nullable(Of Integer)
        'chiave esterna a classe agente
        Public Property agentID As Nullable(Of Integer)
        'chiave esterna a classe contactname
        Public Property contactID As Nullable(Of Integer)
        'chiave esterna a classe payment
        Public Property paymentID As Nullable(Of Integer)
        'chiave esterna a classe transport
        Public Property transportID As Nullable(Of Integer)
        'chiave esterna a classe resa
        Public Property resaID As Nullable(Of Integer)
        'chiave esterna a classe garanzia
        Public Property garanziaID As Nullable(Of Integer)


        'navigation property verso client
        Public Property client As client
        'navigation property verso office
        Public Property office As office
        'navigation property verso order, relazione 1 a 1 non obbligatoria
        Public Property order As order
        'navigation property verso family
        Public Property family As family
        'navigation property verso agent
        Public Property agent As agent
        'navigation property verso contactname
        Public Property contact As contactname
        'navigation property verso offer_row
        Public Property offer_rows As List(Of offer_row)
        'navigation property verso payment
        Public Property payment As payment
        'navigation property verso transport
        Public Property transport As transport
        'navigation property verso resa
        Public Property resa As resa
        'navigation property verso garanzia
        Public Property garanzia As garanzia


    End Class

    Public Class offer_row

        Public Property ID As Integer
        Public Property rigaID As Integer 'da valutarne l'utilità vista la presenza di ID: se non serve avere le righe numerate basta l'ID univoco
        'campo articolo, vedi sotto
        Public Property quantita As Nullable(Of Decimal)
        Public Property prezzo As Nullable(Of Decimal)
        Public Property sconto1 As Nullable(Of Decimal)
        Public Property sconto2 As Nullable(Of Decimal)
        Public Property sconto3 As Nullable(Of Decimal)
        Public Property sconto4 As Nullable(Of Decimal)
        Public Property sconto5 As Nullable(Of Decimal)
        Public Property sconto6 As Nullable(Of Decimal)
        Public Property totale As Nullable(Of Decimal)
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency

        'chiave esterna a classe offer
        Public Property offerID As Integer
        'chiave esterna ad anagrafica articoli, da definire in base a quale sarà l'anagrafica articolo
        Public Property articleID As String

        'navigation property verso offer
        Public Property offer As offer
        'navigation property verso article
        Public Property article As article

    End Class

    Public Class transport 'raccoglie i dettagli dei costi di trasporto
        Public Property ID As Integer
        Public Property trasporto As String
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte()

        'navigation property verso client
        Public Property clients As List(Of client)

    End Class

    Public Class payment 'raccoglie i dettagli sui metodi di pagamento
        Public Property ID As Integer
        Public Property pagamento As String
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte()

        'navigation property verso client
        Public Property clients As List(Of client)

    End Class

    Public Class resa 'raccoglie la tipologia di trasporto

        Public Property ID As Integer
        Public Property resa_desc As String
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte()

    End Class

    Public Class garanzia 'raccoglie le diverse forme di garanzia
        Public Property ID As Integer
        Public Property garanzia_desc As String
        Public Property note As String
        Public Property annull As Boolean
        Public Property created_by As String
        Public Property created_date As Nullable(Of Date)
        Public Property updated_by As String
        Public Property updated_date As Nullable(Of Date)
        Public Property rowvers As Byte()

    End Class
End Namespace
