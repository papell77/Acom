<%@ Page Title="Comuni" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="AnagraficaComuni.aspx.vb" Inherits="Acom1.AnagraficaComuni" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>&nbsp;</h3>
    <h3>Anagrafica comuni</h3>
    <p>
       <asp:Label ID="LabelComIns" runat="server" EnableViewState="false" Text="" CssClass="alert alert-danger" Font-Bold="true" Visible="false"></asp:Label>
        <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
    </p>
    <table>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblProv" Text="Provincia" Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="DropDownProv" runat="server" CssClass="form-control" SelectMethod="Get_provincia" AutoPostBack="true" DataTextField="nome" DataValueField="ID" AppendDataBoundItems="true">
                    <asp:ListItem Text="" Value="" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredProvValidator" runat="server" ControlToValidate="DropDownProv" ErrorMessage="Selezionare una provincia" Display="None" SetFocusOnError="true"  ></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="labComune" Text="Comune" Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextComuneIns" runat="server" Text="" CssClass="form-control" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="labCAP" Text="CAP" Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtCAP" Text="" CssClass="form-control"></asp:TextBox>
            </td>
        </tr>
    </table>    
    <br />  
        <asp:Button ID="ButtonInsComuni" runat="server" Text="Inserisci comune per la provincia selezionata" OnClick="ButtonInsComuni_Click" CssClass="btn btn-primary btn-hover"/>
        <br />
        <br />
    <p>
   
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1">
            <AlternatingItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                    </td>
                    <td>
                        <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                    </td>
                    <td>
                        <asp:Label ID="CAPLabel" runat="server" Text='<%# Eval("CAP") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                        <asp:Label ID="provinciaIDLabel" runat="server" Text='<%# Eval("provinciaID") %>' Visible="false" />
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Aggiorna" CssClass="btn btn-primary btn-hover" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                    </td>
                    <td>
                        <asp:TextBox ID="nomeTextBox" runat="server" Text='<%# Bind("nome") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire nome comune" ControlToValidate="nomeTextBox" runat="server" Display="None" SetFocusOnError="true" />
                    </td>
                    <td>
                        <asp:TextBox ID="CAPTextBox" runat="server" Text='<%# Bind("CAP") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire CAP" ControlToValidate="CAPTextBox" runat="server" Display="None" SetFocusOnError="true" />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                        <asp:TextBox ID="provinciaIDTextBox" runat="server" Text='<%# Bind("provinciaID") %>' Visible="false" />
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
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Inserisci" CssClass="btn btn-primary btn-hover" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                    </td>
                    <td>
                        <asp:TextBox ID="nomeTextBox" runat="server" Text='<%# Bind("nome") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire nome comune" ControlToValidate="nomeTextBox" runat="server" Display="None" SetFocusOnError="true" />
                    </td>
                    <td>
                        <asp:TextBox ID="CAPTextBox" runat="server" Text='<%# Bind("CAP") %>' />
                        <asp:RequiredFieldValidator ErrorMessage="Inserire CAP" ControlToValidate="CAPTextBox" runat="server" Display="None" SetFocusOnError="true" />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Bind("annull") %>' />
                        <asp:TextBox ID="provinciaIDTextBox" runat="server" Text='<%# Bind("provinciaID") %>' Visible="false" />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover"/>
                    </td>
                    <td>
                        <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                    </td>
                    <td>
                        <asp:Label ID="CAPLabel" runat="server" Text='<%# Eval("CAP") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                        <asp:Label ID="provinciaIDLabel" runat="server" Text='<%# Eval("provinciaID") %>' Visible="false" />
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
                                    <th runat="server">nome</th>
                                    <th runat="server">CAP</th>
                                    <th runat="server">annull</th>
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
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover"/>
                    </td>
                    <td>
                        <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                    </td>
                    <td>
                        <asp:Label ID="CAPLabel" runat="server" Text='<%# Eval("CAP") %>' />
                    </td>
                    <td> 
                       <asp:CheckBox ID="annullCheckBox" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                        <asp:Label ID="provinciaIDLabel" runat="server" Text='<%# Eval("provinciaID") %>' Visible="false" />                   
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [comunes] WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([CAP] = @original_CAP) OR ([CAP] IS NULL AND @original_CAP IS NULL)) AND [provinciaID] = @original_provinciaID AND [annull] = @original_annull" InsertCommand="INSERT INTO [comunes] ([nome], [CAP], [provinciaID], [annull]) VALUES (@nome, @CAP, @provinciaID, @annull)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [nome], [CAP], [provinciaID], [annull] FROM [comunes] WHERE ([provinciaID] = @provinciaID) ORDER BY [nome]" UpdateCommand="UPDATE [comunes] SET [nome] = @nome, [CAP] = @CAP, [provinciaID] = @provinciaID, [annull] = @annull WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([CAP] = @original_CAP) OR ([CAP] IS NULL AND @original_CAP IS NULL)) AND [provinciaID] = @original_provinciaID AND [annull] = @original_annull">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_nome" Type="String" />
                <asp:Parameter Name="original_CAP" Type="String" />
                <asp:Parameter Name="original_provinciaID" Type="Int32" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nome" Type="String" />
                <asp:Parameter Name="CAP" Type="String" />
                <asp:Parameter Name="provinciaID" Type="Int32" />
                <asp:Parameter Name="annull" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownProv" DefaultValue="0" Name="provinciaID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="nome" Type="String" />
                <asp:Parameter Name="CAP" Type="String" />
                <asp:Parameter Name="provinciaID" Type="Int32" />
                <asp:Parameter Name="annull" Type="Boolean" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_nome" Type="String" />
                <asp:Parameter Name="original_CAP" Type="String" />
                <asp:Parameter Name="original_provinciaID" Type="Int32" />
                <asp:Parameter Name="original_annull" Type="Boolean" />
            </UpdateParameters>
        </asp:SqlDataSource>

   
</asp:Content>
