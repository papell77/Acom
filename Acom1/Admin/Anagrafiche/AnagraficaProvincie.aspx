<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaProvincie.aspx.vb" Inherits="Acom1.AnagraficaProvincie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <h3>Anagrafica provincie</h3>
    <asp:Label runat="server" ID="concurrencyViolation" Text="Concurrency error" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_prov"/>    
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_prov"/>    
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceProv" InsertItemPosition="LastItem" OnItemInserting="ListView1_ItemInserting" OnItemUpdated="ListView1_ItemUpdated" OnItemInserted="ListView1_ItemInserted">
            <AlternatingItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                    </td>
                    <td>
                        <asp:Label ID="siglaLabel" runat="server" Text='<%# Eval("sigla") %>' />
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
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_prov" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CssClass="btn btn-primary btn-hover" CausesValidation="false"  />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="nomeTextBox" runat="server" Text='<%# Bind("nome") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire nome provincia" ControlToValidate="nomeTextBox" runat="server" Display="None" ValidationGroup="edit_prov" />
                    </td>
                    <td>
                        <asp:TextBox ID="siglaTextBox" runat="server" Text='<%# Bind("sigla") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire sigla provincia" ControlToValidate="siglaTextBox" runat="server" Display="None" ValidationGroup="edit_prov" />
                    </td>
                    <td>
                    <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull")%>' />
                    </td>
                    <td>
                        <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' Enabled="false"/>
                    </td>
                    <td>
                        <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' Enabled="false"/>
                    </td>
                    <td>
                        <asp:TextBox ID="updated_byTextBox" runat="server" Text='<%# Bind("updated_by") %>' Enabled="false"/>
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
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_prov" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="nomeTextBox" runat="server" Text='<%# Bind("nome") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire nome provincia" ControlToValidate="nomeTextBox" runat="server" Display="None" ValidationGroup="insert_prov" />
                    </td>
                    <td>
                        <asp:TextBox ID="siglaTextBox" runat="server" Text='<%# Bind("sigla") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire sigla provincia" ControlToValidate="siglaTextBox" runat="server" Display="None" ValidationGroup="insert_prov" />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull")%>' />
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
                        <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' Enabled="false"/>
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
                        <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                    </td>
                    <td>
                        <asp:Label ID="siglaLabel" runat="server" Text='<%# Eval("sigla") %>' />
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
                                <tr runat="server" style="background-color:#DCF5FD; color: #333333;">
                                    <th runat="server"></th>
                                    <th runat="server">ID</th>
                                    <th runat="server">Provincia</th>
                                    <th runat="server">Sigla</th>
                                    <th runat="server">Disattivato</th>
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
                        <td runat="server" style="text-align: center;background-color: #DCF5FD; font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                            <asp:DataPager ID="DataPager1" runat="server">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false"  />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                    </td>
                    <td>
                        <asp:Label ID="siglaLabel" runat="server" Text='<%# Eval("sigla") %>' />
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
        <asp:SqlDataSource ID="SqlDataSourceProv" runat="server" OnUpdating="SqlDataSourceProv_Updating" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [provincias] WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([sigla] = @original_sigla) OR ([sigla] IS NULL AND @original_sigla IS NULL)) AND (([annull] = @original_annull) OR ([annull] IS NULL AND @original_annull IS NULL)) AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [provincias] ([nome], [sigla], [annull], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@nome, @sigla, @annull, @created_by, @created_date, @updated_by, @updated_date)" SelectCommand="SELECT [ID], [nome], [sigla], [annull], [created_by], [created_date], [updated_by], [updated_date] FROM [provincias]" UpdateCommand="UPDATE [provincias] SET [nome] = @nome, [sigla] = @sigla, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([sigla] = @original_sigla) OR ([sigla] IS NULL AND @original_sigla IS NULL)) AND (([annull] = @original_annull) OR ([annull] IS NULL AND @original_annull IS NULL)) AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_nome" Type="String" />
                <asp:Parameter Name="original_sigla" Type="String" />
                <asp:Parameter Name="original_annull" Type="String" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nome" Type="String" />
                <asp:Parameter Name="sigla" Type="String" />
                <asp:Parameter Name="annull" Type="String" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nome" Type="String" />
                <asp:Parameter Name="sigla" Type="String" />
                <asp:Parameter Name="annull" Type="String" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_nome" Type="String" />
                <asp:Parameter Name="original_sigla" Type="String" />
                <asp:Parameter Name="original_annull" Type="String" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </UpdateParameters>
        </asp:SqlDataSource>
   
</asp:Content>
