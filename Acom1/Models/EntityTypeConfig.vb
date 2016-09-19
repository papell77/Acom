Imports System.Collections.Generic
Imports System.Data.Entity.ModelConfiguration
Imports System.Data.Entity.Infrastructure.Annotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports Acom1.Models
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports Owin


'queste classi servono come raggruppamento delle configurazioni FluentApi
Public Class clientconfig
    Inherits EntityTypeConfiguration(Of client)

    Public Sub New()

        [Property](Function(p) p.rowvers).IsRowVersion()

        'Provincia, comune e canale hanno relazione optional con client
        HasOptional(Function(c) c.comune).WithMany(Function(c) c.clients)
        HasOptional(Function(c) c.provincia).WithMany(Function(c) c.clients)
        HasOptional(Function(c) c.canal).WithMany(Function(c) c.clients)
        HasOptional(Function(c) c.payment).WithMany(Function(c) c.clients)
        HasOptional(Function(c) c.transport).WithMany(Function(c) c.clients)
        HasOptional(Function(c) c.agent).WithMany(Function(c) c.clients)

        'codice deve essere univoco, ma non obbligatorio, in mancanza viene generato un codice temporaneo automaticamente
        [Property](Function(p) p.codice).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXCodice_cliente", 1) With {.IsUnique = True}))
        [Property](Function(p) p.ragione_sociale).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXRagione_sociale", 1) With {.IsUnique = True}))

    End Sub
End Class

Public Class contactnameconfig
    Inherits EntityTypeConfiguration(Of contactname)

    Public Sub New()


        [Property](Function(p) p.rowvers).IsRowVersion()

        'un contatto può avere il riferimento ad un cliente e ad un office
        HasOptional(Function(c) c.client).WithMany(Function(c) c.contacts)
        HasOptional(Function(c) c.office).WithMany(Function(c) c.contacts)

    End Sub

End Class

Public Class offerconfig
    Inherits EntityTypeConfiguration(Of offer)

    Public Sub New()

        [Property](Function(p) p.offer_code).IsRequired()
        [Property](Function(p) p.clientID).IsRequired()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.officeID).IsOptional()
        [Property](Function(p) p.paymentID).IsOptional()
        [Property](Function(p) p.transportID).IsOptional()
        [Property](Function(p) p.agentID).IsOptional()
        [Property](Function(p) p.contactID).IsOptional()
        [Property](Function(p) p.familyID).IsOptional()
        [Property](Function(p) p.resaID).IsOptional()
        [Property](Function(p) p.garanziaID).IsOptional()


    End Sub
End Class

Public Class offer_rowconfig
    Inherits EntityTypeConfiguration(Of offer_row)

    Public Sub New()

        [Property](Function(p) p.articleID).IsRequired()
        [Property](Function(p) p.offerID).IsRequired()
        [Property](Function(p) p.rowvers).IsRowVersion()

    End Sub

End Class

Public Class officeconfig
    Inherits EntityTypeConfiguration(Of office)

    Public Sub New()

        [Property](Function(p) p.rowvers).IsRowVersion()

        'provincia e comune hanno relazione optional con office
        HasOptional(Function(c) c.comune).WithMany(Function(c) c.offices)
        HasOptional(Function(c) c.provincia).WithMany(Function(c) c.offices)

        [Property](Function(p) p.nome).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXCodice_filiale", 1) With {.IsUnique = True}))
        [Property](Function(p) p.clientID).IsRequired.HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXCodice_filiale", 2) With {.IsUnique = True}))
    End Sub

End Class

Public Class orderconfig
    Inherits EntityTypeConfiguration(Of order)

    Public Sub New()

        [Property](Function(c) c.clientID).IsRequired()
        [Property](Function(o) o.officeID).IsOptional()
        [Property](Function(p) p.rowvers).IsRowVersion().IsConcurrencyToken()

    End Sub

End Class

