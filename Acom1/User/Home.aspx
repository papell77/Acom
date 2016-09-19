<%@ Page Title="Home" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="Home.aspx.vb" Inherits="Acom1.Home1" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="OtherContent">
    <h2 style="font-weight:bold">
    Dashboard Agente
    <asp:DropDownList ID="DropDownAgent" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceAgent" DataTextField="name" DataValueField="ID" AppendDataBoundItems="true" CssClass="dropdown-toggle">
        <asp:ListItem Value="" Text="Seleziona agente" Selected="True"></asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceAgent" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" SelectCommand="SELECT [ID], [name], [annull] FROM [agents] WHERE [annull]=0 "></asp:SqlDataSource>
    </h2>
    <hr />
    <table style="width:50%">
        <tr>
            <td>
                <asp:Button Text="Nuovo Evento" CssClass="btn btn-primary btn-hover" PostBackUrl="~/User/VisiteIns.aspx" runat="server" />
            </td>
            <td>
                <asp:Button Text="Nuova Offerta" CssClass="btn btn-primary btn-hover" PostBackUrl="~/User/OfferteIns.aspx" runat="server" />
            </td>
            <td>
                <asp:Button Text="Nuovo Cliente" CssClass="btn btn-primary btn-hover" PostBackUrl="~/User/ClientiIns.aspx" runat="server" />
            </td>
            <td>
                <asp:Button Text="Nuova Filiale" CssClass="btn btn-primary btn-hover" PostBackUrl="~/User/FilialiIns.aspx" runat="server" />
            </td>
        </tr>
    </table>
    <hr />
    <table style="width:100%">
        <tr>    
            <td style="width:50%; vertical-align:top; padding-right:10px">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:label runat="server" ID="lblvisite1" Font-Bold="true" Font-Size="Medium">Eventi scaduti e in programma nei prossimi</asp:label>
    <asp:DropDownList ID="DropDownGGVisite" runat="server" AutoPostBack="True" Font-Size="Medium">
        <asp:ListItem Selected="True">7</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
        <asp:ListItem>30</asp:ListItem>
    </asp:DropDownList>
&nbsp;<asp:label runat="server" ID="lblvisite2" Font-Bold="true" Font-Size="Medium">giorni</asp:label><br />
    <br />
    <asp:GridView ID="GridVisite" runat="server" SelectMethod="GridVisite_GetData" AutoGenerateColumns="False" DataKeyNames="ID" OnDataBound="GridVisite_DataBound" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true">
        <Columns>
            <asp:HyperLinkField Text="Modifica" NavigateUrl="~/User/VisiteIns.aspx?ID={0}" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/User/VisiteIns.aspx?ID={0}" ControlStyle-Font-Size="Medium"/>
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:TemplateField HeaderText="Data evento" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="data" Text='<%# Eval("data", "{0:dd/MM/yyyy HH:mm}")%>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="motivo_desc" HeaderText="Descrizione" />
            <asp:BoundField DataField="preventivo_num" HeaderText="Num. Offerta" />
            <%-- <asp:BoundField DataField="ordine_num" HeaderText="Rif. Ordine" />
            <asp:BoundField DataField="data_prossima" HeaderText="Data prossimo evento" DataFormatString="{0:dd/MM/yyyy}"/> --%>
            </Columns>
        <EmptyDataTemplate>
            Nessun evento disponibile
        </EmptyDataTemplate>
        </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
            </td>
            <td style="width:50%; vertical-align:top; padding-left:10px">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:Label runat="server" ID="lblprev1" Font-Bold="true" Font-Size="Medium">Offerte in scadenza nei prossimi </asp:Label> &nbsp;
    <asp:DropDownList ID="DropDownGGPreventivi" runat="server" AutoPostBack="true" Font-Size="Medium">
        <asp:ListItem Selected="True">7</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
        <asp:ListItem>30</asp:ListItem>
    </asp:DropDownList>
&nbsp;<asp:Label runat="server" ID="lblprev2" Font-Bold="true" Font-Size="Medium">giorni</asp:Label>
    <br />
    <br />
    <asp:GridView ID="GridPreventivi" AutoGenerateColumns="false" runat="server" SelectMethod="GridPreventivi_GetData" OnDataBound="GridPreventivi_DataBound" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true">
        <Columns>
            <asp:HyperLinkField Text="Modifica" NavigateUrl="~/User/OfferteIns.aspx?ID={0}" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/User/OfferteIns.aspx?ID={0}" ControlStyle-Font-Size="Medium" />
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="offer_code" HeaderText="Offerta" />
<%--            <asp:BoundField DataField="offer_est" HeaderText="Offerta esterna" />--%>
            <asp:BoundField DataField="data" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="riferimento" HeaderText="Riferimento" />
<%--            <asp:BoundField DataField="cognome" HeaderText="Contatto cliente" />--%>
            <asp:TemplateField HeaderText="Scadenza" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="dataval" Text='<%# Eval("data_valid", "{0:dd/MM/yyyy}")%>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataRowStyle BorderStyle="None" />
        <EmptyDataTemplate>
            Nessuna offerta disponibile
        </EmptyDataTemplate>
    </asp:GridView>
            </ContentTemplate>
    </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <br />
    <hr />
    <h3>Attività altri agenti</h3>
    <asp:GridView runat="server" ID="Grid_OtherAgents" SelectMethod="Grid_OtherAgents_GetData" OnDataBound="Grid_OtherAgents_DataBound" DataKeyNames="ID" AutoGenerateColumns="false" Width="100%" CellPadding="20" GridLines="Horizontal" BorderStyle="None" >
        <Columns>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="agent_username" Text='<%# Eval("username")%>' runat="server" ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="ID" Text='<%# Eval("ID")%>' runat="server"/></ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="X-Large" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top" />
            <asp:TemplateField HeaderText="E' in contatto con..." HeaderStyle-Font-Size="Large" ItemStyle-VerticalAlign="top">
                <ItemTemplate>
                    <asp:GridView runat="server" ID="GridOtherAgentVisit" AutoGenerateColumns="false" CssClass="table table-border table-responsive">
                        <HeaderStyle Font-Bold="true" BackColor="#DCF5FD" />
                        <Columns>
                            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
                            <asp:BoundField DataField="nome" HeaderText="Filiale" />
                        </Columns>
                        <EmptyDataRowStyle BorderStyle="None" />
                        <EmptyDataTemplate>
                            Nessun evento in corso
                        </EmptyDataTemplate>
                    </asp:GridView>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Ha offerte in attesa con..." HeaderStyle-Font-Size="Large" ItemStyle-VerticalAlign="top">
                <ItemTemplate>
                     <asp:GridView runat="server" ID="GridOtherAgentOffer" AutoGenerateColumns="false" CssClass="table table-border table-responsive">
                        <HeaderStyle Font-Bold="true" BackColor="#DCF5FD" />
                        <Columns>
                            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
                            <asp:BoundField DataField="nome" HeaderText="Filiale" />
                        </Columns>
                        <EmptyDataRowStyle BorderStyle="None" />
                        <EmptyDataTemplate>
                            Nessuna offerta in attesa
                        </EmptyDataTemplate>
                     </asp:GridView>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

