<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaProdotti.aspx.vb" Inherits="Acom1.AnagraficaProdotti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_prod" />
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_prod" />
        <asp:Label runat="server" ID="concurrencyViolation" Text="Concurrency error" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <h3>Anagrafica Prodotti</h3>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceProduct" InsertItemPosition="LastItem" OnItemInserting="ListView1_ItemInserting" OnItemUpdated="ListView1_ItemUpdated" OnItemInserted="ListView1_ItemInserted">
            <AlternatingItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="product_nameLabel" runat="server" Text='<%# Eval("product_name") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                    </td>
                    <td>
                        <asp:Label ID="created_byLabel" runat="server" Text='<%# Eval("created_by") %>' />
                    </td>
                    <td>
                        <asp:Label ID="created_dateLabel" runat="server" Text='<%# Eval("created_date") %>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_byLabel" runat="server" Text='<%# Eval("updated_by") %>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_dateLabel" runat="server" Text='<%# Eval("updated_date") %>' />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_prod"  />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CssClass="btn btn-primary btn-hover" CausesValidation="false"   />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="product_nameTextBox" runat="server" Text='<%# Bind("product_name") %>' />
                        <asp:RequiredFieldValidator ID="required_name" runat="server" ControlToValidate="product_nameTextBox" Display="None" ErrorMessage="Inserire nome prodotto" ValidationGroup="edit_prod"></asp:RequiredFieldValidator>                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' />
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
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_prod" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="product_nameTextBox" runat="server" Text='<%# Bind("product_name") %>' />
                        <asp:RequiredFieldValidator ID="required_name" runat="server" ControlToValidate="product_nameTextBox" Display="None" ErrorMessage="Inserire nome prodotto" ValidationGroup="insert_prod"></asp:RequiredFieldValidator>                    
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="product_nameLabel" runat="server" Text='<%# Eval("product_name") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                    </td>
                    <td>
                        <asp:Label ID="created_byLabel" runat="server" Text='<%# Eval("created_by") %>' />
                    </td>
                    <td>
                        <asp:Label ID="created_dateLabel" runat="server" Text='<%# Eval("created_date") %>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_byLabel" runat="server" Text='<%# Eval("updated_by") %>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_dateLabel" runat="server" Text='<%# Eval("updated_date") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" class="table table-hover table-bordered table-responsive" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr runat="server" style="background-color: #DCF5FD;color: #333333;">
                                    <th runat="server"></th>
                                    <th runat="server">ID</th>
                                    <th runat="server">Prodotto</th>
                                    <th runat="server">Disattivo</th>
                                    <th runat="server">Creato da</th>
                                    <th runat="server">Creato il</th>
                                    <th runat="server">Aggiornato da</th>
                                    <th runat="server">Aggiornato il</th>
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
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="product_nameLabel" runat="server" Text='<%# Eval("product_name") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                    </td>
                    <td>
                        <asp:Label ID="created_byLabel" runat="server" Text='<%# Eval("created_by") %>' />
                    </td>
                    <td>
                        <asp:Label ID="created_dateLabel" runat="server" Text='<%# Eval("created_date") %>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_byLabel" runat="server" Text='<%# Eval("updated_by") %>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_dateLabel" runat="server" Text='<%# Eval("updated_date") %>' />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceProduct" runat="server" OnUpdating="SqlDataSourceProduct_Updating" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [products] WHERE [ID] = @original_ID AND (([product_name] = @original_product_name) OR ([product_name] IS NULL AND @original_product_name IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [products] ([product_name], [annull], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@product_name, @annull, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [product_name], [annull], [created_by], [created_date], [updated_by], [updated_date] FROM [products] ORDER BY [product_name]" UpdateCommand="UPDATE [products] SET [product_name] = @product_name, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([product_name] = @original_product_name) OR ([product_name] IS NULL AND @original_product_name IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_product_name" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="product_name" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="product_name" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_product_name" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>

</asp:Content>
