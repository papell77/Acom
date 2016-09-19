<%@ Page Title="Filiali" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="FilialiIns.aspx.vb" Inherits="Acom1.FilialiIns" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
   <table style="width:100%;">
        <tr>
            <td style="width: 50%">
    <asp:UpdatePanel runat="server" ID="updateoffice">
        <ContentTemplate>
    <asp:Label runat="server" ID="errmsg" Text="" CssClass="alert alert-danger" Visible="false" EnableViewState="false"></asp:Label>
    <asp:ValidationSummary runat="server" ID="valid_sum" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowValidationErrors="true" ShowSummary="true" ValidationGroup="office" />
    <h3>Dettaglio Filiale</h3>
    <h5>I campi contrassegnati con * sono obbligatori</h5>
    <asp:DetailsView ID="DetailsViewOffice" runat="server" SelectMethod="DetailsViewOffice_GetItem" AutoGenerateRows="false" DataKeyNames="ID" DefaultMode="ReadOnly" InsertMethod="DetailsViewOffice_InsertItem" UpdateMethod="DetailsViewOffice_UpdateItem" BorderStyle="None" GridLines="None">
        <CommandRowStyle Wrap="False" />
        <EditRowStyle Wrap="False" />
        <FieldHeaderStyle Wrap="False" Font-Bold="true" />
        <HeaderStyle Wrap="False" />
        <InsertRowStyle Wrap="False" />
        <RowStyle Wrap="False" />
        <Fields>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="false" ReadOnly="true" Visible="false" />
             <asp:TemplateField HeaderText="Ragione sociale - Casa Madre *" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="clientID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList runat="server" ID="clientID" AutoPostBack="false" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client"  selectedvalue='<%# Bind("clientID")%>' AppendDataBoundItems="true" Enabled="false">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList runat="server" ID="clientID" AutoPostBack="false" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client"  selectedvalue='<%# Bind("clientID")%>' AppendDataBoundItems="true" CausesValidation="true">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>               
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="clientID" SetFocusOnError="true" ErrorMessage="Selezionare cliente" Display="None" ValidationGroup="office" ></asp:RequiredFieldValidator> 
                </InsertItemTemplate>
            </asp:TemplateField>
             
            <asp:TemplateField HeaderText="Nome filiale *" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="nome" Text='<%# Eval("nome")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="nome" Text='<%# Bind("nome")%>' Enabled="false"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="nome" Text='<%# Bind("nome")%>'></asp:TextBox>
                   <asp:RequiredFieldValidator runat="server" ID="required_code" ControlToValidate="nome" ErrorMessage="Inserire nome filiale" SetFocusOnError="true" Display="None" ValidationGroup="office" ></asp:RequiredFieldValidator>
                   <asp:CustomValidator runat="server" ID="duplicate_code" ControlToValidate="nome" ErrorMessage="Il nome filiale esiste già" OnServerValidate="duplicate_code_ServerValidate" SetFocusOnError="true" Display="None" ValidationGroup="office"></asp:CustomValidator>
                </InsertItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Provincia" ControlStyle-CssClass="form-control">
               <ItemTemplate>
                   <asp:Label ID="provinciaID" runat="server" Text='<%# Eval("provincia")%>'></asp:Label>
               </ItemTemplate>
               <EditItemTemplate>
                   <asp:DropDownList ID="provinciaID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" runat="server" SelectMethod="Get_provincia" OnSelectedIndexChanged="provinciaID_SelectedIndexChanged" selectedvalue='<%# Bind("provinciaID")%>' AppendDataBoundItems="true">
                       <asp:ListItem Value="" Text=""></asp:ListItem>
                   </asp:DropDownList>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:DropDownList ID="provinciaID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" runat="server" SelectMethod="Get_provincia" OnSelectedIndexChanged="provinciaID_SelectedIndexChanged" AppendDataBoundItems="true" >
                       <asp:ListItem Value="" Text=""></asp:ListItem>
                   </asp:DropDownList>
               </InsertItemTemplate>
           </asp:TemplateField>

           <asp:TemplateField HeaderText="Comune" ControlStyle-CssClass="form-control">
               <ItemTemplate>
                   <asp:Label ID="comuneID" runat="server" Text='<%# Eval("comune")%>'></asp:Label>
               </ItemTemplate>
               <EditItemTemplate>
                   <asp:DropDownList ID="comuneID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" runat="server" OnDataBinding="comuneID_DataBinding" selectedvalue='<%# Bind("comuneID")%>' AppendDataBoundItems="true" OnSelectedIndexChanged="comuneID_SelectedIndexChanged">
                       <asp:ListItem Value="" Text=""></asp:ListItem>
                   </asp:DropDownList>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:DropDownList ID="comuneID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" runat="server" OnDataBinding="comuneID_DataBinding" AppendDataBoundItems="true" OnSelectedIndexChanged="comuneID_SelectedIndexChanged" >
                       <asp:ListItem Value="" Text=""></asp:ListItem>
                   </asp:DropDownList>
               </InsertItemTemplate>
           </asp:TemplateField>

            <asp:TemplateField HeaderText="CAP" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="cap" Text='<%# Eval("cap")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="cap" Text='<%# Bind("cap")%>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="cap" Text='<%# Bind("cap")%>'></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Indirizzo" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="indirizzo" Text='<%# Eval("indirizzo")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="indirizzo" Text='<%# Bind("indirizzo")%>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="indirizzo" Text='<%# Bind("indirizzo")%>'></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Telefono" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="telefono" Text='<%# Eval("telefono")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="telefono" Text='<%# Bind("telefono")%>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="telefono" Text='<%# Bind("telefono")%>'></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Email" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="email" Text='<%# Eval("email")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="email" Text='<%# Bind("email")%>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="email" Text='<%# Bind("email")%>'></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Note" ControlStyle-CssClass="form-control">
                <ItemTemplate>
                    <asp:Label runat="server" ID="note" Text='<%# Eval("note")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="note" Text='<%# Bind("note")%>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox runat="server" ID="note" Text='<%# Bind("note")%>'></asp:TextBox>
                </InsertItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Disattivato" InsertVisible="False" ControlStyle-CssClass="form-control">
               <ItemTemplate>
                   <asp:CheckBox ID="annull" runat="server" Checked='<%# Eval("annull")%>' Enabled="false" ></asp:CheckBox>
               </ItemTemplate>
               <EditItemTemplate>
                   <asp:CheckBox ID="annull" runat="server" Checked='<%# Bind("annull")%>'></asp:CheckBox>
               </EditItemTemplate>
               <ItemStyle HorizontalAlign="Center" />
           </asp:TemplateField>
        <asp:CommandField ShowInsertButton="true" ShowEditButton="true" ShowCancelButton="true" ControlStyle-CssClass="btn btn-primary btn-hover" ValidationGroup="office" />           
        </Fields>
    </asp:DetailsView>
