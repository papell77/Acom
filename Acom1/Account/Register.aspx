<%@ Page Title="Registrazione"  Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.Master" CodeBehind="Register.aspx.vb" Inherits="Acom1.Register" %>

<%@ Import Namespace="Acom1" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="OtherContent">
    <h2><%: Title %>.</h2>
    <asp:PlaceHolder runat="server" Visible="false" ID="errormsg" >
    <p class="alert alert-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
    </asp:PlaceHolder>
    <asp:PlaceHolder runat="server" Visible="false" ID="confirmsg" >
        <p class="alert alert-success">
           <asp:Literal runat="server" ID="ConfirmMessage" />
        </p>
    </asp:PlaceHolder>
    <div class="form-horizontal">
        <h4>Creare un nuovo account</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Textname" CssClass="col-md-2 control-label">Nome</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Textname" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Textname" Display="None" SetFocusOnError="true" ErrorMessage="Il campo Nome è obbligatorio." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Posta elettronica</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" Display="None" SetFocusOnError="true" ErrorMessage="Il campo Posta elettronica è obbligatorio." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" Display="None" SetFocusOnError="true" ErrorMessage="Il campo Password è obbligatorio." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Conferma password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword" Display="None" SetFocusOnError="true" ErrorMessage="Il campo Conferma password è obbligatorio." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="None" SetFocusOnError="true" ErrorMessage="La password e la password di conferma non corrispondono." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Role" CssClass="col-md-2 control-label">Ruolo</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList runat="server" ID="Role" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="SqlDataSource1" DataTextField="Name" Width="29%" >
                    <asp:ListItem Text="" Value=""/>
                </asp:DropDownList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Role" Display="None" SetFocusOnError="true" ErrorMessage="Il campo ruolo è obbligatorio." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" ID="CreateUser" OnClick="CreateUser_Click" Text="Esegui registrazione" CssClass="btn btn-primary btn-hover" CausesValidation="true" />
                <asp:ConfirmButtonExtender runat="server" ConfirmText="Stai per aggiungere un nuovo utente, confermi?" TargetControlID="CreateUser" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" SelectCommand="SELECT [Name] FROM [AspNetRoles]"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
