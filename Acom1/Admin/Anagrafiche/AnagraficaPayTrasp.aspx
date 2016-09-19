<%@ Page Title="Pagamenti e trasporti" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaPayTrasp.aspx.vb" Inherits="Acom1.AnagraficaPayTrasp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <h3>Forme di pagamento</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>

    <asp:Label runat="server" ID="concurrencyViolation" Text="Concurrency error" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <asp:ValidationSummary runat="server" ID="val_summ" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_pay" />
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_pay" />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1" InsertItemPosition="LastItem" OnItemUpdated="ListView1_ItemUpdated" OnItemInserting="ListView1_ItemInserting" OnItemInserted="ListView1_ItemInserted">
        <AlternatingItemTemplate>
        
               <tr >
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="pagamentoLabel" runat="server" Text='<%# Eval("pagamento") %>' />
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
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
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_pay" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                </td>
                <td>
                    <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="pagamentoTextBox" runat="server" Text='<%# Bind("pagamento") %>' />
                    <asp:RequiredFieldValidator runat="server" ID="require_pay" ControlToValidate="pagamentoTextBox" Display="None"  ErrorMessage="Inserire pagamento" ValidationGroup="edit_pay" ></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
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
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_pay" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:TextBox ID="pagamentoTextBox" runat="server" Text='<%# Bind("pagamento") %>' />
                    <asp:RequiredFieldValidator runat="server" ID="require_pay" ControlToValidate="pagamentoTextBox" Display="None" ErrorMessage="Inserire pagamento" ValidationGroup="insert_pay" ></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' />
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
                    <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' Enabled="false"/>
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover"/>
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="pagamentoLabel" runat="server" Text='<%# Eval("pagamento") %>' />
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
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
                                <th runat="server">Pagamento</th>
                                <th runat="server">Note</th>
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
                                <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-hover" ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="pagamentoLabel" runat="server" Text='<%# Eval("pagamento") %>' />
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
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
            
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnUpdating="SqlDataSource1_Updating" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [payments] WHERE [ID] = @original_ID AND (([pagamento] = @original_pagamento) OR ([pagamento] IS NULL AND @original_pagamento IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [payments] ([pagamento], [note], [annull], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@pagamento, @note, @annull, @created_by, @created_date, @updated_by, @updated_date)" SelectCommand="SELECT [ID], [pagamento], [note], [annull], [created_by], [created_date], [updated_by], [updated_date] FROM [payments]" UpdateCommand="UPDATE [payments] SET [pagamento] = @pagamento, [note] = @note, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([pagamento] = @original_pagamento) OR ([pagamento] IS NULL AND @original_pagamento IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_pagamento" Type="String" />
            <asp:Parameter Name="original_note" Type="String" />
            <asp:Parameter Name="original_annull" Type="Boolean" />
            <asp:Parameter Name="original_created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_created_date" />
            <asp:Parameter Name="original_updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="pagamento" Type="String" />
            <asp:Parameter Name="note" Type="String" />
            <asp:Parameter Name="annull" Type="Boolean" />
            <asp:Parameter Name="created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="created_date" />
            <asp:Parameter Name="updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="updated_date" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="pagamento" Type="String" />
            <asp:Parameter Name="note" Type="String" />
            <asp:Parameter Name="annull" Type="Boolean" />
            <asp:Parameter Name="created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="created_date" />
            <asp:Parameter Name="updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="updated_date" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_pagamento" Type="String" />
            <asp:Parameter Name="original_note" Type="String" />
            <asp:Parameter Name="original_annull" Type="Boolean" />
            <asp:Parameter Name="original_created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_created_date" />
            <asp:Parameter Name="original_updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <h3>Forme di garanzia</h3>

    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:Label runat="server" ID="concurrencyViolation2" Text="Concurrency error" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_trasp" />
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_trasp" />
    <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSourceGaranzie" DataKeyNames="ID" InsertItemPosition="LastItem" OnItemUpdated="ListView2_ItemUpdated" OnItemInserting="ListView2_ItemInserting" OnItemInserted="ListView2_ItemInserted">
        <AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="garanzia_descLabel" runat="server" Text='<%# Eval("garanzia_desc") %>' />
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
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
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_trasp" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="garanzia_descTextBox" runat="server" Text='<%# Bind("garanzia_desc") %>' />
                    <asp:RequiredFieldValidator runat="server" ID="require_gar" ControlToValidate="garanzia_descTextBox" Display="None" ErrorMessage="Inserire garanzia" ValidationGroup="edit_trasp"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                </td>
                <td>
                    <asp:TextBox ID="created_byTextBox" runat="server" Text='<%# Bind("created_by") %>' Enabled="false"  />
                </td>
                <td>
                    <asp:TextBox ID="created_dateTextBox" runat="server" Text='<%# Bind("created_date") %>' Enabled="false" />
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
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover"  ValidationGroup="insert_trasp" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:TextBox ID="garanzia_descTextBox" runat="server" Text='<%# Bind("garanzia_desc") %>' />
                    <asp:RequiredFieldValidator runat="server" ID="require_gar" ControlToValidate="garanzia_descTextBox" Display="None" ErrorMessage="Inserire garanzia" ValidationGroup="insert_trasp" ></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
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
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="garanzia_descLabel" runat="server" Text='<%# Eval("garanzia_desc") %>' />
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
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
                                <th runat="server">Garanzia</th>
                                <th runat="server">Note</th>
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
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="garanzia_descLabel" runat="server" Text='<%# Eval("garanzia_desc") %>' />
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
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
            
        </ContentTemplate>
    </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlDataSourceGaranzie" runat="server" OnUpdating="SqlDataSourceGaranzie_Updating" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [garanzias] WHERE [ID] = @original_ID AND (([garanzia_desc] = @original_garanzia_desc) OR ([garanzia_desc] IS NULL AND @original_garanzia_desc IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [garanzias] ([garanzia_desc], [note], [annull], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@garanzia_desc, @note, @annull, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [garanzia_desc], [note], [annull], [created_by], [created_date], [updated_by], [updated_date] FROM [garanzias]" UpdateCommand="UPDATE [garanzias] SET [garanzia_desc] = @garanzia_desc, [note] = @note, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([garanzia_desc] = @original_garanzia_desc) OR ([garanzia_desc] IS NULL AND @original_garanzia_desc IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_garanzia_desc" Type="String" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="garanzia_desc" Type="String" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="garanzia_desc" Type="String" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_garanzia_desc" Type="String" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </asp:Content>
