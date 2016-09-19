Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Microsoft.Owin.Security
Imports Microsoft.AspNet.Identity.IdentityExtensions

Namespace Models

    Public Class visit 'visite e appuntamenti

        Public Property ID As Integer
        Public Property data As Date 'data in cui avviene la visita
        Public Property agentID As Nullable(Of Integer) 'chi effettua la visita al cliente
        Public Property motivo_type As Nullable(Of motivo)
        Public Property motivo_desc As String
        Public Property data_prossima As Nullable(Of Date) 'data prevista o programmata per la prossima visita
        Public Property preventivo_num As String 'campo libero, ma da prevedere controllo su esistenza del numero preventivo
        Public Property offerta_est As String 'campo libero per inserimento codice offerta elaborata con SAP
        Public Property ordine_num As String 'campo libero, ma da prevedere controllo su esistenza del numero ordine
        Public Property stato As String 'stato della visita, parametri da definire, es: effettuata, rimandata ecc.
        Public Property annull As Boolean
        Public Property data_ins As Nullable(Of Date) 'data di inserimento della visita, non visibile ad utente, timestamp
        Public Property createdby As String 'username di chi inserisce i dati della visita, non visibile all'utente, autocompilato
        Public Property data_upd As Nullable(Of Date) 'data di modifica della visita, non visibile as utente, timestamp
        Public Property updatedby As String 'username di chi modifica i dati della visita, non visibile all'utente, autocompilato
        Public Property rowvers As Byte() 'timestamp per optimistic concurrency
        'Public Property parentID As Nullable(Of Integer) 'è l'id dell'eventuale evento padre da cui deriva l'evento corrente

        'chiave esterna a classe client, richiesta
        Public Property clientID As Nullable(Of Integer)
        'chiave esterna a classe office, optional
        Public Property officeID As Nullable(Of Integer)

        'navigation property verso client
        Public Property client As client
        'navigation property verso office
        Public Property office As office

    End Class

    Public Enum motivo
        PubblicheRelazioni = 1
        Preventivo = 2
    End Enum
End Namespace
