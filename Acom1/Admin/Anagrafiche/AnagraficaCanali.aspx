<%@ Page Title="Canali" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaCanali.aspx.vb" Inherits="Acom1.AnagraficaCanali" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <asp:Label runat="server" ID="concurrencyViolation" Text="Un altro utente sta modificando questi dati, riprovare più tardi" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_canal" />
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true"  ValidationGroup="edit_canal" />
    <h3>Anagrafica canali</h3>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1" InsertItemPosition="LastItem" OnItemInserting="ListView1_ItemInserting" OnItemUpdated="ListView1_ItemUpdated" OnItemInserted="ListView1_ItemInserted">
        <AlternatingItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="canal_codeLabel" runat="server" Text='<%# Eval("canal_code") %>' />
                </td>
                <td>
                    <asp:Label ID="canal_descLabel" runat="server" Text='<%# Eval("canal_desc") %>' />
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
                    <asp:Label ID="aggiorn_dateLabel" runat="server" Text='<%# Eval("aggiorn_date") %>' />
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CausesValidation="true" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_canal"/>
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CausesValidation="false" CssClass="btn btn-primary btn-hover"/>
                </td>
                <td>
                    <asp:TextBox ID="canal_codeTextBox" runat="server" Text='<%# Bind("canal_code") %>' />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="canal_codeTextBox" Display="None" ErrorMessage="Inserire codice canale" ID="require_agent" ValidationGroup="edit_canal" ></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:TextBox ID="canal_descTextBox" runat="server" Text='<%# Bind("canal_desc") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                </td>
                <td>
                    <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' Enabled="false" />
                </td>
                <td>
                    <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' Enabled="false"/>
                </td>
                <td>
                    <asp:TextBox ID="aggiorn_dateTextBox" runat="server" Text='<%# Bind("aggiorn_date") %>' Enabled="false"/>
                    <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
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
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CausesValidation="true" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_canal" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover"/>
                </td>
                <td>
                    <asp:TextBox ID="canal_codeTextBox_insert" runat="server" Text='<%# Bind("canal_code") %>' />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="canal_codeTextBox_insert" Display="None" ErrorMessage="Inserire codice canale" ID="require_agent" ValidationGroup="insert_canal" ></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:TextBox ID="canal_descTextBox" runat="server" Text='<%# Bind("canal_desc") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                </td>
                <td>
                    <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' Enabled="false" />
                </td>
                <td>
                    <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' Enabled="false" />
                </td>
                <td>
                    <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' Enabled="false" />
                </td>
                <td>
                    <asp:TextBox ID="aggiorn_dateTextBox" runat="server" Text='<%# Bind("aggiorn_date") %>' Enabled="false" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="canal_codeLabel" runat="server" Text='<%# Eval("canal_code") %>' />
                </td>
                <td>
                    <asp:Label ID="canal_descLabel" runat="server" Text='<%# Eval("canal_desc") %>' />
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
                    <asp:Label ID="aggiorn_dateLabel" runat="server" Text='<%# Eval("aggiorn_date") %>' />
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-hover table-bordered table-responsive" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color:#DCF5FD; color: #333333;">
                                <th runat="server"></th>
                                <th runat="server">Codice canale</th>
                                <th runat="server">Descrizione canale</th>
                                <th runat="server">Disattivato</th>
                                <th runat="server">Inserito da</th>
                                <th runat="server">Inserito il</th>
                                <th runat="server">Aggiornato da</th>
                                <th runat="server">Aggiornato il</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center;background-color: #DCF5FD; font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
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
            <tr>
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="canal_codeLabel" runat="server" Text='<%# Eval("canal_code") %>' />
                </td>
                <td>
                    <asp:Label ID="canal_descLabel" runat="server" Text='<%# Eval("canal_desc") %>' />
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
                    <asp:Label ID="aggiorn_dateLabel" runat="server" Text='<%# Eval("aggiorn_date") %>' />
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnUpdating="SqlDataSource1_Updating" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [canals] WHERE [ID] = @original_ID AND (([canal_code] = @original_canal_code) OR ([canal_code] IS NULL AND @original_canal_code IS NULL)) AND (([canal_desc] = @original_canal_desc) OR ([canal_desc] IS NULL AND @original_canal_desc IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([aggiorn_date] = @original_aggiorn_date) OR ([aggiorn_date] IS NULL AND @original_aggiorn_date IS NULL))" InsertCommand="INSERT INTO [canals] ([canal_code], [canal_desc], [annull], [created_by], [created_date], [updated_by], [aggiorn_date]) VALUES (@canal_code, @canal_desc, @annull, @created_by, @created_date, @updated_by, @aggiorn_date)" SelectCommand="SELECT [ID], [canal_code], [canal_desc], [annull], [created_by], [created_date], [updated_by], [aggiorn_date] FROM [canals]" UpdateCommand="UPDATE [canals] SET [canal_code] = @canal_code, [canal_desc] = @canal_desc, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [aggiorn_date] = @aggiorn_date WHERE [ID] = @original_ID AND (([canal_code] = @original_canal_code) OR ([canal_code] IS NULL AND @original_canal_code IS NULL)) AND (([canal_desc] = @original_canal_desc) OR ([canal_desc] IS NULL AND @original_canal_desc IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([aggiorn_date] = @original_aggiorn_date) OR ([aggiorn_date] IS NULL AND @original_aggiorn_date IS NULL))" OldValuesParameterFormatString="original_{0}" ConflictDetection="CompareAllValues">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_canal_code" Type="String" />
            <asp:Parameter Name="original_canal_desc" Type="String" />
            <asp:Parameter Name="original_annull" Type="Boolean" />
            <asp:Parameter Name="original_created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_created_date" />
            <asp:Parameter Name="original_updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_aggiorn_date" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="canal_code" Type="String" />
            <asp:Parameter Name="canal_desc" Type="String" />
            <asp:Parameter Name="annull" Type="Boolean" />
            <asp:Parameter Name="created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="created_date" />
            <asp:Parameter Name="updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="aggiorn_date" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="canal_code" Type="String" />
            <asp:Parameter Name="canal_desc" Type="String" />
            <asp:Parameter Name="annull" Type="Boolean" />
            <asp:Parameter Name="created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="created_date" />
            <asp:Parameter Name="updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="aggiorn_date" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_canal_code" Type="String" />
            <asp:Parameter Name="original_canal_desc" Type="String" />
            <asp:Parameter Name="original_annull" Type="Boolean" />
            <asp:Parameter Name="original_created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_created_date" />
            <asp:Parameter Name="original_updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_aggiorn_date" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
