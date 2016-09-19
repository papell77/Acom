<%@ Page Title="Listino" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="Listino.aspx.vb" Inherits="Acom1.Listino" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>Listino prezzi</h3>
    
    <asp:Table runat="server" ID="TableSearchProduct" Width="30%">
        <asp:TableRow>
            <asp:TableCell runat="server" ID="lblarticolo" Font-Bold="true">Codice articolo</asp:TableCell>
            <asp:TableCell runat="server" ID="txtarticolo">
                    <asp:TextBox runat="server" CssClass="form-control" ID="textarticolo" Wrap="false"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell runat="server" ID="lblarticolo_desc" Font-Bold="true">Descrizione articolo</asp:TableCell>
            <asp:TableCell runat="server" ID="txtarticolo_desc">
                    <asp:TextBox runat="server" ID="textarticolo_desc" CssClass="form-control" Wrap="true"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell runat="server" ID="lblprodotto" Font-Bold="true">Prodotto</asp:TableCell>
            <asp:TableCell runat="server" ID="prodottoID">
                <asp:DropDownList runat="server" ID="DDLprod" CssClass="form-control" SelectMethod="Get_products" AutoPostBack="false" AppendDataBoundItems="true" DataValueField="ID" DataTextField="product_name">
                    <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell runat="server" ID="lblfamiglia" Font-Bold="true">Famiglia</asp:TableCell>
            <asp:TableCell runat="server" ID="famigliaID">
                <asp:DropDownList runat="server" ID="DDLfam" CssClass="form-control" SelectMethod="Get_families" AutoPostBack="false" AppendDataBoundItems="true" DataValueField="ID" DataTextField="family_name">
                    <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell runat="server" ID="lbldata" Font-Bold="true">Data decorrenza</asp:TableCell>
            <asp:TableCell runat="server" ID="txtdata">
                    <asp:TextBox runat="server" ID="data" CssClass="form-control"></asp:TextBox><br />
                    <asp:CalendarExtender Format="dd/MM/yyyy" TargetControlID="data" runat="server" ID="calext_datadecorrenza" OnLoad="calext_datadecorrenza_Load" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <br />
    <asp:Button runat="server" ID="btncerca" Text="Cerca articolo" OnClick="btncerca_Click" CssClass="btn btn-primary btn-hover" />
    <br />
    <br />
    <asp:GridView  runat="server" ID="GridViewPrice" AutoGenerateEditButton="true" AutoGenerateColumns="false" AllowPaging="true" DataKeyNames="article_code, data_decorrenza" SelectMethod="GridViewPrice_GetData" UpdateMethod="GridViewPrice_UpdateItem" PageSize="30" CssClass="table table-hover table-bordered table-responsive" HeaderStyle-BackColor="#DCF5FD" HeaderStyle-Font-Bold="true" >
        <Columns>
            <asp:TemplateField HeaderText="Codice Articolo">
                <ItemTemplate>
                    <asp:Label runat="server" ID="article_code" Text='<%# Eval("article_code")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Descrizione" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="article_desc" Text='<%# Eval("article_desc")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="article_desc" Text='<%# Bind("article_desc")%>' TextMode="MultiLine"></asp:TextBox>
                </EditItemTemplate>

<ItemStyle Wrap="False"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Prezzo" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="prezzo" Text='<%# Eval("prezzo", "{0:C}")%>' ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="prezzo" Text='<%# Bind("prezzo")%>'></asp:TextBox>
                </EditItemTemplate>

<ItemStyle Wrap="False"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Data decorrenza">
                <ItemTemplate>
                    <asp:Label runat="server" ID="data_decorrenza" Text='<%# Eval("data_decorrenza", "{0:dd/MM/yyyy}")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="data_decorrenza" Text='<%# Bind("data_decorrenza", "{0:dd/MM/yyyy}")%>'></asp:TextBox><br />
                    <asp:CalendarExtender Format="dd/MM/yyyy" TargetControlID="data_decorrenza" runat="server" ID="calext_datadecorrenza" />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Prodotto">
                <ItemTemplate>
                    <asp:Label ID="productID" runat="server" Text='<%# Eval("product_name")%>'/>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="productID" runat="server" DataValueField="ID" DataTextField="product_name" SelectMethod="Get_products" selectedvalue='<%# Bind("productID") %>' AppendDataBoundItems="true">
                        <asp:ListItem Value="" Text="" Selected="False"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Famiglia">
                <ItemTemplate>
                   <asp:Label ID="familyID" runat="server" Text='<%# Eval("family_name")%>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="familyID" runat="server" DataValueField="ID" DataTextField="family_name" SelectMethod="Get_families" selectedvalue='<%# Bind("familyID")%>' AppendDataBoundItems="true">
                        <asp:ListItem Value="" Text="" Selected="False"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fuori produzione">
                <ItemTemplate>
                    <asp:CheckBox ID="annull" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="annull" runat="server" Checked='<%# Bind("annull")%>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Creato da ">
                <ItemTemplate>
                    <asp:Label ID="created_by" runat="server" Text='<%# Eval("created_by")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Data creazione ">
                <ItemTemplate>
                    <asp:Label ID="created_date" runat="server" Text='<%# Eval("created_date", "{0:dd/MM/yyyy}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Aggiornato da ">
                <ItemTemplate>
                    <asp:Label ID="updated_by" runat="server" Text='<%# Eval("updated_by")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Data aggiornamento ">
                <ItemTemplate>
                    <asp:Label ID="updated_date" runat="server" Text='<%# Eval("updated_date", "{0:dd/MM/yyyy}")%>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            
        </Columns>
    </asp:GridView>
</asp:Content>
