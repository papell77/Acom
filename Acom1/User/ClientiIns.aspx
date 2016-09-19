<%@ Page Title="Clienti" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="ClientiIns.aspx.vb" Inherits="Acom1.ClientiIns1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <asp:Label runat="server" ID="errmsg" Text="" CssClass="alert alert-danger" Visible="false" EnableViewState="false"></asp:Label>
    <asp:ValidationSummary runat="server" ID="valid_sum" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowValidationErrors="true" ShowSummary="true" ValidationGroup="client" />
    <asp:UpdatePanel runat="server" ID="updateclient">
        <ContentTemplate>    
    <div class="acomform">
        <asp:FormView ID="FormClientIns" runat="server" SelectMethod="FormClientIns_GetItem" DataKeyNames="ID" UpdateMethod="FormClientIns_UpdateItem" OnItemUpdated="FormClientIns_ItemUpdated" InsertMethod="FormClientIns_InsertItem" OnItemInserted="FormClientIns_ItemInserted"  >
            <ItemTemplate>
            <h3>Dettaglio cliente: <%# Eval("codice")%> - <%# Eval("ragione_sociale")%></h3> 
            <h5>I campi contrassegnati con * sono obbligatori</h5>
            <asp:HiddenField ID="ID"  Value='<%# Eval("ID")%>' runat="server" />
            <hr />
            <table class="acomtable" >
                <tr >
                    <td class="form-label" style="text-align:right" >Canale:</td>
                    <td><asp:Label ID="canalID" Text='<%# Eval("canal_code")%>' runat="server" CssClass="form-control"/></td>
                    <td class="form-label" style="text-align:right" >Agente:</td>
                    <td><asp:Label ID="AgentID" Text='<%# Eval("name")%>' runat="server" CssClass="form-control"/></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:right" >Disattivato:</td>
                    <td><asp:CheckBox ID="annull" runat="server" Checked='<%# Eval("annull")%>' Enabled="false" ></asp:CheckBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td>Indirizzo</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="form-label" style="text-align:end" >Provincia:</td>
                    <td><asp:Label ID="provinciaID" runat="server" Text='<%# Eval("provincia")%>' CssClass="form-control"></asp:Label></td>
                    <td class="form-label" style="text-align:end">Comune:</td>
                    <td><asp:Label ID="comuneID" runat="server" Text='<%# Eval("comune")%>' CssClass="form-control"></asp:Label></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">CAP:</td>
                    <td><asp:Label ID="cap" runat="server" Text='<%# Eval("cap")%>' CssClass="form-control"></asp:Label></td>
                    <td class="form-label" style="text-align:end">Via/Piazza:</td>
                    <td><asp:Label ID="indirizzo" runat="server" Text='<%# Eval("indirizzo")%>' CssClass="form-control"></asp:Label></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td>Dati fiscali</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Codice fiscale:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("CF")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end">P.Iva:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("piva")%>' CssClass="form-control"></asp:Label> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">P.Iva CEE:</td>
                    <td > <asp:Label runat="server" text='<%# Eval("piva")%>' CssClass="form-control"></asp:Label> </td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Informazioni di contatto</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Telefono:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("telefono")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end">Email:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("email")%>' CssClass="form-control" ></asp:Label> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Modalità invio fatture:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("invio_fattura")%>' CssClass="form-control" ></asp:Label> </td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Dati bancari</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Banca:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("banca")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end">Iban:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("iban")%>' CssClass="form-control" ></asp:Label> </td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Informazioni economiche</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Fatturato:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("fatturato", "{0:C}")%>' CssClass="form-control" ></asp:Label></td>
                    <td class="form-label" style="text-align:end">Fatturato potenziale:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("fatturato_potenz", "{0:C}")%>' CssClass="form-control" ></asp:Label> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Fido richiesto:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("fido_richiesto", "{0:C}")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end">Fido concesso:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("fido_concesso", "{0:C}")%>' CssClass="form-control" ></asp:Label> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Scadenza fido:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("scadenza_fido", "{0:dd/MM/yyyy}")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Dipendenti:</td>
                    <td style="vertical-align:top" ><asp:label runat="server" text='<%# Eval("dipendenti")%>' CssClass="form-control" ></asp:Label> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Data fondazione:</td>
                    <td style="vertical-align:top" ><asp:Label runat="server" text='<%# Eval("fondazione", "{0:dd/MM/yyyy}")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Possedimenti:</td>
                    <td ><asp:TextBox runat="server" text='<%# Eval("possedimenti")%>' TextMode="MultiLine" ReadOnly="true" CssClass="form-control" Width="200px" ></asp:TextBox> </td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Altre informazioni</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Forma di pagamento:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("pagamento")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end">Trasporto:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("trasporto")%>' CssClass="form-control"  ></asp:Label> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Note:</td>
                    <td ><asp:TextBox runat="server" text='<%# Eval("note")%>' TextMode="MultiLine" Width="200px" CssClass="form-control" ReadOnly="true" ></asp:TextBox> </td>
                </tr>
