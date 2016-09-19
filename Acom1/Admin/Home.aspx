<%@ Page Title="Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="Home.aspx.vb" Inherits="Acom1.Home" %>

<asp:Content ID="main" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>
    Dashboard amministrazione
    </h3>
    <p>&nbsp;</p>
    <h4>Situazione agenti</h4>
    <h5>Eventi non conclusi e offerte in attesa</h5>
    <asp:PlaceHolder runat="server" ID="errmsg_gridvisite" Visible="false">
        <asp:label ID="lbl_errmsg_gridvisite" Text="" runat="server" CssClass="alert alert-danger" />
    </asp:PlaceHolder>
    <asp:GridView ID="GridVisite" runat="server" SelectMethod="GridVisite_GetData" AutoGenerateColumns="False" DataKeyNames="ID"  CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true" Width="50%">
        <Columns>
<%--            <asp:HyperLinkField Text="Modifica" NavigateUrl="~/User/VisiteIns.aspx?ID={0}" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/User/VisiteIns.aspx?ID={0}" />--%>
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="name" HeaderText="Agente" />
            <asp:BoundField DataField="visit" HeaderText="Eventi non conclusi" />
            <asp:BoundField DataField="offers" HeaderText="Offerte in attesa" />
            </Columns>
        <EmptyDataTemplate>
            Nessun dato disponibile
        </EmptyDataTemplate>
    </asp:GridView>
    <br />
    <h4>Situazione ordini</h4>
    <h5>
        <asp:Label ID="lbl_ordini" Text="" runat="server" EnableViewState="false" Visible="false" /></h5>
    <asp:Label ID="errmsg_ordini" CssClass="alert alert-danger" Text="" runat="server" EnableViewState="false" Visible="false" />
<%--    <asp:Label runat="server" ID="lblprev1" Font-Bold="true" Font-Size="Medium">Offerte in scadenza nei prossimi </asp:Label> &nbsp;
    <asp:DropDownList ID="DropDownGGPreventivi" runat="server"  AutoPostBack="true" Font-Size="Medium">
        <asp:ListItem Selected="True">7</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
        <asp:ListItem>30</asp:ListItem>
    </asp:DropDownList>
&nbsp;<asp:Label runat="server" ID="lblprev2" Font-Bold="true" Font-Size="Medium">giorni</asp:Label>
    <br />
    <br />
    <asp:GridView ID="GridPreventivi" AutoGenerateColumns="false" runat="server" SelectMethod="GridPreventivi_GetData" OnDataBound="GridPreventivi_DataBound" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true">
        <Columns>
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="offer_code" HeaderText="Offerta" />
            <asp:BoundField DataField="offer_est" HeaderText="Offerta esterna" />
            <asp:BoundField DataField="data" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="riferimento" HeaderText="Riferimento" />
            <asp:BoundField DataField="cognome" HeaderText="Contatto cliente" />
            <asp:TemplateField HeaderText="Scadenza offerta" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="dataval" Text='<%# Eval("data_valid", "{0:dd/MM/yyyy}")%>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            Nessuna offerta disponibile
        </EmptyDataTemplate>
    </asp:GridView>--%>
</asp:Content>

