<%@ Page Title="Clienti" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="Clienti.aspx.vb" Inherits="Acom1.Clienti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>Cerca clienti</h3>
    <p style="padding:10px">
        <asp:Label Text="" ID="errmsg" runat="server" Visible="false" EnableViewState="false" CssClass="alert alert-danger" />
    </p>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:Table ID="TableFindClient" runat="server" >
        <asp:TableRow ID="RagSoc" runat="server" >
            <asp:TableCell ID="lblcodice" runat="server" CssClass="form-label" style="text-align:right">Codice cliente</asp:TableCell>
            <asp:TableCell ID="txtcodice" runat="server">
                <asp:TextBox ID="textcodice" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell ID="lblRagSoc" runat="server" CssClass="form-label" style="text-align:right">Ragione sociale</asp:TableCell>
            <asp:TableCell ID="txtRagSoc" runat="server">
                <asp:TextBox ID="textRagSoc" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="piva" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="prov" runat="server" >
            <asp:TableCell ID="lblprov" runat="server" CssClass="form-label" style="text-align:right">Provincia</asp:TableCell>
            <asp:TableCell ID="txtDDLprov" runat="server">
                <asp:DropDownList ID="provinciaID" runat="server" AutoPostBack="true" SelectMethod="Get_provincie" DataValueField="ID" DataTextField="nome" AppendDataBoundItems="true" CssClass="form-control" OnSelectedIndexChanged="DDLprov_SelectedIndexChanged" >
                    <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblcomune" runat="server" CssClass="form-label" style="text-align:right">Comune</asp:TableCell>
            <asp:TableCell ID="txtDDLcomune" runat="server">
                <asp:DropDownList ID="comuneID" runat="server" SelectMethod="Get_comuni" DataValueField="ID" DataTextField="nome" AppendDataBoundItems="true" CssClass="form-control" >
                     <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="comune" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="canale" runat="server" >
            <asp:TableCell ID="lblagente" runat="server" CssClass="form-label" style="text-align:right">Agente</asp:TableCell>
            <asp:TableCell ID="txtDDLagente" runat="server">
                <asp:DropDownList ID="DDLagente" runat="server" SelectMethod="Get_agents" DataValueField="ID" DataTextField="name" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text="">
                     </asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblcanale" runat="server" CssClass="form-label" style="text-align:right">Canale</asp:TableCell>
            <asp:TableCell ID="txtDDLcanale" runat="server">
                <asp:DropDownList ID="DDLcanale" runat="server" SelectMethod="Get_canals" DataValueField="ID" DataTextField="canal_code" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text="">
                     </asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="agente" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="codice" runat="server">
        </asp:TableRow>
        <asp:TableRow ID="phone" runat="server" >
            <asp:TableCell ID="lblpiva" runat="server" CssClass="form-label" style="text-align:right">P.Iva</asp:TableCell>
            <asp:TableCell ID="txtpiva" runat="server">
                <asp:TextBox ID="textpiva" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell ID="lblphone" runat="server" CssClass="form-label" style="text-align:right">Telefono</asp:TableCell>
            <asp:TableCell ID="txtphone" runat="server">
                <asp:TextBox ID="textphone" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        
    </asp:Table>
              </ContentTemplate> 
    </asp:UpdatePanel>
    <br />
    <asp:Button ID="btnCercaCliente" runat="server" Text="Cerca cliente" CssClass="btn btn-primary btn-hover" Width="15%" />
    <br />
    <br />
    <asp:GridView ID="GridViewClients" DataKeyNames="ID" runat="server" SelectMethod="GridViewClients_GetData" AutoGenerateColumns="False" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true">
        <Columns>
            <asp:HyperLinkField Text="Dettaglio" NavigateUrl="~/User/ClientiIns.aspx" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/User/ClientiIns.aspx?ID={0}" />
            <asp:CommandField ButtonType="Link" ShowSelectButton="true" SelectText="Visualizza filiali" />
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="codice" HeaderText="Codice cliente" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Ragione sociale" />
            <asp:BoundField DataField="piva" HeaderText="P.iva" />
            <asp:BoundField DataField="canal_code" HeaderText="Codice canale" />
            <asp:BoundField DataField="name" HeaderText="Agente" />
            <asp:BoundField DataField="provincia" HeaderText="Provincia" />
            <asp:BoundField DataField="comune" HeaderText="Comune" />
            <asp:BoundField DataField="indirizzo" HeaderText="Indirizzo" />
            <asp:BoundField DataField="cap" HeaderText="CAP" />
            <asp:BoundField DataField="telefono" HeaderText="Telefono" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:CheckBoxField DataField="annull" HeaderText="Disattivato" />
        </Columns>
        <SelectedRowStyle Font-Bold="True" />
    </asp:GridView>
    <br />
    <br />
    <asp:Label ID="titlefiliale" runat="server" Visible="false" EnableViewState="false"><h3>Filiali</h3></asp:Label>
    <br />
    <asp:GridView runat="server" ID="GridViewOffice" DataKeyNames="ID" SelectMethod="GridViewOffice_GetData" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true">
        <Columns>
            <asp:HyperLinkField Text="Dettaglio" NavigateUrl="~/User/FilialiIns.aspx" DataNavigateUrlFields="ID, clientID" DataNavigateUrlFormatString="~/User/FilialiIns.aspx?ID_of={0}&ID_cl={1}" />
            <asp:BoundField DataField="ID" HeaderText="" Visible="false" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Ragione sociale" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="provincia" HeaderText="Provincia" />
            <asp:BoundField DataField="comune" HeaderText="comune" />
            <asp:BoundField DataField="indirizzo" HeaderText="Indirizzo" />
            <asp:BoundField DataField="cap" Headertext="CAP" />
            <asp:BoundField DataField="telefono" HeaderText="Telefono" />
            <asp:BoundField DataField="email" HeaderText="Email" />
        </Columns>
    </asp:GridView>
</asp:Content>
