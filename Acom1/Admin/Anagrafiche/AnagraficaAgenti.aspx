<%@ Page Title="Agenti" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaAgenti.aspx.vb" Inherits="Acom1.AnagraficaAgenti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <asp:Label runat="server" ID="concurrencyViolation" Text="" Visible="false" EnableViewState="false" CssClass="alert alert-danger"></asp:Label>    
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="insert_agent"/>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="edit_agent" />
    <h3>Anagrafica agenti</h3>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1" InsertItemPosition="LastItem" OnItemInserting="ListView1_ItemInserting" OnItemUpdated="ListView1_ItemUpdated" OnItemInserted="ListView1_ItemInserted">
        <AlternatingItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                </td>
                <td>
                    <asp:Label ID="usernameLabel" runat="server" Text='<%# Eval("username") %>' />
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
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CssClass="btn btn-primary btn-hover" ValidationGroup="edit_agent" CausesValidation="true" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="nameTextBox" Display="None" ErrorMessage="Inserire nome agente" ID="require_agent" ValidationGroup="edit_agent" ></asp:RequiredFieldValidator>
                </td>
                <td>
<%--                    <asp:TextBox ID="usernameTextBox" runat="server" Text='<%# Bind("username") %>' />--%>
                <asp:DropDownList runat="server" AppendDataBoundItems="true" SelectMethod="Get_username" DataValueField="UserName" ID="DDLusername" selectedvalue='<%# Bind("username") %>' >
                    <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="DDLusername" Display="None" ErrorMessage="Inserire username agente" ID="require_username" ValidationGroup="edit_agent" ></asp:RequiredFieldValidator>
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
                    <asp:TextBox ID="aggiorn_dateTextBox" runat="server" Text='<%# Bind("aggiorn_date") %>' />
                    <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' Visible="false" Enabled="false" />
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
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover" ValidationGroup="insert_agent" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="nameTextBox" Display="None" ErrorMessage="Inserire nome agente" ID="require_agent" ValidationGroup="insert_agent" ></asp:RequiredFieldValidator>
                </td>
                <td>
<%--                    <asp:TextBox ID="usernameTextBox" runat="server" Text='<%# Bind("username") %>' />--%>
                <asp:DropDownList runat="server" AppendDataBoundItems="true" SelectMethod="Get_username" DataValueField="UserName" ID="DDLusername" selectedvalue='<%# Bind("username") %>' >
                    <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="DDLusername" Display="None" ErrorMessage="Inserire username agente" ID="require_username" ValidationGroup="insert_agent" ></asp:RequiredFieldValidator>
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
                    <asp:TextBox ID="aggiorn_dateTextBox" runat="server" Text='<%# Bind("aggiorn_date") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                </td>
                <td>
                    <asp:Label ID="usernameLabel" runat="server" Text='<%# Eval("username") %>' />
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
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Enabled="false" Visible="false" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server" >
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-hover table-bordered table-responsive" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color: #DCF5FD;color: #333333;">
                                <th runat="server"></th>
                                <th runat="server">Nome</th>
                                <th runat="server">Username</th>
                                <th runat="server">Disattivato</th>
                                <th runat="server">Creato da</th>
                                <th runat="server">Creato il</th>
                                <th runat="server">Modificato da</th>
                                <th runat="server">Modificato il</th>
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
            <tr >
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover"/>
                </td>
                <td>
                    <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                </td>
                <td>
                    <asp:Label ID="usernameLabel" runat="server" Text='<%# Eval("username") %>' />
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
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Enabled="false" Visible="false" />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
<br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnUpdating="SqlDataSource1_Updating" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [agents] WHERE [ID] = @original_ID AND (([name] = @original_name) OR ([name] IS NULL AND @original_name IS NULL)) AND [annull] = @original_annull AND (([username] = @original_username) OR ([username] IS NULL AND @original_username IS NULL)) AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([aggiorn_date] = @original_aggiorn_date) OR ([aggiorn_date] IS NULL AND @original_aggiorn_date IS NULL))" InsertCommand="INSERT INTO [agents] ([name], [annull], [username], [created_by], [created_date], [updated_by], [aggiorn_date]) VALUES (@name, @annull, @username, @created_by, @created_date, @updated_by, @aggiorn_date)" SelectCommand="SELECT * FROM [agents]" UpdateCommand="UPDATE [agents] SET [name] = @name, [annull] = @annull, [username] = @username, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [aggiorn_date] = @aggiorn_date WHERE [ID] = @original_ID AND (([name] = @original_name) OR ([name] IS NULL AND @original_name IS NULL)) AND [annull] = @original_annull AND (([username] = @original_username) OR ([username] IS NULL AND @original_username IS NULL)) AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([aggiorn_date] = @original_aggiorn_date) OR ([aggiorn_date] IS NULL AND @original_aggiorn_date IS NULL))" OldValuesParameterFormatString="original_{0}" ConflictDetection="CompareAllValues">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_name" Type="String" />
            <asp:Parameter Name="original_annull" Type="Boolean" />
            <asp:Parameter Name="original_username" Type="String" />
            <asp:Parameter Name="original_created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_created_date" />
            <asp:Parameter Name="original_updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_aggiorn_date" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="annull" Type="Boolean" />
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="created_date" />
            <asp:Parameter Name="updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="aggiorn_date" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="annull" Type="Boolean" />
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="created_date" />
            <asp:Parameter Name="updated_by" Type="String" />
            <asp:Parameter Name="rowvers" Type="Object" />
            <asp:Parameter DbType="DateTime2" Name="aggiorn_date" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_name" Type="String" />
            <asp:Parameter Name="original_annull" Type="Boolean" />
            <asp:Parameter Name="original_username" Type="String" />
            <asp:Parameter Name="original_created_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_created_date" />
            <asp:Parameter Name="original_updated_by" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="original_aggiorn_date" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