</ContentTemplate>
    </asp:UpdatePanel>
            
            </td>
            <td style="width: 50%">
                <br />
            </td>
        </tr>
    </table>

    <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="updateoffice">
        <ProgressTemplate>  
            <div class="updateprogress-modal">
                <div class="updateprogress-center">
                    <asp:Label Text="Aggiornamento in corso..." runat="server" ForeColor="Black" BackColor="White" />    
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="updatecontact">
        <ProgressTemplate>  
            <div class="updateprogress-modal">
                <div class="updateprogress-center">
                    <asp:Label Text="Aggiornamento in corso..." runat="server" ForeColor="Black" BackColor="White" />    
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>


<asp:UpdatePanel runat="server" ID="updatecontact">
    <ContentTemplate>

   
    <br />
    <h3>Contatti</h3>
        <asp:ValidationSummary runat="server" CssClass="text-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="contact_insert" />
        <asp:ValidationSummary runat="server" CssClass="text-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="contact_edit" />
        <asp:ListView runat="server" ID="ListViewContacts" DataKeyNames="ID" OnItemInserting="ListViewContacts_ItemInserting" DataSourceID="SqlDataSourceContacts" InsertItemPosition="LastItem" >
        <AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                </td>
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
                    <asp:Label ID="cellulareLabel" runat="server" Text='<%# Eval("cellulare") %>' />
                </td>
                <td>
                    <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' />
                </td>
                <td>
                    <asp:Label ID="funzioneLabel" runat="server" Text='<%# Eval("funzione") %>'/>
                </td>
                <td>
                    <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="annullLabel" runat="server" Checked='<%# Eval("annull") %>' Enabled="false" />
                    <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false"/>
                    <asp:Label ID="clientIDLabel" runat="server" Text='<%# Eval("clientID") %>' Visible="false"/>
                    <asp:Label ID="officeIDLabel" runat="server" Text='<%# Eval("officeID") %>' Visible="false"/>
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Salva" CssClass="btn btn-primary btn-hover" ValidationGroup="contact_edit" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annulla" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                </td>
                <td>
                    <asp:TextBox ID="nomeTextBox" runat="server" Text='<%# Bind("nome") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="cognomeTextBox" runat="server" Text='<%# Bind("cognome") %>' CssClass="form-control"/>
                    <asp:RequiredFieldValidator ErrorMessage="Inserire cognome" ControlToValidate="cognomeTextBox" SetFocusOnError="true" runat="server"  Display="None" ValidationGroup="contact_edit"/>
                </td>
                <td>
                    <asp:TextBox ID="telefonoTextBox" runat="server" Text='<%# Bind("telefono") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="cellulareTextBox" runat="server" Text='<%# Bind("cellulare") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="funzioneTextBox" runat="server" Text='<%# Bind("funzione") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:CheckBox ID="annullTextBox" runat="server" Checked='<%# Bind("annull") %>' />
                    <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' Visible="false" CssClass="form-control"/>
                    <asp:TextBox ID="clientIDTextBox" runat="server" Text='<%# Bind("clientID") %>' Visible="false" CssClass="form-control"/>
                    <asp:TextBox ID="officeIDTextBox" runat="server" Text='<%# Bind("officeID") %>' Visible="false" CssClass="form-control"/>
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
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Salva" CssClass="btn btn-primary btn-hover" ValidationGroup="contact_insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancella" CssClass="btn btn-primary btn-hover" CausesValidation="false"/>
                </td>
                <td>
                    <asp:TextBox ID="nomeTextBox" runat="server" Text='<%# Bind("nome") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="cognomeTextBox" runat="server" Text='<%# Bind("cognome") %>' CssClass="form-control"/>
                    <asp:RequiredFieldValidator ErrorMessage="Inserire cognome" ControlToValidate="cognomeTextBox" SetFocusOnError="true" runat="server"  Display="None" ValidationGroup="contact_insert"/>
                </td>
                <td>
                    <asp:TextBox ID="telefonoTextBox" runat="server" Text='<%# Bind("telefono") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="cellulareTextBox" runat="server" Text='<%# Bind("cellulare") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="funzioneTextBox" runat="server" Text='<%# Bind("funzione") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>' CssClass="form-control"/>
                </td>
                <td>
                    <asp:CheckBox ID="annullTextBox" runat="server" Checked='<%# Bind("annull") %>' />
                    <asp:TextBox ID="clientIDTextBox" runat="server" Text='<%# Bind("clientID") %>' Visible="false" CssClass="form-control"/>
                    <asp:TextBox ID="officeIDTextBox" runat="server" Text='<%# Bind("officeID") %>' Visible="false" CssClass="form-control"/>
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CssClass="btn btn-primary btn-hover" CausesValidation="false" />
                </td>
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
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-hover table-bordered table-responsive" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color: #DCF5FD;color: #333333;">
                                <th runat="server"></th>
                                <th runat="server">Nome</th>
                                <th runat="server">Cognome</th>
                                <th runat="server">Telefono</th>
                                <th runat="server">Cellulare</th>
                                <th runat="server">Email</th>
                                <th runat="server">Funzione</th>
                                <th runat="server">Note</th>
                                <th runat="server">Disattivo</th>
                                <%-- <th runat="server">ID</th>
                                <th runat="server" visible="false">clientID</th>
                                <th runat="server" visible="false">officeID</th>--%>
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
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Modifica" CausesValidation="false" CssClass="btn btn-primary btn-hover" />
                </td>
                <td>
                    <asp:Label ID="nomeLabel" runat="server" Text='<%# Eval("nome") %>' />
                </td>
                <td>
                    <asp:Label ID="cognomeLabel" runat="server" Text='<%# Eval("cognome") %>' />
                </td>
                <td>
                    <asp:Label ID="telefonoLabel" runat="server" Text='<%# Eval("telefono") %>' />
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
            </tr>
        </SelectedItemTemplate>

    </asp:ListView>

 </ContentTemplate>