<%--                <tr class="acomtable-section-intest">
                    <td>Creazione e modifiche</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Creato da:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("created_by")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end">Creato il:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("created_date")%>' CssClass="form-control"  ></asp:Label> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Aggiornato da:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("updated_by")%>' CssClass="form-control" ></asp:Label> </td>
                    <td class="form-label" style="text-align:end">Aggiornato il:</td>
                    <td ><asp:Label runat="server" text='<%# Eval("data_aggiornamento")%>' CssClass="form-control"  ></asp:Label> </td>
                </tr>--%>
                <tr class="acomtable-section-intest">
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                </tr>
                <tr >
                    <td>
                        <asp:Button ID="cmd_modifica" Text="Modifica" OnClick="cmd_modifica_Click" runat="server" CssClass="btn btn-primary btn-hover" />
                        <asp:Button ID="cmd_nuovo" OnClick="cmd_nuovo_Click" Text="Nuovo" runat="server" CssClass="btn btn-primary btn-hover" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
      <InsertItemTemplate>
            <h3>Inserimento nuovo cliente</h3>       
            <hr />
            <table class="acomtable" >
                <tr>
                    <td class="form-label" style="text-align:right" >Codice cliente *:</td>
                    <td>
                       <asp:TextBox ID="codice" runat="server"  Text="" CssClass="form-control" ></asp:TextBox>
