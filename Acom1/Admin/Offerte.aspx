<%@ Page Title="Ricerca Offerte" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="Offerte.aspx.vb" Inherits="Acom1.Offerte" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="OtherContent">
       <p style="padding:10px">
            <asp:Label runat="server" ID="errmsg" Text="" EnableViewState="false" Visible="false" CssClass="alert alert-danger"></asp:Label>
        </p>

       <h3>Cerca offerta</h3>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <asp:Table ID="TableFindOffer" runat="server" >
                <asp:TableRow ID="datadal" runat="server" >
            <asp:TableCell ID="lbldatadal" runat="server" CssClass="form-label" style="text-align:right" >Data dal *</asp:TableCell>
            <asp:TableCell ID="txtdatadal" runat="server">
                <asp:TextBox ID="textdatadal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender ID="calextdatadal" runat="server" TargetControlID="textdatadal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator runat="server" ID="RequiredDataDal" ControlToValidate="textdatadal" ErrorMessage="Inserire data inizio ricerca" Display="None" ></asp:RequiredFieldValidator>
            </asp:TableCell>
            <asp:TableCell ID="lbldataal" runat="server" CssClass="form-label" style="text-align:right">Data al *</asp:TableCell>
            <asp:TableCell ID="txtdataal" runat="server">
                <asp:TextBox ID="textdataal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender runat="server" ID="calextDataal" TargetControlID="textdataal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator runat="server" ID="RequiredDataAl" ControlToValidate="textdataal" ErrorMessage="Inserire data fine ricerca" Display="None" ></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="dataal" runat="server" >
        </asp:TableRow>

        <asp:TableRow ID="agent" runat="server" >
            <asp:TableCell ID="lblagent" runat="server" CssClass="form-label" style="text-align:right">Agente</asp:TableCell>
            <asp:TableCell ID="txtDDLagent" runat="server">
                <asp:DropDownList ID="DDLagent" runat="server" SelectMethod="Get_agents" DataValueField="ID" DataTextField="name" AppendDataBoundItems="true" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblriferimento" runat="server" CssClass="form-label" style="text-align:right">Rif. impianto</asp:TableCell>
            <asp:TableCell ID="txtriferimento" runat="server">
                <asp:TextBox ID="textriferimento" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="cliente" runat="server" >
            <asp:TableCell ID="lblcliente" runat="server" CssClass="form-label" style="text-align:right">Cliente</asp:TableCell>
            <asp:TableCell ID="txtDDLcliente" runat="server">
                <asp:DropDownList ID="clienteID" runat="server" SelectMethod="Get_clients" OnSelectedIndexChanged="clientID_SelectedIndexChanged" DataValueField="ID" DataTextField="ragione_sociale" AutoPostBack="true" AppendDataBoundItems="true" CssClass="form-control">
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

        <asp:TableRow ID="preventivo" runat="server" >
            <asp:TableCell ID="lblpreventivo" runat="server" CssClass="form-label" style="text-align:right">Offerta</asp:TableCell>
            <asp:TableCell ID="txtpreventivo" runat="server">
                <asp:TextBox ID="textpreventivo" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell ID="lblofferta_est" runat="server" CssClass="form-label" style="text-align:right">Offerta esterna</asp:TableCell>
            <asp:TableCell ID="txtofferta_est" runat="server">
                <asp:TextBox ID="textofferta_est" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="offerta_est" runat="server" >
        </asp:TableRow>

        <asp:TableRow ID="family" runat="server" >
            <asp:TableCell ID="lblfamily" runat="server" CssClass="form-label" style="text-align:right">Famiglia</asp:TableCell>
            <asp:TableCell ID="txtDDLfamily" runat="server">
                <asp:DropDownList ID="DDLfamily" runat="server" SelectMethod="Get_families" DataValueField="ID" DataTextField="family_name" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text="">
                     </asp:ListItem>
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

        <asp:TableRow ID="Stato" runat="server">
            <asp:TableCell ID="lblstato" runat="server" CssClass="form-label" style="text-align:right">Stato</asp:TableCell>
            <asp:TableCell ID="DROPstato" runat="server">
                <asp:DropDownList ID="DDLstato" runat="server" AppendDataBoundItems="true" CssClass="form-control" >
                    <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                    <asp:ListItem Value="In Attesa" Text="In Attesa"></asp:ListItem>
                    <asp:ListItem Value="Vinto" Text="Vinto"></asp:ListItem>
                    <asp:ListItem Value="Perso" Text="Perso"></asp:ListItem>
                    <asp:ListItem Value="Aggiornato" Text="Aggiornato"></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblannull" runat="server" CssClass="form-label" style="text-align:right">Annullata</asp:TableCell>
            <asp:TableCell ID="chkannull" runat="server">
                <asp:CheckBox ID="CheckAnnull" runat="server"></asp:CheckBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="Annull" runat="server" >
        </asp:TableRow>
    </asp:Table>

        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Button ID="btnCercaVisita" runat="server" Text="Cerca Preventivo" CssClass="btn btn-primary btn-hover" OnClick="btnCercaVisita_Click" />
    <br />
    <br />
    <asp:GridView ID="GridViewOffer" runat="server" DataKeyNames="ID" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-responsive" >
        <HeaderStyle  Wrap="False" BackColor ="#DCF5FD" Font-Bold="true" />
        <Columns>
            <asp:HyperLinkField Text="Dettaglio" NavigateUrl="~/Admin/OfferteIns.aspx" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/Admin/OfferteIns.aspx?ID={0}" />
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="offer_code" HeaderText="Offerta n." />
            <asp:BoundField DataField="offer_est" HeaderText="Offerta esterna" />
            <asp:BoundField DataField="data" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}"/>
            <asp:BoundField DataField="riferimento" HeaderText="Riferimento" />
            <asp:BoundField DataField="name" HeaderText="Agente" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="importo" HeaderText="Importo" DataFormatString="{0:C}"/>
            <asp:BoundField DataField="note" HeaderText="Note" />
            <asp:BoundField DataField="stato" HeaderText="Stato" />
            <asp:CheckBoxField DataField="annull" HeaderText="Annullato" />
            <asp:BoundField DataField="created_by" HeaderText="Creato da" />
            <asp:BoundField DataField="created_by" HeaderText="Creato il" />
            <asp:BoundField DataField="updated_by" HeaderText="Aggiornato da" />
            <asp:BoundField DataField="updated_date" HeaderText="Aggiornato il" />
        </Columns>
    </asp:GridView>
    <br />

</asp:Content>