</asp:UpdatePanel>
    
    <asp:SqlDataSource ID="SqlDataSourceContacts" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [contactnames] WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([cognome] = @original_cognome) OR ([cognome] IS NULL AND @original_cognome IS NULL)) AND (([telefono] = @original_telefono) OR ([telefono] IS NULL AND @original_telefono IS NULL)) AND (([cellulare] = @original_cellulare) OR ([cellulare] IS NULL AND @original_cellulare IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([funzione] = @original_funzione) OR ([funzione] IS NULL AND @original_funzione IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND (([annull] = @original_annull) OR ([annull] IS NULL AND @original_annull IS NULL)) AND (([clientID] = @original_clientID) OR ([clientID] IS NULL AND @original_clientID IS NULL)) AND (([officeID] = @original_officeID) OR ([officeID] IS NULL AND @original_officeID IS NULL))" InsertCommand="INSERT INTO [contactnames] ([nome], [cognome], [telefono], [cellulare], [email], [funzione], [note], [annull], [clientID], [officeID]) VALUES (@nome, @cognome, @telefono, @cellulare, @email, @funzione, @note, @annull, @clientID, @officeID)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [nome], [cognome], [telefono], [cellulare], [email], [funzione], [note], [annull], [clientID], [officeID] FROM [contactnames] WHERE (([officeID] = @officeID) AND ([clientID] = @clientID))" UpdateCommand="UPDATE [contactnames] SET [nome] = @nome, [cognome] = @cognome, [telefono] = @telefono, [cellulare] = @cellulare, [email] = @email, [funzione] = @funzione, [note] = @note, [annull] = @annull, [clientID] = @clientID, [officeID] = @officeID WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([cognome] = @original_cognome) OR ([cognome] IS NULL AND @original_cognome IS NULL)) AND (([telefono] = @original_telefono) OR ([telefono] IS NULL AND @original_telefono IS NULL)) AND (([cellulare] = @original_cellulare) OR ([cellulare] IS NULL AND @original_cellulare IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([funzione] = @original_funzione) OR ([funzione] IS NULL AND @original_funzione IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND (([annull] = @original_annull) OR ([annull] IS NULL AND @original_annull IS NULL)) AND (([clientID] = @original_clientID) OR ([clientID] IS NULL AND @original_clientID IS NULL)) AND (([officeID] = @original_officeID) OR ([officeID] IS NULL AND @original_officeID IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_nome" Type="String" />
            <asp:Parameter Name="original_cognome" Type="String" />
            <asp:Parameter Name="original_telefono" Type="String" />
            <asp:Parameter Name="original_cellulare" Type="String" />
            <asp:Parameter Name="original_email" Type="String" />
            <asp:Parameter Name="original_funzione" Type="String" />
            <asp:Parameter Name="original_note" Type="String" />
            <asp:Parameter Name="original_annull" Type="String" />
            <asp:Parameter Name="original_clientID" Type="Int32" />
            <asp:Parameter Name="original_officeID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="nome" Type="String" />
            <asp:Parameter Name="cognome" Type="String" />
            <asp:Parameter Name="telefono" Type="String" />
            <asp:Parameter Name="cellulare" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="funzione" Type="String" />
            <asp:Parameter Name="note" Type="String" />
            <asp:Parameter Name="annull" Type="String" />
            <asp:Parameter Name="clientID" Type="Int32" />
            <asp:Parameter Name="officeID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="officeID" QueryStringField="ID_of" Type="Int32" />
            <asp:QueryStringParameter DefaultValue="0" Name="clientID" QueryStringField="ID_cl" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="nome" Type="String" />
            <asp:Parameter Name="cognome" Type="String" />
            <asp:Parameter Name="telefono" Type="String" />
            <asp:Parameter Name="cellulare" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="funzione" Type="String" />
            <asp:Parameter Name="note" Type="String" />
            <asp:Parameter Name="annull" Type="String" />
            <asp:Parameter Name="clientID" Type="Int32" />
            <asp:Parameter Name="officeID" Type="Int32" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_nome" Type="String" />
            <asp:Parameter Name="original_cognome" Type="String" />
            <asp:Parameter Name="original_telefono" Type="String" />
            <asp:Parameter Name="original_cellulare" Type="String" />
            <asp:Parameter Name="original_email" Type="String" />
            <asp:Parameter Name="original_funzione" Type="String" />
            <asp:Parameter Name="original_note" Type="String" />
            <asp:Parameter Name="original_annull" Type="String" />
            <asp:Parameter Name="original_clientID" Type="Int32" />
            <asp:Parameter Name="original_officeID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
