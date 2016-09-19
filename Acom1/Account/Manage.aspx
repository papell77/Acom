<%@ Page Title="Gestisci account" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.Master" CodeBehind="Manage.aspx.vb" Inherits="Acom1.Manage" %>

<%@ Import Namespace="Acom1" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="OtherContent" runat="server">
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="SuccessMessagePlaceHolder" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Cambiare le impostazioni dell'account <%# User.Identity.Name%></h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Password:</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Cambia]" Visible="false" ID="ChangePassword" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Crea]" Visible="false" ID="CreatePassword" runat="server" />
                    </dd>
                    <%-- <dt>Account di accesso esterni:</dt>
                    <dd><%:LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Gestisci]" runat="server" />

                    </dd>--%>
                    <%--
                        I numeri di telefono possono essere usati come secondo fattore di verifica in un sistema di autenticazione a due fattori.
                        Vedere <a href="http://go.microsoft.com/fwlink/?LinkId=403804">questo articolo</a>
                        per informazioni su come configurare l'applicazione ASP.NET per il supporto dell'autenticazione a due fattori tramite SMS.
                        Rimuovere i commenti dal blocco seguente dopo aver configurato l'autenticazione a due fattori
                    --%>
                    <%--
                    <dt>Numero di telefono:</dt>
                     --%>
                    <% If HasPhoneNumber Then %>
                    <%--
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Aggiungi]" />
                    </dd>
                    --%>
                    <% Else %>
                    <%--
                    <dd>
                    
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Cambia]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Rimuovi]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    --%>
                    <% End If %>
                    <%-- <dt>Autenticazione a due fattori:</dt>
                    <dd>
                        <p>
                            Non sono configurati provider di autenticazione a due fattori. Vedere <a href="http://go.microsoft.com/fwlink/?LinkId=403804">questo articolo</a>
                            per informazioni su come configurare l'applicazione ASP.NET per il supporto dell'autenticazione a due fattori.
                        </p>--%>                
                        <% If TwoFactorEnabled Then %>
                        <%--
                        Abilitata
                        <asp:LinkButton Text="[Disabilita]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />
                        --%>
                        <% Else %>
                       	<%--
                       	Disabilitata
                        <asp:LinkButton Text="[Abilita]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
                        --%>
                        <% End If %>
                    <%-- </dd> --%>  
                </dl>
            </div>
        </div>
    </div>
</asp:Content>

