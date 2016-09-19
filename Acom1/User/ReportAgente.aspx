<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="ReportAgente.aspx.vb" Inherits="Acom1.ReportAgente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>Reportistica eventi e offerte</h3>
    
    <h5>I campi contrassegnati con * sono obbligatori</h5>  
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
<div>
    <p style="padding:10px">
        <asp:Label runat="server" ID="errmsg" Text="" EnableViewState="false" CssClass="alert alert-danger" Visible="false"></asp:Label>
        <asp:ValidationSummary ID="val_summ" runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
    </p>
    <asp:Table ID="TableFindOffer" runat="server">
        <asp:TableRow ID="datadal" runat="server" >
            <asp:TableCell ID="lbldatadal" runat="server" CssClass="form-label" style="text-align:right">Data dal *</asp:TableCell>
            <asp:TableCell ID="txtdatadal" runat="server">
                <asp:TextBox ID="textdatadal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender ID="calextdatadal" runat="server" TargetControlID="textdatadal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator ID="RequiredDateFrom" ControlToValidate="textdatadal" ErrorMessage="Inserire data inizio" runat="server" Display="none"></asp:RequiredFieldValidator>
            </asp:TableCell>
            <asp:TableCell ID="lbldataal" runat="server" CssClass="form-label" style="text-align:right">Data al *</asp:TableCell>
            <asp:TableCell ID="txtdataal" runat="server">
                <asp:TextBox ID="textdataal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender runat="server" ID="calextDataal" TargetControlID="textdataal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator ID="RequiredDataTo" ControlToValidate="textdataal" ErrorMessage="Inserire data fine" runat="server" Display="none"></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="cliente" runat="server" >
            <asp:TableCell ID="lblcliente" runat="server" CssClass="form-label" style="text-align:right">Cliente</asp:TableCell>
            <asp:TableCell ID="txtDDLcliente" runat="server">
                <asp:DropDownList ID="clienteID" runat="server" AutoPostBack="true" SelectMethod="Get_clients" DataValueField="ID" DataTextField="ragione_sociale" AppendDataBoundItems="true" CssClass="form-control" OnSelectedIndexChanged="clienteID_SelectedIndexChanged">
                     <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList> 
            </asp:TableCell>
            <asp:TableCell ID="lblfiliale" runat="server" CssClass="form-label" style="text-align:right">Filiale</asp:TableCell>
            <asp:TableCell ID="txtDDLfiliale" runat="server">
                <asp:DropDownList ID="officeID" runat="server" CssClass="form-control" >
                </asp:DropDownList> 
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="filiale" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="family" runat="server" >
            <asp:TableCell ID="TableCell1" runat="server" CssClass="form-label" style="text-align:right">Agente</asp:TableCell>
            <asp:TableCell ID="TableCell2" runat="server">
                <asp:DropDownList ID="DDLagent" runat="server" SelectMethod="Get_agents" DataValueField="ID" DataTextField="name" AppendDataBoundItems="true" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblfamily" runat="server" CssClass="form-label" style="text-align:right">Famiglia</asp:TableCell>
            <asp:TableCell ID="txtDDLfamily" runat="server">
                <asp:DropDownList ID="DDLfamily" runat="server" SelectMethod="Get_families" DataValueField="ID" DataTextField="family_name" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text="">
                     </asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>

        </asp:TableRow>

</asp:Table>
</div>
        </ContentTemplate>
    </asp:UpdatePanel>  
    <br />
    <asp:Button ID="btnCerca" CssClass="btn btn-primary btn-hover" runat="server" Text="Visualizza report" OnClick="btnCerca_Click" />
    <br />
    <br />
    
<asp:UpdatePanel ID="update_report" Visible="false" EnableViewState="false" runat="server">
    <ContentTemplate>

<h4>Eventi</h4>
    <asp:GridView runat="server" ID="GridViewVisit" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-responsive" Width="50%"  >
        <HeaderStyle Wrap="False" BackColor ="#DCF5FD" Font-Bold="true" />
        <Columns>
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="filiale" />
            <asp:BoundField DataField="name" headertext="Agente"/>
            <asp:BoundField DataField="totoff" HeaderText="Totale eventi" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="prevSi" HeaderText="Campo offerta" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="perc" DataFormatString="{0:P0}" ItemStyle-HorizontalAlign="Right"  HeaderText="Offerte %" />
        </Columns>

    </asp:GridView>
    <br />
    <br />
<h4>Offerte lavorate</h4>
    <asp:GridView runat="server" ID="GridViewOffer" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-responsive" Width="70%" >
        <HeaderStyle Wrap="False" BackColor ="#DCF5FD" Font-Bold="true" />
        <Columns>
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="agentname" HeaderText="Agente" />
            <%-- <asp:BoundField DataField="family_name" HeaderText="Famiglia" />--%>
            <asp:BoundField DataField="totoff" HeaderText="Totale offerte" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="pending" HeaderText="In Attesa" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="won" HeaderText="Vinte" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="lost" HeaderText="Perse" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="updated" HeaderText="Aggiornate" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Right" />
        </Columns>
    </asp:GridView>

    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
