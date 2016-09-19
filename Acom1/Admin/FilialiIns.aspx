<%@ Page Title="Filiali" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="FilialiIns.aspx.vb" Inherits="Acom1.FilialiIns1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">

    <table style="width:100%;">
        <tr>
            <td style="width: 100%">
          <asp:Label runat="server" ID="errmsg" Text="" CssClass="alert alert-danger" Visible="false" EnableViewState="false"></asp:Label>
          <asp:Label runat="server" ID="okmsg" Text="" CssClass="alert alert-success" Visible="false" EnableViewState="false"></asp:Label>
         <h3>Dettaglio Filiale</h3>
    <asp:DetailsView ID="DetailsViewOffice" runat="server" SelectMethod="DetailsViewOffice_GetItem" AutoGenerateRows="false" DataKeyNames="ID" DefaultMode="ReadOnly" InsertMethod="DetailsViewOffice_InsertItem" UpdateMethod="DetailsViewOffice_UpdateItem" BorderStyle="None" GridLines="None">
        <FieldHeaderStyle Wrap="False" Font-Bold="true" />
        <HeaderStyle Wrap="False" />
        <RowStyle Wrap="False" />
        <Fields>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="false" ReadOnly="true" Visible="false" />
             <asp:TemplateField HeaderText="Ragione sociale - Casa Madre *" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="clientID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Nome filiale *" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="nome" Text='<%# Eval("nome")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Provincia" ControlStyle-CssClass="form-control">
               <ItemTemplate>
                   <asp:Label ID="provinciaID" runat="server" Text='<%# Eval("provincia")%>'></asp:Label>
               </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comune" ControlStyle-CssClass="form-control">
               <ItemTemplate>
                   <asp:Label ID="comuneID" runat="server" Text='<%# Eval("comune")%>'></asp:Label>
               </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CAP" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="cap" Text='<%# Eval("cap")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Indirizzo" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="indirizzo" Text='<%# Eval("indirizzo")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Telefono" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="telefono" Text='<%# Eval("telefono")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="email" Text='<%# Eval("email")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Note" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="note" Text='<%# Eval("note")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Disattivato" InsertVisible="False" ItemStyle-HorizontalAlign="Center" >
               <ItemTemplate>
                   <asp:CheckBox ID="annull" runat="server" Checked='<%# Eval("annull")%>' Enabled="false" ></asp:CheckBox>
               </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:label ID="created_by" runat="server" Text='<%# Bind("created_by")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="created_date" runat="server" Text='<%# Eval("created_date", "{0:dd/MM/yyyy}")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                        <asp:Label ID="updated_by" runat="server" Text='<%# Eval("updated_by")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                        <asp:Label ID="updated_date" runat="server" Text='<%# Eval("updated_date", "{0:dd/MM/yyyy}")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            </Fields>
    </asp:DetailsView>
        </tr>
        <tr>
            <td>
                <asp:Button ID="cmd_attiva" Text="Attiva" OnClick="cmd_attiva_Click" runat="server" CssClass="btn btn-primary btn-hover" />
                <asp:Button ID="cmd_disattiva" OnClick="cmd_disattiva_Click" Text="Disattiva" runat="server" CssClass="btn btn-primary btn-hover" />
            </td>
        </tr>
    </table>

    <h3>Contatti</h3>
        <asp:ListView runat="server" ID="ListViewContacts" DataKeyNames="ID" DataSourceID="SqlDataSourceContacts">
            <EmptyDataTemplate>
                <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                    <tr>
                        <td>Non è stato restituito alcun dato.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
                <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                </td>
                <td>
                    <asp:Label ID="cognomeLabel" runat="server" Text='<%# Eval("cognome") %>'/>
                </td>
                <td>
                    <asp:Label ID="telefonoLabel" runat="server" Text='<%# Eval("telefono") %>'/>
                </td>
                <td>
                    <asp:Label ID="cellulareLabel" runat="server" Text='<%# Eval("cellulare") %>'/>
                </td>
                <td>
                    <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' />
                </td>
                <td>
                    <asp:Label ID="funzioneLabel" runat="server" Text='<%# Eval("funzione") %>' />
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="annullLabel" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                    <asp:Label ID="clientIDLabel" runat="server" Text='<%# Eval("clientID") %>' Visible="false" />
                    <asp:Label ID="officeIDLabel" runat="server" Text='<%# Eval("officeID") %>' Visible="false" />
                </td>
                 <td>
                        <asp:Label ID="created_by" runat="server" Text='<%# Eval("created_by")%>' />
                    </td>
                    <td>
                        <asp:Label ID="created_date" runat="server" Text='<%# Eval("created_date")%>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_by" runat="server" Text='<%# Eval("updated_by")%>' />
                    </td>
                    <td>
                        <asp:Label ID="updated_date" runat="server" Text='<%# Eval("updated_date")%>' />
                    </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-hover table-bordered table-responsive" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color: #DCF5FD;color: #333333;">
                                <th runat="server">Nome</th>
                                <th runat="server">Cognome</th>
                                <th runat="server">Telefono</th>
                                <th runat="server">Cellulare</th>
                                <th runat="server">Email</th>
                                <th runat="server">Funzione</th>
                                <th runat="server">Note</th>
                                <th runat="server">Disattivo</th>
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
    </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceContacts" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [nome], [cognome], [telefono], [cellulare], [email], [funzione], [note], [annull], [clientID], [officeID], [created_by], [created_date], [updated_by], [updated_date] FROM [contactnames] WHERE (([clientID] = @clientID) AND ([officeID] = @officeID)) ORDER BY [cognome]">
        <SelectParameters>
            <asp:QueryStringParameter Name="clientID" QueryStringField="ID_cl" Type="Int32" />
            <asp:QueryStringParameter Name="officeID" QueryStringField="ID_of" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
