<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaFamiglie.aspx.vb" Inherits="Acom1.AnagraficaFamiglie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <asp:Label runat="server" ID="concurrencyViolation" Text="Concurrency error" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <asp:ValidationSummary runat="server" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_family" CssClass="alert alert-danger" />
    <asp:ValidationSummary runat="server" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" CssClass="alert alert-danger" ValidationGroup="edit_family"  />
    <h3>Anagrafica Famiglie</h3>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID"  OnItemUpdated="ListView1_ItemUpdated" DataSourceID="SqlDataSourceFamily" InsertItemPosition="LastItem" OnItemInserting="ListView1_ItemInserting" OnItemInserted="ListView1_ItemInserted" >
            <AlternatingItemTemplate>
                <tr >
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false"  CssClass="btn btn-primary btn-hover"  />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="family_nameLabel" runat="server" Text='<%# Eval("family_name") %>' />
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
                <tr >
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CausesValidation="true" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_family"  />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CausesValidation="false" CssClass="btn btn-primary btn-hover"  />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="family_nameTextBox" runat="server" Text='<%# Bind("family_name") %>' />
                        <asp:RequiredFieldValidator ID="Require_fam" runat="server" Display="None" ControlToValidate="family_nameTextBox" ErrorMessage="Inserire famiglia" ValidationGroup="edit_family" ></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' Enabled="false"/>
                    </td>
                    <td>
                        <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' Enabled="false" />
                    </td>
                    <td>
                        <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' Enabled="false" />
                    </td>
                    <td>
                        <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' Enabled="false"/>
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
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_family"  />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover"  />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="family_nameTextBox" runat="server" Text='<%# Bind("family_name") %>' />
                        <asp:RequiredFieldValidator ID="Require_fam_ins" runat="server" Display="None" ControlToValidate="family_nameTextBox" ErrorMessage="Inserire famiglia" ValidationGroup="insert_family" ></asp:RequiredFieldValidator>
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
                <tr >
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover"  />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="family_nameLabel" runat="server" Text='<%# Eval("family_name") %>' />
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
                                    <th runat="server">Famiglia</th>
                                    <th runat="server">Disattivato</th>
                                    <th runat="server">Creata da</th>
                                    <th runat="server">Creata il</th>
                                    <th runat="server">Aggiornata da</th>
                                    <th runat="server">Aggiornata il</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="text-align: center;background-color: #DCF5FD;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                            <asp:DataPager ID="DataPager1" runat="server">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-hover" ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr >
                    <td>
                        <asp:Button ID="EditButton" runat="server" CausesValidation="false" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover"  />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="family_nameLabel" runat="server" Text='<%# Eval("family_name") %>' />
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
        <asp:SqlDataSource ID="SqlDataSourceFamily" runat="server" OnUpdating="SqlDataSourceFamily_Updating" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [families] WHERE [ID] = @original_ID AND (([family_name] = @original_family_name) OR ([family_name] IS NULL AND @original_family_name IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [families] ([family_name], [annull], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@family_name, @annull, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [family_name], [annull], [created_by], [created_date], [updated_by], [updated_date] FROM [families] ORDER BY [family_name]" UpdateCommand="UPDATE [families] SET [family_name] = @family_name, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([family_name] = @original_family_name) OR ([family_name] IS NULL AND @original_family_name IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_family_name" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="family_name" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="family_name" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_family_name" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>

</asp:Content>
