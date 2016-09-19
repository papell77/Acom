<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="ReportCliente.aspx.vb" Inherits="Acom1.ReportCliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>Report totale prodotti ordinati</h3>
    <h5>I campi contrassegnati con * sono obbligatori</h5>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <p style="padding:10px">
        <asp:Label runat="server" ID="errmsg" CssClass="alert alert-danger" Text="" Visible="false" EnableViewState="false"></asp:Label>
     <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ID="vald_summary" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />    
    </p>
    <asp:Table ID="TableFindOrder" runat="server" >
        <asp:TableRow ID="datadal" runat="server" >
            <asp:TableCell ID="lbldatadal" runat="server" CssClass="form-label" style="text-align:right">Data dal *</asp:TableCell>
            <asp:TableCell ID="txtdatadal" runat="server">
                <asp:TextBox ID="textdatadal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender ID="calextdatadal" runat="server" TargetControlID="textdatadal" Format="dd/MM/yyyy"  />
                <asp:RequiredFieldValidator ID="required_datain" ErrorMessage="Inserire data inizio ricerca" ControlToValidate="textdatadal" Display="none" runat="server" CssClass="text-danger" ></asp:RequiredFieldValidator>
            </asp:TableCell>
            <asp:TableCell ID="lbldataal" runat="server" CssClass="form-label" style="text-align:right">Data al *</asp:TableCell>
            <asp:TableCell ID="txtdataal" runat="server">
                <asp:TextBox ID="textdataal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender runat="server" ID="calextDataal" TargetControlID="textdataal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator ID="required_dataout" ErrorMessage="Inserire data fine ricerca" ControlToValidate="textdataal" Display="none" runat="server" CssClass="text-danger" ></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="dataal" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="agent" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="cliente" runat="server" >
            <asp:TableCell ID="lblcliente" runat="server" CssClass="form-label" style="text-align:right">Cliente</asp:TableCell>
            <asp:TableCell ID="txtDDLcliente" runat="server">
                <asp:DropDownList ID="clienteID" runat="server" SelectMethod="Get_clients" OnSelectedIndexChanged="clienteID_SelectedIndexChanged" DataValueField="ID" DataTextField="ragione_sociale" AutoPostBack="true" AppendDataBoundItems="true" CssClass="form-control">
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
        <asp:TableRow ID="canale" runat="server" >
            <asp:TableCell ID="lblagent" runat="server" CssClass="form-label" style="text-align:right">Agente</asp:TableCell>
            <asp:TableCell ID="txtDDLagent" runat="server">
                <asp:DropDownList ID="DDLagent" runat="server" SelectMethod="Get_agents" DataValueField="ID" DataTextField="name" AppendDataBoundItems="true" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblcanale" runat="server" CssClass="form-label" style="text-align:right">Canale</asp:TableCell>
            <asp:TableCell ID="txtDDLcanale" runat="server">
                <asp:DropDownList ID="canalID" runat="server" SelectMethod="Get_canal" DataValueField="ID" DataTextField="canal_code" AutoPostBack="true" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList> 
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ID="lblfamily" runat="server" CssClass="form-label" style="text-align:right">Famiglia</asp:TableCell>
            <asp:TableCell ID="txtDDLfamily" runat="server">
                <asp:DropDownList ID="familyID" runat="server" SelectMethod="Get_families" DataValueField="ID" DataTextField="family_name" AutoPostBack="true" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList> 
            </asp:TableCell>
        </asp:TableRow>
</asp:Table>
        <br />
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:Button ID="btnCerca" runat="server" CssClass="btn btn-primary btn-hover" Text="Visualizza report" OnClick="btnCerca_Click" />
    <br />
    <br />

    <p style="padding-bottom:10px; padding-top:10px">
    <asp:Label ID="prodotti_assenti" Text="" CssClass="alert alert-danger" visible="false" runat="server" EnableViewState="false"></asp:Label>
    </p>
        <asp:GridView ID="GridViewProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-responsive" Width="30%">
        <HeaderStyle Wrap="False" BackColor ="#DCF5FD" Font-Bold="true" />
            <Columns>
            <asp:BoundField DataField="family" HeaderText="Famiglia" />
            <asp:BoundField DataField="prodotto" HeaderText="Prodotto" />
            <asp:BoundField DataField="somma_prodotti" HeaderText="Somma prodotti" />
        </Columns>
    </asp:GridView>

</asp:Content>
