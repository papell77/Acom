<%@ Page Title="Ricerca ordini" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="Ordini.aspx.vb" Inherits="Acom1.Ordini" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="OtherContent">
    <h3>Cerca ordine</h3>
    <h5>I campi contrassegnati con * sono obbligatori</h5>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <p style="padding:10px">
        <asp:Label runat="server" ID="errmsg" Text="" EnableViewState="false"  Visible="false" CssClass="alert alert-danger"></asp:Label>
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
    </p>
    <asp:Table ID="TableFindOrder" runat="server">    
        <asp:TableRow ID="datadal" runat="server" >
            <asp:TableCell ID="lbldatadal" runat="server" CssClass="form-label" style="text-align:right">Data dal *</asp:TableCell>
            <asp:TableCell ID="txtdatadal" runat="server">
                <asp:TextBox ID="textdatadal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender ID="calextdatadal" runat="server" TargetControlID="textdatadal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator runat="server" ID="RequiredDataDal" ControlToValidate="textdatadal" ErrorMessage="Inserire data inizio ricerca" Display="none" ></asp:RequiredFieldValidator>
            </asp:TableCell>
             <asp:TableCell ID="lbldataal" runat="server"  CssClass="form-label" style="text-align:right">Data al *</asp:TableCell>
            <asp:TableCell ID="txtdataal" runat="server">
                <asp:TextBox ID="textdataal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender runat="server" ID="calextDataal" TargetControlID="textdataal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator runat="server" ID="RequiredDataAl" ControlToValidate="textdataal" ErrorMessage="Inserire data fine ricerca" Display="none"></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="dataal" runat="server" >
            <asp:TableCell ID="lblagent" runat="server"  CssClass="form-label" style="text-align:right">Agente</asp:TableCell>
            <asp:TableCell ID="txtDDLagent" runat="server">
                <asp:DropDownList ID="DDLagent" runat="server" SelectMethod="Get_agents" DataValueField="ID" DataTextField="name" AppendDataBoundItems="true" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblrifimpianto" runat="server" CssClass="form-label" style="text-align:right">Rif. impianto</asp:TableCell>
            <asp:TableCell ID="txtrifimpianto" runat="server">
                <asp:TextBox ID="textrifimpianto" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="ordineSAP" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="agent" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="cliente" runat="server" >
            <asp:TableCell ID="lblcliente" runat="server"  CssClass="form-label" style="text-align:right">Cliente</asp:TableCell>
            <asp:TableCell ID="txtDDLcliente" runat="server">
                <asp:DropDownList ID="clienteID" runat="server" SelectMethod="Get_clients" OnSelectedIndexChanged="clienteID_SelectedIndexChanged" DataValueField="ID" DataTextField="ragione_sociale" AutoPostBack="true" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList> 
            </asp:TableCell>
            <asp:TableCell ID="lblfiliale" runat="server" CssClass="form-label" style="text-align:right">Filiale</asp:TableCell>
            <asp:TableCell ID="txtDDLfiliale" runat="server">
                <asp:DropDownList ID="officeID" runat="server" CssClass="form-control">
                </asp:DropDownList> 
            </asp:TableCell>
        </asp:TableRow>
        
        <asp:TableRow ID="filiale" runat="server" >
        </asp:TableRow>
        
        <asp:TableRow ID="offerta" runat="server" >
            <asp:TableCell ID="lblofferta" runat="server" CssClass="form-label" style="text-align:right">Offerta</asp:TableCell>
            <asp:TableCell ID="txtofferta" runat="server">
                <asp:TextBox ID="textofferta" runat="server" CssClass="form-control" ></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell ID="lbloffertaest" runat="server" CssClass="form-label" style="text-align:right">Offerta esterna</asp:TableCell>
            <asp:TableCell ID="txtoffertaest" runat="server">
                <asp:TextBox ID="textoffertaest" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="ordine" runat="server" >
            <asp:TableCell ID="lblordine" runat="server"  CssClass="form-label" style="text-align:right">Ordine n.</asp:TableCell>
            <asp:TableCell ID="txtordine" runat="server">
                <asp:TextBox ID="textordine" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell ID="lblordineSAP" runat="server"  CssClass="form-label" style="text-align:right">Ordine SAP</asp:TableCell>
            <asp:TableCell ID="txtordineSAP" runat="server">
                <asp:TextBox ID="textordineSAP" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        
        <asp:TableRow ID="ordine_cliente" runat="server" >
        </asp:TableRow>

        <asp:TableRow ID="rif_impianto" runat="server" >
            <asp:TableCell ID="lblordinecliente" runat="server" CssClass="form-label" style="text-align:right">Ordine cliente</asp:TableCell>
            <asp:TableCell ID="txtordinecliente" runat="server">
                <asp:TextBox ID="ordinecliente" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="canale" runat="server" >
            <asp:TableCell ID="lblcanale" runat="server" CssClass="form-label" style="text-align:right">Canale</asp:TableCell>
            <asp:TableCell ID="txtDDLcanale" runat="server">
                <asp:DropDownList ID="canalID" runat="server" SelectMethod="Get_canal" DataValueField="ID" DataTextField="canal_code" AutoPostBack="true" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList> 
            </asp:TableCell>
            <asp:TableCell ID="lblproduct" runat="server" CssClass="form-label" style="text-align:right">Prodotto</asp:TableCell>
            <asp:TableCell ID="txtDDLproduct" runat="server">
                <asp:DropDownList ID="DDLproduct" runat="server" SelectMethod="Get_products" DataValueField="ID" DataTextField="product_name" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text="">
                     </asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        
        <asp:TableRow ID="product" runat="server" >
        </asp:TableRow>

        <asp:TableRow ID="offerta_est" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="annull" runat="server" >
            <asp:TableCell ID="lblannull" runat="server" CssClass="form-label" style="text-align:right">Annullato</asp:TableCell>
            <asp:TableCell ID="chkannull" runat="server">
                <asp:CheckBox ID="checkAnnull" runat="server" ></asp:CheckBox>
            </asp:TableCell>
        </asp:TableRow>

    </asp:Table>
            </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Button ID="btnCercaOrdine" runat="server" Text="Cerca Ordine" CssClass="btn btn-primary btn-hover" OnClick="btnCercaOrdine_Click" />
    <br />
    <br />
    <h5>In giallo sono evidenziati gli ordini privi di dettaglio prodotti</h5>
        <asp:GridView ID="GridViewOrder" runat="server" DataKeyNames="ID" AutoGenerateColumns="false" OnDataBound="GridViewOrder_DataBound" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true">
        <Columns>
            <asp:HyperLinkField Text="Dettaglio" NavigateUrl="~/Admin/OrdiniIns.aspx" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/Admin/OrdiniIns.aspx?ID={0}" />
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="order_code" HeaderText="Ordine n." ItemStyle-Wrap="false" />
            <asp:BoundField DataField="order_sap" HeaderText="Ordine SAP" ItemStyle-Wrap="false"/>
            <asp:BoundField DataField="data" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="name" HeaderText="Agente" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="canal_code" HeaderText="Canale" />
            <asp:BoundField DataField="importo" HeaderText="Importo" DataFormatString="{0:C}" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="rif_impianto" HeaderText="Rif. impianto" />
            <asp:BoundField DataField="rif_offerta" HeaderText="Offerta" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="rif_offertaest" HeaderText="Offerta esterna" />
            <asp:BoundField DataField="rif_ordinecliente" HeaderText="Ordine cliente" />
            <asp:CheckBoxField DataField="annull" HeaderText="Annullato" ItemStyle-HorizontalAlign="Center" />
            <asp:TemplateField HeaderText="Righe Prodotti">
                <ItemTemplate>
                    <asp:Label ID="num_product" runat="server" Text='<%# Eval("num_product")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
<%--            <asp:BoundField DataField="num_product" HeaderText="Numero prodotti" />--%>
            <asp:BoundField DataField="created_by" HeaderText="Creato da" Visible="true" />
            <asp:BoundField DataField="created_by" HeaderText="Creato il" Visible="true" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="updated_by" HeaderText="Modificato da" Visible="true" />
            <asp:BoundField DataField="updated_date" HeaderText="Modificato il" Visible="true" DataFormatString="{0:dd/MM/yyyy}" />
        </Columns>
    </asp:GridView>

</asp:Content>