<%--                       <asp:RequiredFieldValidator runat="server" ValidationGroup="client" ID="required_code" ControlToValidate="codice" ErrorMessage="Inserire codice cliente" SetFocusOnError="true" Display="None" ></asp:RequiredFieldValidator>--%>
<%--                       <asp:CustomValidator runat="server" ID="duplicate_code" ValidationGroup="client" ControlToValidate="codice" ErrorMessage="Il codice cliente esiste già" OnServerValidate="duplicate_code_ServerValidate" SetFocusOnError="true" Display="None"></asp:CustomValidator>--%>
                    </td>
                    <td class="form-label" style="text-align:right" >Ragione sociale *:</td>
                    <td>
                        <asp:TextBox ID="ragione_sociale" runat="server"  Text='<%# Bind("ragione_sociale")%>' CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ValidationGroup="client" ControlToValidate="ragione_sociale" ErrorMessage="Inserire ragione sociale" SetFocusOnError="true" Display="None" ></asp:RequiredFieldValidator>               
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:right" >Canale:</td>
                    <td>
                        <asp:DropDownList ID="canalID" DataValueField="ID" DataTextField="canal_code"  runat="server" SelectMethod="Get_canale" AppendDataBoundItems="true" CssClass="form-control" >
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="form-label" style="text-align:right" >Agente:</td>
                    <td>
                        <asp:DropDownList ID="agentID" DataValueField="ID" DataTextField="name"  runat="server" SelectMethod="Get_agente" AppendDataBoundItems="true" CssClass="form-control" >
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td>Indirizzo</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="form-label" style="text-align:end" >Provincia:</td>
                    <td>
                        <asp:DropDownList ID="provinciaID"  AutoPostBack="true" DataValueField="ID" DataTextField="nome" runat="server" SelectMethod="Get_provincia" OnSelectedIndexChanged="provinciaID_SelectedIndexChanged" AppendDataBoundItems="true" CssClass="form-control" >
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="form-label" style="text-align:end">Comune:</td>
                    <td>
                        <asp:DropDownList ID="comuneID" DataValueField="ID"  AutoPostBack="true" DataTextField="nome" runat="server" OnDataBinding="comuneID_DataBinding" AppendDataBoundItems="true" OnSelectedIndexChanged="comuneID_SelectedIndexChanged" CssClass="form-control" >
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">CAP:</td>
                    <td><asp:TextBox ID="cap" runat="server" Text="" CssClass="form-control" ></asp:TextBox>
                        <asp:RegularExpressionValidator ErrorMessage="Cap è un campo numerico" ControlToValidate="cap" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9]*$" runat="server" />
                    </td>
                    <td class="form-label" style="text-align:end">Via/Piazza:</td>
                    <td><asp:TextBox ID="indirizzo" runat="server" Text="" CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td>Dati fiscali</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Codice fiscale:</td>
                    <td ><asp:TextBox ID="CF" runat="server" Text="" CssClass="form-control" ></asp:TextBox> </td>
                    <td class="form-label" style="text-align:end">P.Iva:</td>
                    <td ><asp:TextBox ID="piva" runat="server" Text="" CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">P.Iva CEE:</td>
                    <td ><asp:TextBox ID="pivaCEE" runat="server" Text="" CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Informazioni di contatto</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Telefono:</td>
                    <td ><asp:TextBox ID="telefono" runat="server" Text="" CssClass="form-control" ></asp:TextBox></td>
                    <td class="form-label" style="text-align:end">Email:</td>
                    <td ><asp:TextBox ID="email" runat="server" Text="" AutoCompleteType="Email"  TextMode="Email" CausesValidation="true"  CssClass="form-control" ></asp:TextBox> </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Modalità invio fatture:</td>
                    <td ><asp:TextBox ID="invio_fattura" runat="server" Text="" CssClass="form-control"  ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Dati bancari</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Banca:</td>
                    <td ><asp:TextBox ID="banca" runat="server" Text="" CssClass="form-control" ></asp:TextBox> </td>
                    <td class="form-label" style="text-align:end">Iban:</td>
                    <td ><asp:TextBox ID="iban" runat="server" Text="" CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Informazioni economiche</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Fatturato:</td>
                    <td ><asp:TextBox ID="fatturato" runat="server" Text="" CssClass="form-control" ></asp:TextBox>
                        <asp:RegularExpressionValidator ErrorMessage="Fatturato è un campo numerico" ControlToValidate="fatturato" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                    <td class="form-label" style="text-align:end">Fatturato potenziale:</td>
                    <td ><asp:TextBox ID="fatturato_potenz" runat="server" Text="" CssClass="form-control" ></asp:TextBox> 
                        <asp:RegularExpressionValidator ErrorMessage="Fatturato potenziale è un campo numerico" ControlToValidate="fatturato_potenz" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Fido richiesto:</td>
                    <td ><asp:TextBox ID="fido_richiesto" runat="server" Text="" CssClass="form-control" ></asp:TextBox>
                        <asp:RegularExpressionValidator ErrorMessage="Fido richiesto è un campo numerico" ControlToValidate="fido_richiesto" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                    <td class="form-label" style="text-align:end">Fido concesso:</td>
                    <td ><asp:TextBox ID="fido_concesso" runat="server" Text="" CssClass="form-control" ></asp:TextBox> 
                         <asp:RegularExpressionValidator ErrorMessage="Fido concesso è un campo numerico" ControlToValidate="fido_concesso" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Scadenza fido:</td>
                    <td >
                        <asp:TextBox ID="scadenza_fido" runat="server"  CssClass="form-control" ></asp:TextBox>
                        <asp:CalendarExtender ID="calextscadenzafido" runat="server" TargetControlID="scadenza_fido"  Format="dd/MM/yyyy"/>
                    </td>
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Dipendenti:</td>
                    <td style="vertical-align:top" ><asp:TextBox ID="dipendenti" runat="server" Text="" CssClass="form-control" ></asp:TextBox> 
                                                    <asp:RegularExpressionValidator ErrorMessage="Dipendenti è un campo numerico" ControlToValidate="dipendenti" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Data fondazione:</td>
                    <td style="vertical-align:top" >
                        <asp:TextBox ID="fondazione" runat="server" CssClass="form-control"  ></asp:TextBox>
                        <asp:CalendarExtender ID="calextfondazione" runat="server" TargetControlID="fondazione" Format="dd/MM/yyyy" />
                    </td>
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Possedimenti:</td>
                    <td ><asp:TextBox ID="possedimenti" runat="server" Text=""  TextMode="MultiLine" CssClass="form-control"></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Altre informazioni</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Forma di pagamento:</td>
                    <td >
                        <asp:DropDownList ID="pagamento" runat="server" DataValueField="ID"  DataTextField="pagamento" SelectMethod="Get_payment" AppendDataBoundItems="true" CssClass="form-control">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList> 
                    </td>
                    <td class="form-label" style="text-align:end">Trasporto:</td>
                    <td >
                        <asp:DropDownList ID="trasporto" runat="server" DataValueField="ID"  DataTextField="trasporto" SelectMethod="Get_transport" AppendDataBoundItems="true" CssClass="form-control">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Note:</td>
                    <td ><asp:TextBox ID="note" runat="server" Text=""  TextMode="MultiLine" CssClass="form-control"></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                </tr>
                <tr >
                    <td>
                        <asp:Button ID="cmd_insert" OnClick="cmd_insert_Click" CausesValidation="true" ValidationGroup="client" Text="Salva" runat="server" CssClass="btn btn-primary btn-hover" />
                        <asp:Button ID="cmd_cancel" OnClick="cmd_cancel_Click" Text="Annulla" runat="server" CssClass="btn btn-primary btn-hover"/>
                     </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <EditItemTemplate>
            <h3>Modifica cliente: <%# Eval("codice")%> - <%# Eval("ragione_sociale")%></h3>       
            <asp:HiddenField ID="ID"  Value='<%# Eval("ID")%>' runat="server" />
            <hr />
            <table class="acomtable" >
                <tr>
                    <td class="form-label" style="text-align:right" >Codice cliente *:</td>
                    <td>
                       <asp:TextBox ID="codice" runat="server"  Text='<%# Bind("codice")%>' CssClass="form-control" ></asp:TextBox>
                       <asp:RequiredFieldValidator runat="server" ValidationGroup="client" ControlToValidate="codice" ErrorMessage="Inserire codice cliente" SetFocusOnError="true" Display="None" ></asp:RequiredFieldValidator>
                       <asp:CustomValidator runat="server" ID="duplicate_code" ValidationGroup="client" ControlToValidate="codice" ErrorMessage="Il codice cliente esiste già" OnServerValidate="duplicate_code_ServerValidate" SetFocusOnError="true" Display="None"></asp:CustomValidator>
                    </td>
                    <td class="form-label" style="text-align:right" >Ragione sociale:</td>
                    <td>
                        <asp:TextBox ID="ragione_sociale" runat="server"  Text='<%# Bind("ragione_sociale")%>' CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ValidationGroup="client" ControlToValidate="ragione_sociale" ErrorMessage="Inserire ragione sociale" SetFocusOnError="true" Display="None" />
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:right" >Canale:</td>
                    <td>
                       <asp:DropDownList ID="canalID" DataValueField="ID" DataTextField="canal_code"  runat="server" SelectMethod="Get_canale" selectedvalue='<%# Bind("canalID")%>' AppendDataBoundItems="true" OnSelectedIndexChanged="canalID_SelectedIndexChanged" OnDataBound="canalID_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control">
                           <asp:ListItem Value="" Text=""></asp:ListItem>
                       </asp:DropDownList>
                       <asp:Label runat="server" ID="canal_annull" Text="Canale non attivo" ForeColor="Red" Visible="false"></asp:Label>
                    </td>
                    <td class="form-label" style="text-align:right" >Agente:</td>
                    <td>
                       <asp:DropDownList ID="agentID" DataValueField="ID" DataTextField="name"  runat="server" SelectMethod="Get_agente" selectedvalue='<%# Bind("agentID")%>' AppendDataBoundItems="true" OnSelectedIndexChanged="agentID_SelectedIndexChanged" OnDataBound="agentID_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control">
                           <asp:ListItem Value="" Text=""></asp:ListItem>
                       </asp:DropDownList>
                       <asp:Label runat="server" ID="agent_annull" Text="Agente non attivo" ForeColor="Red" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:right" >Disattivato:</td>
                    <td><asp:CheckBox ID="annull" runat="server" Checked='<%# Bind("annull")%>' ></asp:CheckBox></td>
                </tr>
               <tr class="acomtable-section-intest">
                    <td>Indirizzo</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="form-label" style="text-align:end" >Provincia:</td>
                    <td><asp:DropDownList ID="provinciaID"  AutoPostBack="true" DataValueField="ID" DataTextField="nome" runat="server" SelectMethod="Get_provincia" OnSelectedIndexChanged="provinciaID_SelectedIndexChanged" selectedvalue='<%# Bind("provinciaID")%>' AppendDataBoundItems="true" CssClass="form-control">
                       <asp:ListItem Value="" Text=""></asp:ListItem>
                       </asp:DropDownList>
                    </td>
                    <td class="form-label" style="text-align:end">Comune:</td>
                    <td><asp:DropDownList ID="comuneID" DataValueField="ID"  AutoPostBack="true" DataTextField="nome" runat="server" OnDataBinding="comuneID_DataBinding" selectedvalue='<%# Bind("comuneID")%>' AppendDataBoundItems="true" OnSelectedIndexChanged="comuneID_SelectedIndexChanged" CssClass="form-control">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">CAP:</td>
                    <td><asp:TextBox ID="cap" runat="server" Text='<%# Bind("cap")%>' CssClass="form-control"></asp:TextBox>
                        <asp:RegularExpressionValidator ErrorMessage="Cap è un campo numerico" ControlToValidate="cap" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9]*$" runat="server" />
                    </td>
                    <td class="form-label" style="text-align:end">Via/Piazza:</td>
                    <td><asp:TextBox ID="indirizzo" runat="server" Text='<%# Bind("indirizzo")%>' CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td>Dati fiscali</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
               <tr >
                    <td class="form-label" style="text-align:end">Codice fiscale:</td>
                    <td ><asp:TextBox ID="CF" runat="server" Text='<%# Bind("CF")%>' CssClass="form-control"></asp:TextBox></td>
                    <td class="form-label" style="text-align:end">P.Iva:</td>
                    <td ><asp:TextBox ID="piva" runat="server" Text='<%# Bind("piva")%>' CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">P.Iva CEE:</td>
                    <td > <asp:TextBox ID="pivaCEE" runat="server" Text='<%# Bind("pivaCEE")%>' CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Informazioni di contatto</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Telefono:</td>
                    <td ><asp:TextBox ID="telefono" runat="server" Text='<%# Bind("telefono")%>' CssClass="form-control" ></asp:TextBox></td>
                    <td class="form-label" style="text-align:end">Email:</td>
                    <td ><asp:TextBox ID="email" runat="server" Text='<%# Bind("email")%>'  TextMode="Email" AutoCompleteType="Email" CssClass="form-control"></asp:TextBox></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Modalità invio fatture:</td>
                    <td ><asp:TextBox ID="invio_fattura" runat="server" Text='<%# Bind("invio_fattura")%>' CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Dati bancari</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Banca:</td>
                    <td ><asp:TextBox ID="banca" runat="server" Text='<%# Bind("banca")%>' CssClass="form-control" ></asp:TextBox></td>
                    <td class="form-label" style="text-align:end">Iban:</td>
                    <td ><asp:TextBox ID="iban" runat="server" Text='<%# Bind("iban")%>' CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Informazioni economiche</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Fatturato:</td>
                    <td ><asp:TextBox ID="fatturato" runat="server" Text='<%# Bind("fatturato")%>' CssClass="form-control" ></asp:TextBox>
                         <asp:RegularExpressionValidator ErrorMessage="Fatturato è un campo numerico" ControlToValidate="fatturato" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                    <td class="form-label" style="text-align:end">Fatturato potenziale:</td>
                    <td ><asp:TextBox ID="fatturato_potenz" runat="server" Text='<%# Bind("fatturato_potenz")%>' CssClass="form-control" ></asp:TextBox>
                         <asp:RegularExpressionValidator ErrorMessage="Fatturato potenziale è un campo numerico" ControlToValidate="fatturato_potenz" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Fido richiesto:</td>
                    <td ><asp:TextBox ID="fido_richiesto" runat="server" Text='<%# Bind("fido_richiesto")%>' CssClass="form-control" ></asp:TextBox> 
                         <asp:RegularExpressionValidator ErrorMessage="Fido richiesto è un campo numerico" ControlToValidate="fido_richiesto" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                    <td class="form-label" style="text-align:end">Fido concesso:</td>
                    <td ><asp:TextBox ID="fido_concesso" runat="server" Text='<%# Bind("fido_concesso")%>' CssClass="form-control" ></asp:TextBox> 
                         <asp:RegularExpressionValidator ErrorMessage="Fido concesso è un campo numerico" ControlToValidate="fido_concesso" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Scadenza fido:</td>
                    <td><asp:TextBox ID="scadenza_fido" runat="server" Text='<%# Bind("scadenza_fido", "{0:dd/MM/yyyy}")%>' CssClass="form-control"></asp:TextBox> 
                        <asp:CalendarExtender ID="calextscadenzafido" runat="server" TargetControlID="scadenza_fido"  Format="dd/MM/yyyy" />
                    </td>
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Dipendenti:</td>
                    <td style="vertical-align:top" ><asp:TextBox ID="dipendenti" runat="server" Text='<%# Bind("dipendenti")%>' CssClass="form-control"  ></asp:TextBox> 
                                                    <asp:RegularExpressionValidator ErrorMessage="Dipendenti è un campo numerico" ControlToValidate="dipendenti" Display="None" SetFocusOnError="true" ValidationGroup="client" ValidationExpression="^[0-9.,]*$" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Data fondazione:</td>
                    <td style="vertical-align:top" ><asp:TextBox ID="fondazione" runat="server" Text='<%# Bind("fondazione", "{0:dd/MM/yyyy}")%>' CssClass="form-control" ></asp:TextBox>  
                                                    <asp:CalendarExtender ID="calextfondazione" runat="server" TargetControlID="fondazione" Format="dd/MM/yyyy" />
                    </td>
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Possedimenti:</td>
                    <td ><asp:TextBox ID="possedimenti" runat="server" Text='<%# Bind("possedimenti")%>' TextMode="MultiLine" CssClass="form-control" ></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td >Altre informazioni</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end">Forma di pagamento:</td>
                    <td ><asp:DropDownList ID="pagamento" runat="server" DataValueField="ID"  DataTextField="pagamento" SelectMethod="Get_payment" selectedvalue='<%# Bind("paymentID")%>' AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="pagamento_SelectedIndexChanged" OnDataBound="pagamento_SelectedIndexChanged" CssClass="form-control">
                            <asp:ListItem Value="" Text=""></asp:ListItem>
                         </asp:DropDownList>
                         <asp:Label ID="pagam_annull" runat="server" Text="Pagamento non attivo" Visible="false" ForeColor="Red"></asp:Label> 
                    </td>   
                    <td class="form-label" style="text-align:end">Trasporto:</td>
                    <td >
                        <asp:DropDownList ID="trasporto" AutoPostBack="true" runat="server" DataValueField="ID"  DataTextField="trasporto" SelectMethod="Get_transport" selectedvalue='<%# Bind("transportID")%>' AppendDataBoundItems="true" OnSelectedIndexChanged="trasporto_SelectedIndexChanged" OnDataBound="trasporto_SelectedIndexChanged" CssClass="form-control">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="trasp_annull" runat="server" Text="Trasporto non attivo" Visible="false" ForeColor="Red"></asp:Label> 
                    </td>
                </tr>
                <tr >
                    <td class="form-label" style="text-align:end; vertical-align:top; padding-top:8px">Note:</td>
                    <td ><asp:TextBox ID="note" runat="server" Text='<%# Bind("note")%>' TextMode="MultiLine" CssClass="form-control"></asp:TextBox></td>
                </tr>
                <tr class="acomtable-section-intest">
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                    <td style="height:10px"></td>
                </tr>
                <tr >
                    <td>
                        <asp:Button ID="cmd_update" OnClick="cmd_update_Click" CausesValidation="true" ValidationGroup="client" Text="Salva" runat="server" CssClass="btn btn-primary btn-hover" />
                        <asp:Button ID="cmd_cancel" OnClick="cmd_cancel_Click" Text="Annulla" runat="server" CssClass="btn btn-primary btn-hover"/>
                     </td>
                </tr>
         
            </table>
        </EditItemTemplate>
    </asp:FormView>
    </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <p>
        <asp:Button Text="Stampa Anagrafica cliente" CssClass="btn btn-primary btn-hover" runat="server" ID="btn_stampa_anagrafica" OnClick="btn_stampa_anagrafica_Click" />
    </p>

    <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="updateclient">
        <ProgressTemplate>  
            <div class="updateprogress-modal">
                <div class="updateprogress-center">
                    <asp:Label Text="Aggiornamento in corso..." runat="server" ForeColor="Black" BackColor="White" />    
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="contact_panel">
        <ProgressTemplate>  
            <div class="updateprogress-modal">
                <div class="updateprogress-center">
                    <asp:Label Text="Aggiornamento in corso..." runat="server" ForeColor="Black" BackColor="White" />    
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>


    <asp:UpdatePanel runat="server" ID="contact_panel">
    <ContentTemplate>            
    <br />
    <h3>Contatti</h3>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="contact_insert"/>
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="contact_edit"/>
        <br />
         <asp:ListView ID="ListViewContacts" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceContacts" InsertItemPosition="LastItem" OnItemInserting="ListViewContacts_ItemInserting">
            <AlternatingItemTemplate>
                <tr>
                    <td>
                        <asp:Button ID="EditButton" runat="server" CausesValidation="false" CommandName="Edit" CssClass="btn btn-primary btn-hover" Text="Modifica" />
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
                        <asp:Label ID="cellulareLabel" runat="server" Text='<%# Eval("cellulare") %>' />
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
                        <asp:Label ID="created_by" runat="server" Text='<%# Eval("created_by")%>' Visible="false" />
                        <asp:Label ID="created_date" runat="server" Text='<%# Eval("created_date")%>' Visible="false" />
                        <asp:Label ID="updated_by" runat="server" Text='<%# Eval("updated_by")%>' Visible="false" />
                        <asp:Label ID="updated_date" runat="server" Text='<%# Eval("updated_date")%>' Visible="false" />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-primary btn-hover" Text="Salva" ValidationGroup="contact_edit" />
                        <asp:Button ID="CancelButton" runat="server" CausesValidation="false" CommandName="Cancel" CssClass="btn btn-primary btn-hover" Text="Annulla" />
                    </td>
                    <td>
                        <asp:TextBox ID="nomeTextBox" runat="server" CssClass="form-control" Text='<%# Bind("nome") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="cognomeTextBox" runat="server" CssClass="form-control" Text='<%# Bind("cognome") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cognomeTextBox" Display="None" ErrorMessage="Inserire cognome contatto" SetFocusOnError="true" ValidationGroup="contact_edit" />
                    </td>
                    <td>
                        <asp:TextBox ID="telefonoTextBox" runat="server" CssClass="form-control" Text='<%# Bind("telefono") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="cellulareTextBox" runat="server" CssClass="form-control" Text='<%# Bind("cellulare") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="emailTextBox" runat="server" CssClass="form-control" Text='<%# Bind("email") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="funzioneTextBox" runat="server" CssClass="form-control" Text='<%# Bind("funzione") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="noteTextBox" runat="server" CssClass="form-control" Text='<%# Bind("note") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullTextBox" runat="server" Checked='<%# Bind("annull") %>' />
                        <asp:Label ID="IDLabel1" runat="server" CssClass="form-control" Text='<%# Eval("ID") %>' Visible="false" />
                        <asp:TextBox ID="clientIDTextBox" runat="server" CssClass="form-control" Text='<%# Bind("clientID") %>' Visible="false" />
                        <asp:TextBox ID="officeIDTextBox" runat="server" CssClass="form-control" Text='<%# Bind("officeID") %>' Visible="false" />
                        <asp:label ID="created_by" runat="server" Text='<%# Bind("created_by")%>' Visible="false" />
                        <asp:label ID="created_date" runat="server" Text='<%# Bind("created_date")%>' Visible="false" />
                        <asp:label ID="updated_by" runat="server" Text='<%# Bind("updated_by")%>'  Visible="false"/>
                        <asp:label ID="updated_date" runat="server" Text='<%# Bind("updated_date")%>'  Visible="false" />
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
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" CssClass="btn btn-primary btn-hover" Text="Salva" ValidationGroup="contact_insert" />
                        <asp:Button ID="CancelButton" runat="server" CausesValidation="false" CommandName="Cancel" CssClass="btn btn-primary btn-hover" Text="Annulla" />
                    </td>
                    <td>
                        <asp:TextBox ID="nomeTextBox" runat="server" CssClass="form-control" Text='<%# Bind("nome") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="cognomeTextBox" runat="server" CssClass="form-control" Text='<%# Bind("cognome") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cognomeTextBox" Display="None" ErrorMessage="Inserire cognome contatto" SetFocusOnError="true" ValidationGroup="contact_insert" />
                    </td>
                    <td>
                        <asp:TextBox ID="telefonoTextBox" runat="server" CssClass="form-control" Text='<%# Bind("telefono") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="cellulareTextBox" runat="server" CssClass="form-control" Text='<%# Bind("cellulare") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="emailTextBox" runat="server" CssClass="form-control" Text='<%# Bind("email") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="funzioneTextBox" runat="server" CssClass="form-control" Text='<%# Bind("funzione") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="noteTextBox" runat="server" CssClass="form-control" Text='<%# Bind("note") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="annullTextBox" runat="server" Checked='<%# Bind("annull") %>' />
                        <asp:TextBox ID="clientIDTextBox" runat="server" CssClass="form-control" Text='<%# Bind("clientID")%>' Visible="false" />
                        <asp:TextBox ID="officeIDTextBox" runat="server" CssClass="form-control" Text='<%# Bind("officeID") %>' Visible="false" />
                        <asp:Label ID="created_by" runat="server" Text='<%# Eval("created_by")%>' Visible="false" />
                        <asp:Label ID="created_date" runat="server" Text='<%# Eval("created_date")%>' Visible="false" />
                        <asp:Label ID="updated_by" runat="server" Text='<%# Eval("updated_by")%>' Visible="false" />
                        <asp:Label ID="updated_date" runat="server" Text='<%# Eval("updated_date")%>' Visible="false" />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Button ID="EditButton" runat="server" CausesValidation="false" CommandName="Edit" CssClass="btn btn-primary btn-hover" Text="Modifica" />
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
                        <asp:Label ID="cellulareLabel" runat="server" Text='<%# Eval("cellulare") %>' />
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
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("created_by")%>' Visible="false" />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("created_date")%>' Visible="false" />
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("updated_by")%>' Visible="false" />
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("updated_date")%>' Visible="false" />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="1" class="table table-hover table-bordered table-responsive" style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr runat="server" style="background-color:#DCF5FD">
                                    <th runat="server"></th>
                                    <th runat="server">Nome</th>
                                    <th runat="server">Cognome</th>
                                    <th runat="server">Telefono</th>
                                    <th runat="server">Cellulare</th>
                                    <th runat="server">Email</th>
                                    <th runat="server">Funzione</th>
                                    <th runat="server">Note</th>
                                    <th runat="server">Disattivo</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server" class="table table-hover table-bordered table-responsive">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server" class="table table-hover table-bordered table-responsive">
                        <td runat="server" style="text-align: center;background-color: #DCF5FD;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;"></td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="background-color: #FFCC66;font-weight: bold;color: #000080;">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CausesValidation="false" CommandName="Edit" CssClass="btn btn-primary btn-hover" Text="Modifica" />
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
                        <asp:Label ID="cellulareLabel" runat="server" Text='<%# Eval("cellulare") %>' />
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
                        <asp:Label ID="created_by" runat="server" Text='<%# Eval("created_by")%>' Visible="false" />
                        <asp:Label ID="created_date" runat="server" Text='<%# Eval("created_date")%>' Visible="false" />
                        <asp:Label ID="updated_by" runat="server" Text='<%# Eval("updated_by")%>' Visible="false" />
                        <asp:Label ID="updated_date" runat="server" Text='<%# Eval("updated_date")%>' Visible="false" />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>

    </ContentTemplate>
