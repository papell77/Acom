<%@ Page Title="Password cambiata" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPasswordConfirmation.aspx.vb" Inherits="Acom1.ResetPasswordConfirmation" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>
    <div>
        <p>La password è stata cambiata. Fare clic <asp:HyperLink ID="login" runat="server" NavigateUrl="~/Account/Login">qui</asp:HyperLink> per accedere </p>
    </div>
</asp:Content>
