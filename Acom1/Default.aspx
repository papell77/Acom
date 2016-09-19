<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="Acom1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>A.CO.M. SRL</h1>
        <br />
        <p><a class="btn btn-primary btn-hover" style="font-size:x-large" runat="server" href="~/Account/Login">Accedi... &raquo;</a></p>
       <%-- <p class="lead">Agenzia Daikin e Rotex</p>--%>
        <%-- <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>--%>
    </div>

    <%--<div class="row">
        <div class="col-md-4">
            <p>
                <a class="btn btn-default" runat="server" href="~/Account/Login">Accedi... &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Informazioni</h2>
            <p> </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Contatti</h2>
            <p>
                Per maggiori informazioni
            </p>
            <p>
                <a class="btn btn-default" runat="server" href="~/">Accedi &raquo;</a>
            </p>
        </div>
    </div>--%>

</asp:Content>