Public Class order_rowconfig
    Inherits EntityTypeConfiguration(Of order_row)

    Public Sub New()
        [Property](Function(p) p.productID).IsRequired()
        [Property](Function(p) p.orderID).IsRequired()
        [Property](Function(p) p.rowvers).IsRowVersion()

    End Sub

End Class

Public Class pricelistconfig
    Inherits EntityTypeConfiguration(Of pricelist)

    Public Sub New()


        [Property](Function(p) p.rowvers).IsRowVersion()
        'HasKey(Function(c) New With {c.article_code, c.data_decorrenza})
        HasOptional(Function(c) c.product).WithMany(Function(c) c.pricelist)
        'queste proprietà servono per creare un indice univoco dato da codice articolo e data decorrenza
        [Property](Function(p) p.article_code).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXArticle_data", 1) With {.IsUnique = True}))
        [Property](Function(p) p.data_decorrenza).IsRequired.HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXArticle_data", 2) With {.IsUnique = True}))
    End Sub

End Class

Public Class visitconfig
    Inherits EntityTypeConfiguration(Of visit)

    Public Sub New()
        [Property](Function(p) p.data_prossima).IsOptional()
        [Property](Function(p) p.agentID).IsOptional()
        [Property](Function(p) p.rowvers).IsRowVersion()

    End Sub

End Class

Public Class comuneconfig
    Inherits EntityTypeConfiguration(Of comune)

    Public Sub New()

        [Property](Function(p) p.rowvers).IsRowVersion()

        'la relazione tra provincia e comune è richiesta
        HasRequired(Function(c) c.provincia).WithMany(Function(c) c.comuni)

    End Sub

End Class

Public Class provinciaconfig
    Inherits EntityTypeConfiguration(Of provincia)

    Public Sub New()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.nome).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXprovincia_nome", 1) With {.IsUnique = True}))

    End Sub

End Class

Public Class productconfig
    Inherits EntityTypeConfiguration(Of product)

    Public Sub New()
        [Property](Function(p) p.updated_date).IsOptional()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.product_name).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXproduct_name", 1) With {.IsUnique = True}))

    End Sub
End Class

Public Class agentconfig
    Inherits EntityTypeConfiguration(Of agent)

    Public Sub New()
        [Property](Function(p) p.username).IsOptional()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.name).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXagent_name", 1) With {.IsUnique = True}))

    End Sub
End Class

Public Class canalconfig
    Inherits EntityTypeConfiguration(Of canal)

    Public Sub New()

        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.canal_code).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXcanal_code", 1) With {.IsUnique = True}))

    End Sub

End Class

Public Class familyconfig
    Inherits EntityTypeConfiguration(Of family)

    Public Sub New()
        [Property](Function(p) p.updated_date).IsOptional()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.family_name).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXfamily_name", 1) With {.IsUnique = True}))

    End Sub
End Class

Public Class paymentconfig
    Inherits EntityTypeConfiguration(Of payment)

    Public Sub New()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.pagamento).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXpagamento_nome", 1) With {.IsUnique = True}))

    End Sub
End Class

Public Class transportconfig
    Inherits EntityTypeConfiguration(Of transport)

    Public Sub New()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.trasporto).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXtrasporto_nome", 1) With {.IsUnique = True}))

    End Sub
End Class

Public Class resaconfig
    Inherits EntityTypeConfiguration(Of resa)

    Public Sub New()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.resa_desc).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXresa_desc", 1) With {.IsUnique = True}))

    End Sub
End Class

Public Class garanziaconfig
    Inherits EntityTypeConfiguration(Of garanzia)

    Public Sub New()
        [Property](Function(p) p.rowvers).IsRowVersion()
        [Property](Function(p) p.garanzia_desc).IsRequired.HasMaxLength(400).HasColumnAnnotation(IndexAnnotation.AnnotationName, New IndexAnnotation(New IndexAttribute("IXgaranzia_desc", 1) With {.IsUnique = True}))

    End Sub
End Class