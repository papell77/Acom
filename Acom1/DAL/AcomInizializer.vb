Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Data.Entity
Imports Acom1.Models

Namespace DAL
    Public Class AcomInizializer
        Inherits DropCreateDatabaseIfModelChanges(Of AcomContext)

        Protected Overrides Sub Seed(ByVal context As AcomContext)

            'inizializzo una lista di provincie
            Dim provincie = New List(Of provincia)() From {
                New provincia With {
                    .nome = "Varese",
                    .sigla = "VA"
                    }
            }
            provincie.ForEach(Function(p) context.provincie.Add(p))
            context.SaveChanges()

            'inizializzo una lista di comuni
            Dim comuni = New List(Of comune)() From {
                New comune With {
                    .nome = "Saronno",
                    .provinciaID = 1
                    }
                }
            comuni.ForEach(Function(c) context.comuni.Add(c))
            context.SaveChanges()

            'inizializzo una lista di clienti
            Dim clients = New List(Of client)() From {
                New client With {
                    .ragione_sociale = "pizza veloce",
                    .piva = "011372895897",
                        .cap = "21047",
                        .comuneID = 1,
                        .provinciaID = 1,
                        .indirizzo = "via miola",
                        .telefono = "0392752428",
                        .email = "info@pippo.it"
                    },
                New client With {
                    .ragione_sociale = "pizza media",
                    .piva = "011372895",
                        .cap = "21047",
                        .comuneID = 1,
                        .provinciaID = 1,
                        .indirizzo = "via miola",
                        .telefono = "0392752428",
                        .email = "info@pippo.it"
                    },
                New client With {
                    .ragione_sociale = "pizza lenta",
                    .piva = "0113728957687",
                    .cap = "21047",
                    .comuneID = 1,
                    .provinciaID = 1,
                    .indirizzo = "via miola",
                    .telefono = "0392752428",
                    .email = "info@pippo.it"
                    },
                New client With {
                    .ragione_sociale = "pizza fredda",
                    .piva = "011372895232131",
                        .cap = "21047",
                        .comuneID = 1,
                        .provinciaID = 1,
                        .indirizzo = "via miola",
                        .telefono = "0392752428",
                        .email = "info@pippo.it"
                    }
            }
            clients.ForEach(Function(c) context.clients.Add(c))
            context.SaveChanges()


        End Sub

    End Class
End Namespace
