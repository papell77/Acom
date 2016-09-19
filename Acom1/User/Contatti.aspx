<%@ Page Title="Contatti" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="Contatti.aspx.vb" Inherits="Acom1.Contatti1" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="OtherContent">
    <h3>Cerca contatti</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
        <p style="padding:10px">
            <asp:Label runat="server" ID="errmsg" Text="" EnableViewState="false"  Visible="false" CssClass="alert alert-danger"></asp:Label>
            <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
        </p>
        <asp:Table ID="TableFindContact" runat="server" >
        <asp:TableRow ID="cognome" runat="server" >
            <asp:TableCell ID="lblcognome" runat="server" CssClass="form-label" style="text-align:right">Cognome</asp:TableCell>
            <asp:TableCell ID="txtcognome" runat="server">
                <asp:TextBox ID="textcognome" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell ID="lblfunzione" runat="server" CssClass="form-label" style="text-align:right">Funzione</asp:TableCell>
            <asp:TableCell ID="txtfunzione" runat="server">
                <asp:TextBox ID="textfunzione" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="filiale" runat="server" >
            <asp:TableCell ID="lblcliente" runat="server" CssClass="form-label" style="text-align:right">Cliente</asp:TableCell>
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
        <asp:TableRow ID="telefono" runat="server" >
            <asp:TableCell ID="lbltelefono" runat="server" CssClass="form-label" style="text-align:right">Telefono</asp:TableCell>
            <asp:TableCell ID="txttelefono" runat="server">
                <asp:TextBox ID="texttelefono" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell ID="lblcellulare" runat="server" CssClass="form-label" style="text-align:right">Cellulare</asp:TableCell>
            <asp:TableCell ID="txtcellulare" runat="server">
                <asp:TextBox ID="textcellulare" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="cellulare" runat="server" >
        </asp:TableRow>
        <asp:TableRow ID="email" runat="server" >
            <asp:TableCell ID="lblemail" runat="server" CssClass="form-label" style="text-align:right">Email</asp:TableCell>
            <asp:TableCell ID="txtemail" runat="server">
                <asp:TextBox ID="textemail" runat="server" CssClass="form-control"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Button ID="btnCercaContatto" runat="server" Text="Cerca Contatto" CssClass="btn btn-primary btn-hover" OnClick="btnCercaContatto_Click" />
    <br />
    <br />
    <asp:GridView ID="GridViewContact" runat="server" DataKeyNames="ID" AutoGenerateColumns="false" SelectMethod="GridViewContact_GetData" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true" >
        <Columns>
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="ragione_sociale" Headertext="Cliente" />
            <asp:BoundField DataField="office_name" HeaderText="Filiale" />
            <asp:BoundField DataField="nome" HeaderText="Nome" />
            <asp:BoundField DataField="cognome" HeaderText="Cognome" />
            <asp:BoundField DataField="telefono" HeaderText="Telefono" />
            <asp:BoundField DataField="cellulare" HeaderText="Cellulare" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="funzione" HeaderText="Funzione" />
            <asp:BoundField DataField="note" HeaderText="Note" />
            <asp:CheckBoxField DataField="annull" HeaderText="Disattivato" />
            <asp:BoundField DataField="created_by" HeaderText="Creato da" Visible="false" />
            <asp:BoundField DataField="created_date" HeaderText="Data inserimento" Visible="false"/>
            <asp:BoundField DataField="updated_by" HeaderText="Aggiornato da" Visible="false"/>
            <asp:BoundField DataField="updated_date" HeaderText="Data aggiornamento" Visible="false"/>
          </Columns>
        </asp:GridView>
            
</asp:Content>


