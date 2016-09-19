<%@ Page Title="Visite" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="Visite.aspx.vb" Inherits="Acom1.Visite1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="OtherContent">
    <h3>Cerca evento</h3>
    <h5>I campi contrassegnati con * sono obbligatori</h5>
    <p style="padding:10px">
        <asp:Label Text="" ID="errmsg" runat="server" Visible="false" EnableViewState="false" />
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
    </p>
        <asp:Table ID="TableFindVisit" runat="server">
        <asp:TableRow ID="datadal" runat="server" >
            <asp:TableCell ID="lbldatadal" runat="server" CssClass="form-label" style="text-align:right">Data dal *</asp:TableCell>
            <asp:TableCell ID="txtdatadal" runat="server">
                <asp:TextBox ID="textdatadal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender ID="calextdatadal" runat="server" TargetControlID="textdatadal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator ID="RequiredDataDal" runat="server" Display="None" ControlToValidate="textdatadal" ErrorMessage="Inserire data inizio ricerca" ></asp:RequiredFieldValidator>
            </asp:TableCell>
            <asp:TableCell ID="lbldataal" runat="server" CssClass="form-label" style="text-align:right">Data al *</asp:TableCell>
            <asp:TableCell ID="txtdataal" runat="server">
                <asp:TextBox ID="textdataal" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:CalendarExtender runat="server" ID="calextDataal" TargetControlID="textdataal" Format="dd/MM/yyyy" />
                <asp:RequiredFieldValidator ID="RequiredDataAl" runat="server" Display="None" ControlToValidate="textdataal" ErrorMessage="Inserire data fine ricerca" ></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="dataal" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="prov" runat="server" >
            <asp:TableCell ID="lblagent" runat="server" CssClass="form-label" style="text-align:right">Agente</asp:TableCell>
            <asp:TableCell ID="txtDDLagent" runat="server">
                <asp:DropDownList ID="DDLagent" runat="server" SelectMethod="Get_agent" DataValueField="ID" DataTextField="name" AppendDataBoundItems="true" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell ID="lblcliente" runat="server" CssClass="form-label" style="text-align:right">Cliente</asp:TableCell>
            <asp:TableCell ID="txtDDLcliente" runat="server">
                <asp:DropDownList ID="DDLcliente" runat="server" SelectMethod="Get_client" DataValueField="ID" DataTextField="ragione_sociale" AppendDataBoundItems="true" CssClass="form-control">
                     <asp:ListItem Selected="True" Value="" Text=""></asp:ListItem>
                </asp:DropDownList> 
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="cliente" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="motivo" runat="server" >
            <asp:TableCell ID="lblmotivo" runat="server" CssClass="form-label" style="text-align:right">Descrizione evento</asp:TableCell>
            <asp:TableCell ID="txtmotivo" runat="server">
                <asp:TextBox ID="textmotivo" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <%-- <asp:TableRow ID="preventivo" runat="server" >
            <asp:TableCell ID="lblpreventivo" runat="server">Preventivo</asp:TableCell>
            <asp:TableCell ID="txtDDLpreventivo" runat="server">
                <asp:DropDownList ID="DDLpreventivo" runat="server" SelectMethod="Get_offer" DataValueField="offer_num" DataTextField="offer_num" AppendDataBoundItems="true" Width="150px">
                     <asp:ListItem Selected="True" Value="" Text="">
                     </asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="ordine" runat="server" >
            <asp:TableCell ID="lblordine" runat="server">Ordine</asp:TableCell>
            <asp:TableCell ID="txtDDLordine" runat="server">
                <asp:DropDownList ID="DDLordine" runat="server" SelectMethod="Get_order" DataValueField="offer_num" DataTextField="order_num" AppendDataBoundItems="true" Width="150px">
                     <asp:ListItem Selected="True" Value="" Text="">
                     </asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>--%>
    </asp:Table>
    <br />
    <asp:Button ID="btnCercaVisita" runat="server" Text="Cerca evento" CssClass="btn btn-primary btn-hover" />
    <br />
    <br />
    <asp:GridView ID="GridViewVisit"  DataKeyNames="ID" runat="server" SelectMethod="GridViewVisit_GetData" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true">
        <Columns>
            <asp:HyperLinkField Text="Modifica" NavigateUrl="~/User/VisiteIns.aspx" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/User/VisiteIns.aspx?ID={0}" />
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="data" HeaderText="Data evento" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="name" HeaderText="Agente" />
            <asp:BoundField DataField="ragione_sociale" HeaderText="Cliente" />
            <asp:BoundField DataField="nome" HeaderText="Filiale" />
            <asp:BoundField DataField="motivo_desc" HeaderText="Motivo" />
            <%--<asp:BoundField DataField="ordine_num" HeaderText="Rif. Ordine" />--%>
            <asp:BoundField DataField="preventivo_num" HeaderText="Rif. Offerta" />
            <asp:BoundField DataField="data_prossima" HeaderText="Data prossimo evento" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="stato" HeaderText="Stato" />
        </Columns>
    </asp:GridView>
</asp:Content>

