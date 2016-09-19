<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="HomeDE.aspx.vb" Inherits="Acom1.HomeDE" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h2 style="font-weight:bold">Home</h2>
<%--    <h5>&nbsp;</h5>--%>
        <hr />
    <div>
    <table style="width:50%">
        <tr>
            <td>
                <asp:Button Text="Inserisci nuovo ordine" CssClass="btn btn-primary btn-hover" PostBackUrl="~/User/OrdiniIns.aspx" runat="server" />
            </td>
            <td>
                <asp:Button Text="Inserisci nuovo cliente" CssClass="btn btn-primary btn-hover" PostBackUrl="~/User/ClientiIns.aspx" runat="server" />
            </td>
            <td>
                <asp:Button Text="Inserisci nuova filiale" CssClass="btn btn-primary btn-hover" PostBackUrl="~/User/FilialiIns.aspx" runat="server" />
            </td>
        </tr>
    </table>
        </div>
    <hr />
    <div>
        <h4>
        <asp:Label ID="order_no_prod" Text="" runat="server" Font-Bold="true" CssClass="form-label" />
        </h4>
    </div>
    <div>
        <asp:GridView ID="GridViewOrder" AutoGenerateColumns="false" SelectMethod="GridViewOrder_GetData" CssClass="table table-border table-hover table-responsive"  runat="server">
            <HeaderStyle BackColor="#DCF5FD" Font-Bold="true" />
            <Columns>
            <asp:HyperLinkField Text="Modifica" NavigateUrl="~/User/OrdiniIns.aspx?ID={0}" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/User/OrdiniIns.aspx?ID={0}" ControlStyle-Font-Size="Medium" />
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="order_code" HeaderText="Ordine" />
            <asp:BoundField DataField="order_sap" HeaderText="Ordine SAP" />
            <asp:BoundField DataField="data" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="rif_impianto" HeaderText="Riferimento" />
            <asp:BoundField DataField="rif_ordinecliente" HeaderText="Ordine Cliente" />
        </Columns>
        <EmptyDataRowStyle BorderStyle="None" />
        <EmptyDataTemplate>
            Nessuna ordine incompleto
        </EmptyDataTemplate>
        </asp:GridView>

    </div>
    <hr />
    <h3 style="font-weight:bold">Attività agenti</h3>
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
