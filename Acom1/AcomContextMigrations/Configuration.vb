Imports System
Imports System.Data.Entity
Imports System.Data.Entity.Migrations
Imports System.Linq
Imports Acom1.DAL
Imports Acom1.Models
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework



Namespace AcomContextMigrations

    Friend NotInheritable Class Configuration 
        Inherits DbMigrationsConfiguration(Of DAL.AcomContext)

        Public Sub New()
            AutomaticMigrationsEnabled = False
            Database.SetInitializer(Of AcomContext)(Nothing)
            MigrationsDirectory = "AcomContextMigrations"
        End Sub

        Protected Overrides Sub Seed(context As DAL.AcomContext)
            '  This method will be called after migrating to the latest version.

            '  You can use the DbSet(Of T).AddOrUpdate() helper extension method 
            '  to avoid creating duplicate seed data. E.g.
            '
            '    context.People.AddOrUpdate(
            '       Function(c) c.FullName,
            '       New Customer() With {.FullName = "Andrew Peters"},
            '       New Customer() With {.FullName = "Brice Lambson"},
            '       New Customer() With {.FullName = "Rowan Miller"})

            ''inizializzo una lista di provincie
            'Dim provincie = New List(Of provincia)() From {
            '    New provincia With {
            '        .nome = "Varese",
            '        .sigla = "VA",
            '        .annull = 0
            '        },
            '    New provincia With {
            '        .nome = "Milano",
            '        .sigla = "MI",
            '        .annull = 0
            '        },
            '    New provincia With {
            '        .nome = "Monza e Brianza",
            '        .sigla = "MB",
            '.annull = 0
            '        }
            '}
            'For Each s In provincie
            '    context.provincie.AddOrUpdate(Function(p) p.sigla, s)
            'Next
            'context.SaveChanges()

            'inizializzo una lista di comuni
            'Dim comuni = New List(Of comune)() From {
            '   New comune With {
            '      .nome = "Saronno",
            '.provinciaID = 1
            '        },
            '    New comune With {
            '        .nome = "Caronno",
            '.provinciaID = 1
            '        },
            '    New comune With {
            '        .nome = "Solaro",
            '.provinciaID = 6
            '        }
            '    }
            'For Each s In comuni
            'context.comuni.AddOrUpdate(Function(p) p.nome, s)
            'Next
            'context.SaveChanges()


            ''inizializzo una lista di canali
            'Dim canals = New List(Of canal)() From {
            '    New canal With {
            '    .canal_code = "B1",
            '    .canal_desc = "canale B1"
            '    },
            '    New canal With {
            '    .canal_code = "C1",
            '    .canal_desc = "canale C1"}
            '}
            'For Each s In canals
            '    context.canals.AddOrUpdate(Function(p) p.canal_code, s)
            'Next
            'context.SaveChanges()



            ''inizializzo una lista di agenti
            'Dim agents = New List(Of agent)() From {
            '    New agent With {
            '        .name = "agente1"},
            '    New agent With {
            '        .name = "agente2"},
            '    New agent With {
            '        .name = "agente3"},
            '    New agent With {
            '        .name = "agente4"}
            '}
            'For Each s In agents
            '    context.agents.AddOrUpdate(Function(p) p.name, s)
            'Next

            'Dim family = New List(Of family)() From {
            '    New family With {.family_name = "Residenziale"}, _
            '    New family With {.family_name = "Commerciale"}, _
            '    New family With {.family_name = "Accessori"}, _
            '    New family With {.family_name = "Accumuli VA"}, _
            '    New family With {.family_name = "Aircontrol"}, _
            '    New family With {.family_name = "Airnova"}, _
            '    New family With {.family_name = "Caldaie"}, _
            '    New family With {.family_name = "Caldaie componenti"}, _
            '    New family With {.family_name = "Caldaie murali"}, _
            '    New family With {.family_name = "Collaudo"}, _
            '    New family With {.family_name = "Commissioning"}, _
            '    New family With {.family_name = "Componenti"}, _
            '    New family With {.family_name = "Conveni Pack"}, _
            '    New family With {.family_name = "Daikin"}, _
            '    New family With {.family_name = "Fancoil"}, _
            '    New family With {.family_name = "HPSU Componenti"}, _
            '    New family With {.family_name = "Idronico"}, _
            '    New family With {.family_name = "Piastre"}, _
            '    New family With {.family_name = "Rotex"}, _
            '    New family With {.family_name = "Solare componenti"}, _
            '    New family With {.family_name = "TOT"}, _
            '    New family With {.family_name = "Tubo duo"}, _
            '    New family With {.family_name = "Tubo monopex"}, _
            '    New family With {.family_name = "UTA"}, _
            '    New family With {.family_name = "VRV"}}
            'For Each f In family
            '    context.family.AddOrUpdate(Function(p) p.family_name, f)
            'Next

            'Dim product = New List(Of product)() From {
            '    New product With {.product_name = "Accessori"}, _
            '    New product With {.product_name = "Aircontrol"}, _
            '    New product With {.product_name = "Avviamento"}, _
            '    New product With {.product_name = "Caldaie"}, _
            '    New product With {.product_name = "Monosplit"}, _
            '    New product With {.product_name = "Multisplit"}}
            'For Each t In product
            '    context.products.AddOrUpdate(Function(p) p.product_name, t)
            'Next
        End Sub

    End Class

End Namespace
