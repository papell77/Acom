<%@ Page Title="Listino" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="ListinoIns.aspx.vb" Inherits="Acom1.ListinoIns" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>Inserisci nuova voce di listino</h3>
    <h5>Le voci contrassegnate con * sono obbligatorie</h5>
    <asp:Label runat="server" ID="error_msg" Text="" CssClass="alert alert-danger" Visible="false" EnableViewState="false"></asp:Label>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_row" />
    <asp:DetailsView ID="DetailsViewPrice" ItemType="Acom1.Models.pricelist" DataKeyNames="article_code, data_decorrenza" AutoGenerateRows="false" runat="server"  DefaultMode="Insert" InsertMethod="DetailsViewPrice_InsertItem" SelectMethod="DetailsViewPrice_GetItem" FieldHeaderStyle-Wrap="False" InsertRowStyle-Wrap="False" GridLines="None">
        <Fields>
            <asp:TemplateField HeaderText="Codice articolo *" HeaderStyle-Font-Bold="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="article_code" Text='<%# Eval("article_code")%>'></asp:Label>
                </ItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="article_code" CssClass="form-control" Text='<%# Bind("article_code")%>'></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rqrdcode" ControlToValidate="article_code" ErrorMessage="Inserire codice articolo" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Descrizione articolo *" HeaderStyle-Font-Bold="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="article_desc" Text='<%# Eval("article_desc")%>'></asp:Label>
                </ItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="article_desc" CssClass="form-control" Text='<%# Bind("article_desc")%>'></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="article_desc" ErrorMessage="Inserire descrizione articolo" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Prezzo" HeaderStyle-Font-Bold="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="prezzo" Font-Bold="true" Text='<%# Eval("prezzo", "{0:C}")%>'></asp:Label>
                </ItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" CssClass="form-control" ID="prezzo" Text='<%# Bind("prezzo")%>'></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Data decorrenza *" HeaderStyle-Font-Bold="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="data_decorrenza" Text='<%# Eval("data_decorrenza", "{0:dd/MM/yyyy}")%>'></asp:Label>
                </ItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" CssClass="form-control" ID="data_decorrenza" Text='<%# Bind("data_decorrenza", "{0:dd/MM/yyyy}")%>'></asp:TextBox>
                    <asp:CalendarExtender Format="dd/MM/yyyy" ClearTime="true" TargetControlID="data_decorrenza" runat="server" ID="calext_datadecorrenza" OnLoad="calext_datadecorrenza_Load" />                
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="data_decorrenza" Display="None" ErrorMessage="Inserire data di decorrenza" SetFocusOnError="true"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Prodotto" HeaderStyle-Font-Bold="true">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="productID" CssClass="form-control" SelectMethod="Get_products" DataValueField="ID" DataTextField="product_name" selectedvalue='<%# Eval("productID")%>' Enabled="false" AppendDataBoundItems="true">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList runat="server" ID="productID" CssClass="form-control" SelectMethod="Get_products" DataValueField="ID" DataTextField="product_name" AppendDataBoundItems="true">
                        <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Famiglia" HeaderStyle-Font-Bold="true">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="familyID" CssClass="form-control" SelectMethod="Get_families" DataValueField="ID" DataTextField="family_name" selectedvalue='<%# Eval("familyID")%>' Enabled="false" AppendDataBoundItems="true">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList runat="server" ID="familyID" CssClass="form-control" SelectMethod="Get_families" DataValueField="ID" DataTextField="family_name" AppendDataBoundItems="true">
                        <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowInsertButton="true" ShowCancelButton="true" ControlStyle-CssClass="btn btn-primary btn-hover" ValidationGroup="insert_row" />
        </Fields>
    </asp:DetailsView>
    <br />
    <hr />
    <h3>Importa file listino</h3>
    <asp:ValidationSummary ID="ValidateUpload" runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_bulk" />
    <br />
    <asp:PlaceHolder runat="server" ID="upload_place_success" Visible="false" EnableViewState="false" >
        <asp:Label Text="Importazione completata con successo" ID="upload_success" CssClass="alert alert-success" runat="server" />
        <br />
        <br />
    </asp:PlaceHolder>
    <asp:PlaceHolder runat="server" ID="upload_place_error" Visible="false" EnableViewState="false" >
    <asp:Label Text="" ID="upload_error" CssClass="alert alert-danger" runat="server" style="text-wrap:normal" />
    <br />
    <br />
    <asp:Label Text="" ID="exc_detail" CssClass="alert alert-danger" EnableViewState="false" runat="server" style="text-wrap:normal"></asp:Label>
    <br />
    <br />
    </asp:PlaceHolder>
    <asp:PlaceHolder runat="server" ID="double_place" EnableViewState="false" >
            <asp:GridView runat="server" AutoGenerateColumns="true" ID="GridDouble" ShowHeader="false" CssClass="table table-bordered" Width="30%">
            </asp:GridView>
    </asp:PlaceHolder>
    <p>
            <asp:FileUpload runat="server" ID="upload_excel" Width="300px" Height="36px" CssClass="form-control" Style="left:inherit; position:inherit; " />
            <asp:RequiredFieldValidator ErrorMessage="Inserire un file da importare" ControlToValidate="upload_excel" Display="None" runat="server" ValidationGroup="insert_bulk" />
        <br />
            <asp:Label Text="Data decorrenza *" AssociatedControlID="decorrenza" runat="server" />
            <asp:TextBox runat="server" ID="decorrenza" CssClass="form-control" />
            <asp:CalendarExtender  runat="server" TargetControlID="decorrenza" Format="dd/MM/yyyy" PopupPosition="Right" />
            <asp:RequiredFieldValidator ErrorMessage="Inserire data di decorrenza" ControlToValidate="decorrenza" Display="None" runat="server" ValidationGroup="insert_bulk" />
        <br /> 
            <asp:Button Text="Importa file" ID="btn_import" CssClass="btn btn-primary btn-hover" OnClick="btn_import_Click" runat="server" CausesValidation="true" ValidationGroup="insert_bulk" />
        <br />
        <br />
    </p>
<%--        
        <asp:UpdateProgress runat="server">
                <ProgressTemplate>
                    <asp:Label Text="Importazione in corso" runat="server" />
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
            <p>
            </p>
            
</asp:Content>
