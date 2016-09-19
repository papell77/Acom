<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="TestAjax.aspx.vb" Inherits="Acom1.TestAjax" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="OtherContent" runat="server">
            <asp:TextBox runat="server" ID="articleDesc"></asp:TextBox>
            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="articleDesc" ServiceMethod="AutoCompleteArticle" ServicePath="~/ajaxservice.svc" EnableCaching="false" FirstRowSelected="false" MinimumPrefixLength="2" CompletionSetCount="10" CompletionInterval="100"></cc1:AutoCompleteExtender>
            <asp:Label runat="server">prova</asp:Label>
</asp:Content>
