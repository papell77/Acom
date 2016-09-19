<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaRuoli.aspx.vb" Inherits="Acom1.Anagrafiche" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="OtherContent">
    <h3>&nbsp;</h3>
    <h3>Ruoli applicazione</h3>
        <h5>Inserisci nuovo ruolo</h5>      
    <div>
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
        <asp:TextBox runat="server" ID="role" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ErrorMessage="Inserire Ruolo" ControlToValidate="role" runat="server" Display="None" />
        <br />
        <asp:Button runat="server" Text="Salva" OnClick="Insert_Click" CssClass="btn btn-primary btn-hover" />
        <h5><asp:Label runat="server" ID="lblerror" CssClass="text-danger" EnableViewState="false" Visible="false">Il ruolo è già esistente</asp:Label></h5>
        <br />
        <asp:GridView ID="GridView1" runat="server" Width="30%" CssClass="table table-hover table-bordered table-responsive" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"  HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true" >
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Nome ruolo" SortExpression="Name" />
            </Columns>
        </asp:GridView>
     </div>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" SelectCommand="SELECT [Name] FROM [AspNetRoles]" OldValuesParameterFormatString="original_{0}">
    </asp:SqlDataSource>
</asp:Content>