</asp:UpdatePanel>
<asp:SqlDataSource ID="SqlDataSourceContacts" runat="server" OnUpdating="SqlDataSourceContacts_Updating" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" DeleteCommand="DELETE FROM [contactnames] WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([cognome] = @original_cognome) OR ([cognome] IS NULL AND @original_cognome IS NULL)) AND (([telefono] = @original_telefono) OR ([telefono] IS NULL AND @original_telefono IS NULL)) AND (([cellulare] = @original_cellulare) OR ([cellulare] IS NULL AND @original_cellulare IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([funzione] = @original_funzione) OR ([funzione] IS NULL AND @original_funzione IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([clientID] = @original_clientID) OR ([clientID] IS NULL AND @original_clientID IS NULL)) AND (([officeID] = @original_officeID) OR ([officeID] IS NULL AND @original_officeID IS NULL)) AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))" InsertCommand="INSERT INTO [contactnames] ([nome], [cognome], [telefono], [cellulare], [email], [funzione], [note], [annull], [clientID], [officeID], [created_by], [created_date], [updated_by], [updated_date]) VALUES (@nome, @cognome, @telefono, @cellulare, @email, @funzione, @note, @annull, @clientID, @officeID, @created_by, @created_date, @updated_by, @updated_date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [nome], [cognome], [telefono], [cellulare], [email], [funzione], [note], [annull], [clientID], [officeID], [created_by], [created_date], [updated_by], [updated_date] FROM [contactnames] WHERE ([clientID] = @clientID)" UpdateCommand="UPDATE [contactnames] SET [nome] = @nome, [cognome] = @cognome, [telefono] = @telefono, [cellulare] = @cellulare, [email] = @email, [funzione] = @funzione, [note] = @note, [annull] = @annull, [clientID] = @clientID, [officeID] = @officeID, [created_by] = @created_by, [created_date] = @created_date, [updated_by] = @updated_by, [updated_date] = @updated_date WHERE [ID] = @original_ID AND (([nome] = @original_nome) OR ([nome] IS NULL AND @original_nome IS NULL)) AND (([cognome] = @original_cognome) OR ([cognome] IS NULL AND @original_cognome IS NULL)) AND (([telefono] = @original_telefono) OR ([telefono] IS NULL AND @original_telefono IS NULL)) AND (([cellulare] = @original_cellulare) OR ([cellulare] IS NULL AND @original_cellulare IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([funzione] = @original_funzione) OR ([funzione] IS NULL AND @original_funzione IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND [annull] = @original_annull AND (([clientID] = @original_clientID) OR ([clientID] IS NULL AND @original_clientID IS NULL)) AND (([officeID] = @original_officeID) OR ([officeID] IS NULL AND @original_officeID IS NULL)) AND (([created_by] = @original_created_by) OR ([created_by] IS NULL AND @original_created_by IS NULL)) AND (([created_date] = @original_created_date) OR ([created_date] IS NULL AND @original_created_date IS NULL)) AND (([updated_by] = @original_updated_by) OR ([updated_by] IS NULL AND @original_updated_by IS NULL)) AND (([updated_date] = @original_updated_date) OR ([updated_date] IS NULL AND @original_updated_date IS NULL))">
             <DeleteParameters>
                 <asp:Parameter Name="original_ID" Type="Int32" />
                 <asp:Parameter Name="original_nome" Type="String" />
                 <asp:Parameter Name="original_cognome" Type="String" />
                 <asp:Parameter Name="original_telefono" Type="String" />
                 <asp:Parameter Name="original_cellulare" Type="String" />
                 <asp:Parameter Name="original_email" Type="String" />
                 <asp:Parameter Name="original_funzione" Type="String" />
                 <asp:Parameter Name="original_note" Type="String" />
                 <asp:Parameter Name="original_annull" Type="Boolean" />
                 <asp:Parameter Name="original_clientID" Type="Int32" />
                 <asp:Parameter Name="original_officeID" Type="Int32" />
                 <asp:Parameter Name="original_created_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                 <asp:Parameter Name="original_updated_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
             </DeleteParameters>
             <InsertParameters>
                 <asp:Parameter Name="nome" Type="String" />
                 <asp:Parameter Name="cognome" Type="String" />
                 <asp:Parameter Name="telefono" Type="String" />
                 <asp:Parameter Name="cellulare" Type="String" />
                 <asp:Parameter Name="email" Type="String" />
                 <asp:Parameter Name="funzione" Type="String" />
                 <asp:Parameter Name="note" Type="String" />
                 <asp:Parameter Name="annull" Type="Boolean" />
                 <asp:Parameter Name="clientID" Type="Int32" />
                 <asp:Parameter Name="officeID" Type="Int32" />
                 <asp:Parameter Name="created_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="created_date" />
                 <asp:Parameter Name="updated_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="updated_date" />
             </InsertParameters>
             <SelectParameters>
                 <asp:QueryStringParameter DefaultValue="0" Name="clientID" QueryStringField="ID" Type="Int32" />
             </SelectParameters>
             <UpdateParameters>
                 <asp:Parameter Name="nome" Type="String" />
                 <asp:Parameter Name="cognome" Type="String" />
                 <asp:Parameter Name="telefono" Type="String" />
                 <asp:Parameter Name="cellulare" Type="String" />
                 <asp:Parameter Name="email" Type="String" />
                 <asp:Parameter Name="funzione" Type="String" />
                 <asp:Parameter Name="note" Type="String" />
                 <asp:Parameter Name="annull" Type="Boolean" />
                 <asp:Parameter Name="clientID" Type="Int32" />
                 <asp:Parameter Name="officeID" Type="Int32" />
                 <asp:Parameter Name="created_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="created_date" />
                 <asp:Parameter Name="updated_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="updated_date" />
                 <asp:Parameter Name="original_ID" Type="Int32" />
                 <asp:Parameter Name="original_nome" Type="String" />
                 <asp:Parameter Name="original_cognome" Type="String" />
                 <asp:Parameter Name="original_telefono" Type="String" />
                 <asp:Parameter Name="original_cellulare" Type="String" />
                 <asp:Parameter Name="original_email" Type="String" />
                 <asp:Parameter Name="original_funzione" Type="String" />
                 <asp:Parameter Name="original_note" Type="String" />
                 <asp:Parameter Name="original_annull" Type="Boolean" />
                 <asp:Parameter Name="original_clientID" Type="Int32" />
                 <asp:Parameter Name="original_officeID" Type="Int32" />
                 <asp:Parameter Name="original_created_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="original_created_date" />
                 <asp:Parameter Name="original_updated_by" Type="String" />
                 <asp:Parameter DbType="DateTime2" Name="original_updated_date" />
             </UpdateParameters>
        </asp:SqlDataSource>
</asp:Content>
