<%@ Page Title="Ordine" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="OrdiniIns.aspx.vb" Inherits="Acom1.OrdiniIns" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
     <h3>Dettaglio ordine</h3>
    <hr />
    <h4>Intestazione</h4>
            <p style="padding:10px">
            <asp:Label runat="server" ID="errormsg" Text="" CssClass="alert alert-danger" EnableViewState="false" Visible="false"></asp:Label>
            <asp:ValidationSummary ID="val_summ_order" runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
            </p>
            <asp:DetailsView runat="server" ID="DetailsViewOrder" AutoGenerateRows="false" DataKeyNames="ID" SelectMethod="DetailsViewOrder_GetItem" UpdateMethod="DetailsViewOrder_UpdateItem" InsertMethod="DetailsViewOrder_InsertItem" Width="30%" BorderStyle="None" GridLines="None" >
                <EditRowStyle Wrap="False"/>
                <FieldHeaderStyle Wrap="False" Font-Bold="true" />
                <Fields>
                    <asp:BoundField DataField="ID" ReadOnly="true" Visible="false" />
                    <asp:TemplateField HeaderText="Ordine n." ControlStyle-CssClass="form-control">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="order_code" Text='<%# Eval("order_code")%>' ></asp:Label>
                        </ItemTemplate>
                        </asp:TemplateField>

                   <asp:TemplateField HeaderText="Ordine SAP" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="order_sap" Text='<%# Eval("order_sap")%>'></asp:Label>
                            </ItemTemplate>
                       </asp:TemplateField>

                  <asp:TemplateField HeaderText="Agente" ControlStyle-CssClass="form-control">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="agentID" Text='<%# Eval("name")%>'></asp:Label>
                        </ItemTemplate>
                      </asp:TemplateField>

                    <asp:TemplateField HeaderText="Data *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="data" Text='<%# Eval("data", "{0:dd/MM/yyyy}")%>' ></asp:Label>
                            </ItemTemplate>
                         </asp:TemplateField>
  
                    <asp:TemplateField HeaderText="Cliente *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="clienteID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Filiale" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="officeID" Text='<%# Eval("nome")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                     <asp:TemplateField HeaderText="Riferimento impianto" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_impianto" Text='<%# Eval("rif_impianto")%>'></asp:Label>
                            </ItemTemplate>
                         </asp:TemplateField>

                    <asp:TemplateField HeaderText="Riferimento offerta" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_offerta" Text='<%# Eval("rif_offerta")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Offerta esterna" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_offertaest" Text='<%# Eval("rif_offertaest")%>' ></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>

                        <asp:TemplateField HeaderText="Ordine cliente" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="rif_ordinecliente" Text='<%# Eval("rif_ordinecliente")%>' ></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>

                    <asp:TemplateField HeaderText="Importo" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="importo" Text='<%# Eval("importo", "{0:C}")%>' ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    <asp:TemplateField HeaderText="Note" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:textbox runat="server" ID="note" Text='<%# Eval("note")%>' TextMode="MultiLine" ReadOnly="true" ></asp:textbox>
                            </ItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Annullato" InsertVisible="false">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' Enabled="false" ></asp:CheckBox>
                            </ItemTemplate>
                             </asp:TemplateField>                      

                        <asp:TemplateField HeaderText="Creato da" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="created_by" Text='<%# Eval("created_by")%>' Visible="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField headertext="Creato il" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="created_date" Text='<%# Eval("created_date", "{0:dd/MM/yyyy}")%>' Visible="true" ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato da" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updated_by")%>' Visible="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato il" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_date" Text='<%# Eval("updated_date", "{0:dd/MM/yyyy}")%>' Visible="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                     <asp:TemplateField HeaderText="ordine numero" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="order_num" Text='<%# Eval("order_num")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                         </asp:TemplateField>
                </Fields>
            </asp:DetailsView>

            <br />
                <hr />
            <h4>Dettaglio prodotti</h4>
            <asp:Label runat="server" ID="concurrencyViolation" Text="" Visible="false" EnableViewState="false" ForeColor="Red"></asp:Label>
            <asp:ListView ID="ListViewOrderRow" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceOrderRow" OnDataBound="ListViewOrderRow_DataBound">
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                        <tr>
                            <td>Nessuna riga d'ordine inserita</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr style="">
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
                        </td>
                        <td>
                            <asp:Label ID="created_byLabel" runat="server" Text='<%# Eval("created_by") %>' Visible="true"/>
                        </td>
                        <td>
                            <asp:Label ID="created_dateLabel" runat="server" Text='<%# Eval("created_date", "{0:dd/MM/yyyy}")%>' Visible="true"/>
                        </td>
                        <td>
                            <asp:Label ID="updated_byLabel" runat="server" Text='<%# Eval("updated_by") %>' Visible="true"/>
                        </td>
                        <td>
                            <asp:Label ID="updated_dateLabel" runat="server" Text='<%# Eval("updated_date", "{0:dd/MM/yyyy}")%>' Visible="true"/>
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" class="table table-hover table-bordered table-responsive" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                    <tr runat="server" style="background-color: #DCF5FD;color: #333333;">
                                        <th runat="server">Prodotto</th>
                                        <th runat="server">Quantità</th>
                                        <th runat="server">Note</th>
                                        <th runat="server">Annullato</th>
                                        <%-- <th runat="server" Visible="false">orderID</th>--%>
                                        <th runat="server" Visible="true">Creato da</th>
                                        <th runat="server" Visible="true">Creato il</th>
                                        <th runat="server" Visible="true">Modificato da</th>
                                        <th runat="server" Visible="true">Modificato il</th>
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
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="SqlDataSourceOrderRow" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [order_row] WHERE [ID] = @original_ID AND [productID] = @original_productID AND (([quantita] = @original_quantita) OR ([quantita] IS NULL AND @original_quantita IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND [orderID] = @original_orderID AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [order_row] ([productID], [quantita], [note], [annull], [orderID], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@productID, @quantita, @note, @annull, @orderID, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [productID], [quantita], [note], [annull], [orderID], [created_by], [created_date], [updated_by], [updated_date] FROM [order_row] WHERE ([orderID] = @orderID and [annull]=0)" UpdateCommand="UPDATE [order_row] SET [productID] = @productID, [quantita] = @quantita, [note] = @note, [annull] = @annull, [orderID] = @orderID, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND [productID] = @original_productID AND (([quantita] = @original_quantita) OR ([quantita] IS NULL AND @original_quantita IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND [orderID] = @original_orderID AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_ID" Type="Int32" />
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

