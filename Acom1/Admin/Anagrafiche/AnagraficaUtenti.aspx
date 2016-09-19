<%@ Page Title="Utenti" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaUtenti.aspx.vb" Inherits="Acom1.AnagraficaUtenti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <h3>Anagrafica utenti</h3>
    <asp:Label ID="lblResetPw" runat="server" Text="" Visible="false" CssClass="alert alert-danger" Font-Bold="true"></asp:Label>
    <asp:Label ID="lblError" runat="server" Text="" Visible="false" CssClass="alert alert-danger" Font-Bold="true"></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Id" CaptionAlign="Left" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true" Width="30%" CssClass="table table-hover table-bordered table-responsive">
    <Columns>
        <asp:CommandField ShowSelectButton="True" />
        <asp:BoundField DataField="name" HeaderText="Nome" SortExpression="name" />
        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
        <asp:BoundField DataField="role" HeaderText="Ruolo" SortExpression="role" />
        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" Visible="false"/>
        <asp:CheckBoxField DataField="LockoutEnabled" HeaderText="Bloccato" SortExpression="LockoutEnabled" /> 
    </Columns>
        <RowStyle Wrap="False" />
        <SelectedRowStyle Font-Bold="true" BackColor="Yellow" />
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" SelectCommand="SELECT [name], [Email], [role], [Id], [LockoutEnabled] FROM [AspNetUsers]"></asp:SqlDataSource>
    <br />
    <asp:Button ID="btnDelete" runat="server" Text="Blocca utente selezionato" Width="200px" CssClass="btn btn-primary btn-hover"/>    
    &nbsp;&nbsp;&nbsp;    
    <asp:Button ID="btnActivate" runat="server" Text="Riattiva utente selezionato"  Width="200px" CssClass="btn btn-primary btn-hover" />
    <br />
    <br />
    <p>
    <asp:Button ID="btnResetPw" runat="server" Text="Reset password" OnClick="btnResetPw_Click" Width="200px" CssClass="btn btn-primary btn-hover"/><br />
    </p>
</asp:Content>
