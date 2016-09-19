<%@ Page Title="Ordini" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="OrdiniIns.aspx.vb" Inherits="Acom1.OrdiniIns1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>Dettaglio ordine</h3>
    <hr />
    <h4>Intestazione</h4>
    <h5>I campi contrassegnati con * sono obbligatori</h5>
   <asp:UpdatePanel ID="UpdatePanelDetail" runat="server">
        <ContentTemplate>
            <p style="padding:10px">
            <asp:Label runat="server" ID="errormsg" Text="" CssClass="alert alert-danger" EnableViewState="false" Visible="false"></asp:Label>
            <asp:ValidationSummary ID="val_summ_order" runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
            </p>
            <asp:DetailsView runat="server" ID="DetailsViewOrder" AutoGenerateRows="false" DataKeyNames="ID" SelectMethod="DetailsViewOrder_GetItem" UpdateMethod="DetailsViewOrder_UpdateItem" InsertMethod="DetailsViewOrder_InsertItem" Width="50%" CssClass="form" BorderStyle="None" GridLines="None" >
                <EditRowStyle Wrap="False"/>
                <FieldHeaderStyle Wrap="False" Font-Bold="true" Width="20%" />
                <Fields>
                    <asp:BoundField DataField="ID" ReadOnly="true" Visible="false" />
                    <asp:TemplateField HeaderText="Ordine n." ControlStyle-CssClass="form-control">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="order_code" Text='<%# Eval("order_code")%>' ></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="order_code" Text='<%# Bind("order_code")%>' Enabled="false"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox runat="server" ID="order_code" Text="" Enabled="false" Visible="false"></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>

                   <asp:TemplateField HeaderText="Ordine SAP" ControlStyle-CssClass="form-control" >
                            <ItemTemplate>
                                <asp:Label runat="server" ID="order_sap" Text='<%# Eval("order_sap")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="order_sap" Text='<%# Bind("order_sap")%>' ></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="order_sap" Text="" ></asp:TextBox>
                            </InsertItemTemplate>
                    </asp:TemplateField>

                  <asp:TemplateField HeaderText="Agente" ControlStyle-CssClass="form-control">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="agentID" Text='<%# Eval("name")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList runat="server" ID="agentID" AutoPostBack="true" DataValueField="ID" DataTextField="name" SelectMethod="Get_agent" AppendDataBoundItems="true" selectedvalue='<%# Bind("agentID")%>' OnSelectedIndexChanged="agentID_SelectedIndexChanged" OnDataBound="agentID_SelectedIndexChanged" >
                                <asp:ListItem Value="" Text=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="agent_annull" Text="Agente non attivo" Visible="false" ForeColor="Red"></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList runat="server" ID="agentID" DataValueField="ID" DataTextField="name" SelectMethod="Get_agent" AppendDataBoundItems="true" selectedvalue='<%# Bind("agentID")%>' >
                                <asp:ListItem Value="" Text=""></asp:ListItem>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Data *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="data" Text='<%# Eval("data", "{0:dd/MM/yyyy}")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="data" Text='<%# Bind("data", "{0:dd/MM/yyyy}")%>' ></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data" Format="dd/MM/yyyy" />
                                <asp:RequiredFieldValidator ID="RequiredData" runat="server" ErrorMessage="Inserire data ordine" ControlToValidate="data" Display="none" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="data" Text=""></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data" Format="dd/MM/yyyy"  />
                                <asp:RequiredFieldValidator ID="RequiredData" runat="server" ErrorMessage="Inserire data ordine" ControlToValidate="data" Display="none" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
  
                    <asp:TemplateField HeaderText="Cliente *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="clienteID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="clienteID" AutoPostBack="true" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client" AppendDataBoundItems="true" selectedvalue='<%# Bind("clientID")%>' OnSelectedIndexChanged="DDLClient_SelectedIndexChanged" OnDataBound="DDLClient_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="client_annull" Text="Cliente non attivo" Visible="false" ForeColor="Red"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredClient" runat="server" ErrorMessage="Inserire cliente" ControlToValidate="clienteID" Display="none" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="clienteID" AutoPostBack="true" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client" AppendDataBoundItems="true" OnSelectedIndexChanged="DDLClient_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredClient" runat="server" ErrorMessage="Inserire cliente" ControlToValidate="clienteID" Display="none" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Filiale" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="officeID" Text='<%# Eval("nome")%>'></asp:Label>
                                </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="officeID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" AppendDataBoundItems="true" selectedvalue='<%# Bind("officeID")%>' OnDataBinding="DDLOffice_DataBinding" OnSelectedIndexChanged="officeID_SelectedIndexChanged" OnDataBound="officeID_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="office_annull" Text="Filiale non attiva" Visible="false" ForeColor="Red"></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="officeID" AutoPostBack="true" DataValueField="ID" DataTextField="nome"  AppendDataBoundItems="true" OnDataBinding="DDLOffice_DataBinding" OnSelectedIndexChanged="officeID_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                     <asp:TemplateField HeaderText="Riferimento impianto" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_impianto" Text='<%# Eval("rif_impianto")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="rif_impianto" Text='<%# Bind("rif_impianto")%>' ></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="rif_impianto" Text="" ></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                    <asp:TemplateField HeaderText="Riferimento offerta" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_offerta" Text='<%# Eval("rif_offerta")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="rif_offerta" AutoPostBack="true" DataValueField="offer_code" DataTextField="offer_code"  AppendDataBoundItems="true" selectedvalue='<%# Bind("rif_offerta")%>' OnDataBinding="rif_offerta_DataBinding" OnSelectedIndexChanged="rif_offerta_SelectedIndexChanged" OnDataBound="rif_offerta_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="offerta_annull" Text="Offerta non attiva" Visible="false" ForeColor="Red"></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="rif_offerta" DataValueField="offer_code" DataTextField="offer_code"  AppendDataBoundItems="true" OnDataBinding="rif_offerta_DataBinding">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Offerta esterna" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_offertaest" Text='<%# Eval("rif_offertaest")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="rif_offertaest" Text='<%# Bind("rif_offertaest")%>' ></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="rif_offertaest" Text=""></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Ordine cliente" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_ordinecliente" Text='<%# Eval("rif_ordinecliente")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="rif_ordinecliente" Text='<%# Bind("rif_ordinecliente")%>' ></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="rif_ordinecliente" Text=""></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                    <asp:TemplateField HeaderText="Importo" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="importo" Text='<%# Eval("importo", "{0:C}")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="importo" Text='<%# Bind("importo")%>' ></asp:TextBox> 
                                <asp:RegularExpressionValidator ErrorMessage="Importo deve essere numerico" ControlToValidate="importo" runat="server" ValidationExpression="^[0-9.,]*$" Display="None" />
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="importo" Text=""></asp:TextBox>
                                <asp:RegularExpressionValidator ErrorMessage="Importo deve essere numerico" ControlToValidate="importo" runat="server" ValidationExpression="^[0-9.,]*$" Display="None" />    
                            </InsertItemTemplate>
                        </asp:TemplateField>

                    <asp:TemplateField HeaderText="Note" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:textbox runat="server" ID="note" Text='<%# Eval("note")%>' TextMode="MultiLine" ReadOnly="true" ></asp:textbox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="note" Text='<%# Bind("note")%>' TextMode="MultiLine" ></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="note" Text="" TextMode="MultiLine"></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Annullato" InsertVisible="false">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' Enabled="false" ></asp:CheckBox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Bind("annull")%>' Enabled="true" ></asp:CheckBox>
                            </EditItemTemplate>
                        </asp:TemplateField>                      

                        <asp:TemplateField HeaderText="Creato da" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="created_by" Text='<%# Eval("created_by")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField headertext="Creato il" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="created_date" Text='<%# Eval("created_date")%>' Visible="false" ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato da" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updated_by")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato il" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_date" Text='<%# Eval("updated_date")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                     <asp:TemplateField HeaderText="ordine numero" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="order_num" Text='<%# Eval("order_num")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="order_num" Text='<%# Bind("order_num")%>' Visible="false" ></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="order_num" Text="" Visible="false" ></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                    <asp:CommandField ShowEditButton="true" ShowCancelButton="true" ShowInsertButton="true" ControlStyle-CssClass="btn btn-primary btn-hover" />
                </Fields>
            </asp:DetailsView>
        </ContentTemplate>
        </asp:UpdatePanel>
            <br />
        <asp:UpdatePanel ID="UpdatePanelListView" runat="server">
             <ContentTemplate>
            <hr />
            <h4>Dettaglio prodotti</h4>
            <asp:Label runat="server" ID="concurrencyViolation" Text="" Visible="false" EnableViewState="false" ForeColor="Red"></asp:Label>
            <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ID="order_insert" ShowMessageBox="false" ShowModelStateErrors="false" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_prod" />
            <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ID="order_edit" ShowMessageBox="false" ShowModelStateErrors="false" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_prod" />
            <asp:ListView ID="ListViewOrderRow" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceOrderRow" InsertItemPosition="LastItem" OnItemInserting="ListViewOrderRow_ItemInserting" OnItemUpdated="ListViewOrderRow_ItemUpdated" OnDataBound="ListViewOrderRow_DataBound">
                <AlternatingItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="familyID" CssClass="form-control" Enabled="false" SelectMethod="Get_family" AppendDataBoundItems="true" DataTextField="family_name" DataValueField="ID" selectedvalue='<%# Eval("familyID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull_family" Text="Famiglia non attiva" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="productID" CssClass="form-control" Enabled="false" SelectMethod="Get_product" AppendDataBoundItems="true" DataTextField="product_name" DataValueField="ID" selectedvalue='<%# Eval("productID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull" Text="Prodotto non attivo" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="quantitaLabel" runat="server" Text='<%# Eval("quantita", "{0:N0}")%>'  />
                        </td>
                        <td>
                            <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                            <asp:Label ID="orderIDLabel" runat="server" Text='<%# Eval("orderID") %>' Visible="false" />
                            <asp:Label ID="created_byLabel" runat="server" Text='<%# Eval("created_by") %>' Visible="false" />
                            <asp:Label ID="created_dateLabel" runat="server" Text='<%# Eval("created_date") %>' Visible="false"/>
                            <asp:Label ID="updated_byLabel" runat="server" Text='<%# Eval("updated_by") %>' Visible="false" />
                            <asp:Label ID="updated_dateLabel" runat="server" Text='<%# Eval("updated_date") %>' Visible="false"/>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Salva" CausesValidation="true" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_prod" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="familyID" CssClass="form-control" SelectMethod="Get_family" AppendDataBoundItems="true" DataTextField="family_name" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="familyID_SelectedIndexChanged" selectedvalue='<%# Bind("familyID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull_family" Text="Famiglia non attiva" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                            <asp:RequiredFieldValidator runat="server" ID="req_fam_ins" ControlToValidate="familyID" Display="None" ErrorMessage="Inserire prodotto" ValidationGroup="edit_prod" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="productID" CssClass="form-control" SelectMethod="Get_product" AppendDataBoundItems="true" DataTextField="product_name" DataValueField="ID" AutoPostBack="true" selectedvalue='<%# Bind("productID")%>' OnSelectedIndexChanged="productID_SelectedIndexChanged">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull" Text="Prodotto non attivo" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                            <asp:RequiredFieldValidator runat="server" ID="req_prod_edit" ControlToValidate="productID" Display="None" ErrorMessage="Inserire prodotto" ValidationGroup="edit_prod" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="quantitaTextBox" runat="server" Text='<%# Bind("quantita", "{0:N0}")%>' CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="req_qta_edit" runat="server" ControlToValidate="quantitaTextBox" Display="None" ErrorMessage="Inserire quantità" ValidationGroup="edit_prod" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="req_qta_num" runat="server" ControlToValidate="quantitaTextBox" Display="None" ErrorMessage="La quantità deve essere un numero intero" MaximumValue="999999999" MinimumValue="0" Type="Integer" ValidationGroup="edit_prod" SetFocusOnError="true"></asp:RangeValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' CssClass="form-control" />
                        </td>
                        <td>
                            <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                            <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' Visible="false"/>
                            <asp:TextBox ID="orderIDTextBox" runat="server" Text='<%# Bind("orderID") %>' Visible="false"/>
                            <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' Visible="false" CssClass="form-control"/>
                            <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' Visible="false" CssClass="form-control"/>
                            <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' Visible="false" CssClass="form-control"/>
                            <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' Visible="false" CssClass="form-control"/>
                        </td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                        <tr>
                            <td>Non è stato restituito alcun dato.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Salva" CausesValidation="true" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_prod" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="familyID" CssClass="form-control" SelectMethod="Get_family" AppendDataBoundItems="true" DataTextField="family_name" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="familyID_SelectedIndexChanged" selectedvalue='<%# Bind("familyID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ID="req_fam_ins" ControlToValidate="familyID" Display="None" ErrorMessage="Inserire famiglia" ValidationGroup="insert_prod" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="productID" CssClass="form-control" SelectMethod="Get_product" AppendDataBoundItems="true" DataTextField="product_name" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="productID_SelectedIndexChanged" selectedvalue='<%# Bind("productID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ID="req_prod_ins" ControlToValidate="productID" Display="None" ErrorMessage="Inserire prodotto" ValidationGroup="insert_prod" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="quantitaTextBox" runat="server" Text='<%# Bind("quantita", "{0:N0}")%>' CssClass="form-control"/>
                            <asp:RequiredFieldValidator ID="req_qta_ins" runat="server" ControlToValidate="quantitaTextBox" Display="None" ErrorMessage="Inserire quantità" ValidationGroup="insert_prod" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="req_qta_num" runat="server" ControlToValidate="quantitaTextBox" Display="None" ErrorMessage="La quantità deve essere un numero intero" MaximumValue="999999999" MinimumValue="0" Type="Integer" ValidationGroup="insert_prod" SetFocusOnError="true"></asp:RangeValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' CssClass="form-control"/>
                        </td>
                        <td>
                            <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                            <asp:TextBox ID="orderIDTextBox" runat="server" Text='<%# Bind("orderID") %>' Visible="false"/>
                            <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' Visible="false" CssClass="form-control"/>
                            <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' Visible="false" CssClass="form-control"/>
                            <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' Visible="false" CssClass="form-control"/>
                            <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' Visible="false" CssClass="form-control"/>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="familyID" CssClass="form-control" Enabled="false" SelectMethod="Get_family" AppendDataBoundItems="true" DataTextField="family_name" DataValueField="ID" selectedvalue='<%# Eval("familyID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull_family" Text="Famiglia non attiva" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="productID" Enabled="false" CssClass="form-control" SelectMethod="Get_product" AppendDataBoundItems="true" DataTextField="product_name" DataValueField="ID" selectedvalue='<%# Eval("productID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull" Text="Prodotto non attivo" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="quantitaLabel" runat="server" Text='<%# Eval("quantita", "{0:N0}")%>' />
                        </td>
                        <td>
                            <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false"/>
                            <asp:Label ID="orderIDLabel" runat="server" Text='<%# Eval("orderID") %>' Visible="false"/>
                            <asp:Label ID="created_byLabel" runat="server" Text='<%# Eval("created_by") %>' Visible="false"/>
                            <asp:Label ID="created_dateLabel" runat="server" Text='<%# Eval("created_date") %>' Visible="false"/>
                            <asp:Label ID="updated_byLabel" runat="server" Text='<%# Eval("updated_by") %>' Visible="false"/>
                            <asp:Label ID="updated_dateLabel" runat="server" Text='<%# Eval("updated_date") %>' Visible="false"/>
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" class="table table-hover table-bordered table-responsive" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                    <tr runat="server" style="background-color: #DCF5FD;color: #333333;">
                                        <th runat="server"></th>
                                        <th runat="server">Famiglia</th>
                                        <th runat="server">Prodotto</th>
                                        <th runat="server">Quantità</th>
                                        <th runat="server">Note</th>
                                        <th runat="server">Annullato</th>
                                        <%-- <th runat="server" Visible="false">orderID</th>
                                        <th runat="server" Visible="false">created_by</th>
                                        <th runat="server" Visible="false">created_date</th>
                                        <th runat="server" Visible="false">updated_by</th>
                                        <th runat="server" Visible="false">updated_date</th>--%>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="text-align: center;background-color: #DCF5FD;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;"></td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                        </td>   
                        <td>
                            <asp:DropDownList runat="server" ID="familyID" CssClass="form-control" Enabled="false" SelectMethod="Get_family" AppendDataBoundItems="true" DataTextField="family_name" DataValueField="ID" selectedvalue='<%# Eval("familyID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull_family" Text="Famiglia non attiva" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="productID" CssClass="form-control" Enabled="false" SelectMethod="Get_product" AppendDataBoundItems="true" DataTextField="product_name" DataValueField="ID" selectedvalue='<%# Eval("productID")%>'>
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="annull" Text="Prodotto non attivo" Visible="false" EnableViewState="false" ForeColor="Red" ></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="quantitaLabel" runat="server" Text='<%# Eval("quantita", "{0:N0}")%>' />
                        </td>
                        <td>
                            <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                            <asp:Label ID="orderIDLabel" runat="server" Text='<%# Eval("orderID") %>' Visible="false"/>
                            <asp:Label ID="created_byLabel" runat="server" Text='<%# Eval("created_by") %>' Visible="false"/>
                            <asp:Label ID="created_dateLabel" runat="server" Text='<%# Eval("created_date") %>' Visible="false" />
                            <asp:Label ID="updated_byLabel" runat="server" Text='<%# Eval("updated_by") %>' Visible="false"/>
                            <asp:Label ID="updated_dateLabel" runat="server" Text='<%# Eval("updated_date") %>' Visible="false"/>

                        </td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
            <br />
          </ContentTemplate>
        </asp:UpdatePanel>
            <asp:SqlDataSource ID="SqlDataSourceOrderRow" runat="server" OnUpdating="SqlDataSourceOrderRow_Updating" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [order_row] WHERE [ID] = @original_ID AND [familyID] = @original_familyID AND [productID] = @original_productID AND (([quantita] = @original_quantita) OR ([quantita] IS NULL AND @original_quantita IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND [orderID] = @original_orderID AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [order_row] ([familyID], [productID], [quantita], [note], [annull], [orderID], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@familyID, @productID, @quantita, @note, @annull, @orderID, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID],[familyID], [productID], [quantita], [note], [annull], [orderID], [created_by], [created_date], [updated_by], [updated_date] FROM [order_row] WHERE ([orderID] = @orderID and [annull]=0)" UpdateCommand="UPDATE [order_row] SET [familyID] = @familyID, [productID] = @productID, [quantita] = @quantita, [note] = @note, [annull] = @annull, [orderID] = @orderID, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND [familyID] = @original_familyID  AND [productID] = @original_productID AND (([quantita] = @original_quantita) OR ([quantita] IS NULL AND @original_quantita IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND [orderID] = @original_orderID AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_ID" Type="Int32" />
                    <asp:Parameter Name="original_familyID" Type="Int32" />
                    <asp:Parameter Name="original_productID" Type="Int32" />
                    <asp:Parameter Name="original_quantita" Type="Decimal" />
                    <asp:Parameter Name="original_note" Type="String" />
                    <asp:Parameter Name="original_annull" Type="Boolean" />
                    <asp:Parameter Name="original_orderID" Type="Int32" />
                    <asp:Parameter Name="original_created_by" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                    <asp:Parameter Name="original_updated_by" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="familyID" Type="Int32" />
                    <asp:Parameter Name="productID" Type="Int32" />
                    <asp:Parameter Name="quantita" Type="Decimal" />
                    <asp:Parameter Name="note" Type="String" />
                    <asp:Parameter Name="annull" Type="Boolean" />
                    <asp:Parameter Name="orderID" Type="Int32" />
                    <asp:Parameter Name="created_by" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="created_date" />
                    <asp:Parameter Name="updated_by" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="updated_date" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="0" Name="orderID" QueryStringField="ID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="familyID" Type="Int32" />
                    <asp:Parameter Name="productID" Type="Int32" />
                    <asp:Parameter Name="quantita" Type="Decimal" />
                    <asp:Parameter Name="note" Type="String" />
                    <asp:Parameter Name="annull" Type="Boolean" />
                    <asp:Parameter Name="orderID" Type="Int32" />
                    <asp:Parameter Name="created_by" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="created_date" />
                    <asp:Parameter Name="updated_by" Type="String" />
                    <asp:Parameter Name="updated_date" DbType="DateTime2" />
                    <asp:Parameter Name="original_ID" Type="Int32" />
                    <asp:Parameter Name="original_familyID" Type="Int32" />
                    <asp:Parameter Name="original_productID" Type="Int32" />
                    <asp:Parameter Name="original_quantita" Type="Decimal" />
                    <asp:Parameter Name="original_note" Type="String" />
                    <asp:Parameter Name="original_annull" Type="Boolean" />
                    <asp:Parameter Name="original_orderID" Type="Int32" />
                    <asp:Parameter Name="original_created_by" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                    <asp:Parameter Name="original_updated_by" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            

</asp:Content>
