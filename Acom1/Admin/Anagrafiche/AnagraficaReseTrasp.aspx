<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaReseTrasp.aspx.vb" Inherits="Acom1.AnagraficaReseTrasp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <h3>Forme di Resa</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:Label runat="server" ID="concurrencyViolation" Text="Concurrency error" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_rese"/>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_rese" />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceResa" InsertItemPosition="LastItem" OnItemUpdated="ListView1_ItemUpdated" OnItemInserting="ListView1_ItemInserting" OnItemInserted="ListView1_ItemInserted">
        <AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover"  />
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="resa_descLabel" runat="server" Text='<%# Eval("resa_desc") %>' />
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
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" ValidationGroup="edit_rese" CssClass="btn btn-primary btn-hover" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CausesValidation="false" CssClass="btn btn-primary btn-hover"  />
                </td>
                <td>
                    <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="resa_descTextBox" runat="server" Text='<%# Bind("resa_desc") %>' />
                    <asp:RequiredFieldValidator ErrorMessage="Inserire resa" ControlToValidate="resa_descTextBox" runat="server" Display="None" ValidationGroup="edit_rese" />
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
                    <asp:TextBox ID="updated_dateTextBox" runat="server" Text='<%# Bind("updated_date") %>' Enabled="false" />
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
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" ValidationGroup="insert_rese" CssClass="btn btn-primary btn-hover"  />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:TextBox ID="resa_descTextBox" runat="server" Text='<%# Bind("resa_desc") %>' />
                    <asp:RequiredFieldValidator ErrorMessage="Inserire resa" ControlToValidate="resa_descTextBox" runat="server" Display="None" ValidationGroup="insert_rese" />
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
                    <asp:Label ID="resa_descLabel" runat="server" Text='<%# Eval("resa_desc") %>' />
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
                                <th runat="server">Resa</th>
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
                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary btn-hover" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover"  />
                </td>
                <td>
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </td>
                <td>
                    <asp:Label ID="resa_descLabel" runat="server" Text='<%# Eval("resa_desc") %>' />
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
        <asp:SqlDataSource ID="SqlDataSourceResa" runat="server" OnUpdating="SqlDataSourceResa_Updating" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [resas] WHERE [ID] = @original_ID AND (([resa_desc] = @original_resa_desc) OR ([resa_desc] IS NULL AND @original_resa_desc IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [resas] ([resa_desc], [note], [annull], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@resa_desc, @note, @annull, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [resa_desc], [note], [annull], [created_by], [created_date], [updated_by], [updated_date] FROM [resas]" UpdateCommand="UPDATE [resas] SET [resa_desc] = @resa_desc, [note] = @note, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([resa_desc] = @original_resa_desc) OR ([resa_desc] IS NULL AND @original_resa_desc IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_resa_desc" Type="String" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="resa_desc" Type="String" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="resa_desc" Type="String" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_resa_desc" Type="String" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </UpdateParameters>
        </asp:SqlDataSource>
    <br />
    <br />
    <h3>Costi di trasporto</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:Label runat="server" ID="concurrencyViolation2" Text="Concurrency error" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_trasp"/>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_trasp" />
    <p>
        <asp:ListView ID="ListView2" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceTrasporto" InsertItemPosition="LastItem" OnItemUpdated="ListView2_ItemUpdated" OnItemInserting="ListView1_ItemInserting" OnItemInserted="ListView2_ItemInserted">
            <AlternatingItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="trasportoLabel" runat="server" Text='<%# Eval("trasporto") %>' />
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
                        <asp:TextBox ID="trasportoTextBox" runat="server" Text='<%# Bind("trasporto") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire trasporto" ControlToValidate="trasportoTextBox" runat="server" Display="None" ValidationGroup="edit_trasp" />
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
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_trasp" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="trasportoTextBox" runat="server" Text='<%# Bind("trasporto") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire trasporto" ControlToValidate="trasportoTextBox" runat="server" Display="None" ValidationGroup="insert_trasp" />
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
                        <asp:Label ID="trasportoLabel" runat="server" Text='<%# Eval("trasporto") %>' />
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
                            <table id="itemPlaceholderContainer" runat="server" class="table table-hover table-bordered table-responsive"  border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr runat="server" style="background-color: #DCF5FD;color: #333333;">
                                    <th runat="server"></th>
                                    <th runat="server">ID</th>
                                    <th runat="server">Costo trasporto</th>
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
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary btn-hover" ShowFirstPageButton="True" ShowLastPageButton="True" />
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
                        <asp:Label ID="trasportoLabel" runat="server" Text='<%# Eval("trasporto") %>' />
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
    </p>    
        </ContentTemplate>
    </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlDataSourceTrasporto" runat="server" OnUpdating="SqlDataSourceTrasporto_Updating" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [transports] WHERE [ID] = @original_ID AND (([trasporto] = @original_trasporto) OR ([trasporto] IS NULL AND @original_trasporto IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [transports] ([trasporto], [note], [annull], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@trasporto, @note, @annull, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [trasporto], [note], [annull], [created_by], [created_date], [updated_by], [updated_date] FROM [transports]" UpdateCommand="UPDATE [transports] SET [trasporto] = @trasporto, [note] = @note, [annull] = @annull, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([trasporto] = @original_trasporto) OR ([trasporto] IS NULL AND @original_trasporto IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_trasporto" Type="String" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="trasporto" Type="String" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="trasporto" Type="String" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="created_date" />
                <asp:Parameter Name="updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="updated_date" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_trasporto" Type="String" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
                <asp:Parameter Name="original_created_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                <asp:Parameter Name="original_updated_by" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
            </UpdateParameters>
        </asp:SqlDataSource>
    

</asp:Content>
