<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="OfferteIns.aspx.vb" Inherits="Acom1.OfferteIns1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <asp:UpdatePanel runat="server" ID="UpdatePanelDetail">
        <ContentTemplate>
            <asp:Label runat="server" ID="errormsg" EnableViewState="false" Text="" CssClass="alert alert-danger" Visible="false"></asp:Label>
            <asp:ValidationSummary runat="server" CssClass=" alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" ValidationGroup="offer_detail" />    
        <div>
            <asp:FormView runat="server" ID="FormOfferIns" SelectMethod="FormOfferIns_GetItem" InsertMethod="FormOfferIns_InsertItem" OnItemInserted="FormOfferIns_ItemInserted" UpdateMethod="FormOfferIns_UpdateItem" OnItemUpdated="FormOfferIns_ItemUpdated" DataKeyNames="ID" >
                <ItemTemplate>
                    <h3>Dettaglio offerta: <%# Eval("offer_code")%> - <%# Eval("riferimento")%></h3>
                    <hr />
                    <h4>Intestazione</h4>
                    <asp:HiddenField ID="ID"  Value='<%# Eval("ID")%>' runat="server" />
                    <table class="acomtable">
                        <tr>
                            <td class="form-label" style="text-align:right" >Agente *:</td>
                            <td><asp:Label ID="AgentID" Text='<%# Eval("agentname")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Data *:</td>
                            <td><asp:Label ID="data" Text='<%# Eval("data", "{0:dd/MM/yyyy}")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Valida fino al *:</td>
                            <td><asp:Label ID="data_val" Text='<%# Eval("data_valid", "{0:dd/MM/yyyy}")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr >
                            <td class="form-label" style="text-align:right" >Cliente *:</td>
                            <td><asp:Label ID="clienteID" Text='<%# Eval("ragione_sociale")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Filiale:</td>
                            <td><asp:Label ID="officeID" Text='<%# Eval("nome")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr >
                            <td class="form-label" style="text-align:right" >Contatto:</td>
                            <td><asp:Label ID="contactID" Text='<%# Eval("cognome") & " " & Eval("nome_contatto")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Riferimento offerta:</td>
                            <td><asp:Label ID="riferimento" Text='<%# Eval("riferimento")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Famiglia:</td>
                            <td><asp:Label ID="familyID" Text='<%# Eval("family_name")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr >
                            <td class="form-label" style="text-align:right" >Offerta esterna:</td>
                            <td><asp:Label ID="offerta_est" Text='<%# Eval("offer_est")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Importo:</td>
                            <td><asp:Label ID="importo" Text='<%# Eval("importo", "{0:C}")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Pagamento:</td>
                            <td><asp:Label ID="paymentID" Text='<%# Eval("pagamento")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Resa:</td>
                            <td><asp:Label ID="resaID" Text='<%# Eval("resa_desc")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Trasporto:</td>
                            <td><asp:Label ID="transportID" Text='<%# Eval("trasporto")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Costo di trasporto:</td>
                            <td><asp:Label ID="costo_trasp" Text='<%# Eval("costo_trasporto", "{0:C}")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Consegna:</td>
                            <td><asp:Label ID="consegna" Text='<%# Eval("consegna")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Garanzia:</td>
                            <td><asp:Label ID="garanziaID" Text='<%# Eval("garanzia_desc")%>' runat="server" CssClass="form-control"/></td>
                        </tr>
                        <tr >
                            <td class="form-label" style="text-align:right" >Imballo:</td>
                            <td><asp:Label ID="imballo" Text='<%# Eval("imballo")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Note:</td>
                            <td><asp:textbox ID="note" Text='<%# Eval("note")%>' runat="server" CssClass="form-control" TextMode="MultiLine" ReadOnly="true"/></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr >
                            <td class="form-label" style="text-align:right" >Stato:</td>
                            <td><asp:Label ID="stato" Text='<%# Eval("stato")%>' runat="server" CssClass="form-control"/></td>
                            <td class="form-label" style="text-align:right" >Annullata:</td>
                            <td><asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' Enabled="false" ></asp:CheckBox></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr >
                            <td><asp:Button ID="cmd_modifica" Text="Modifica" runat="server" CssClass="btn btn-primary btn-hover" OnClick="cmd_modifica_Click" /></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="created_by" Text='<%# Eval("created_by")%>' Visible="false"></asp:Label>
                                <asp:Label runat="server" ID="created_date" Text='<%# Eval("created_date")%>' Visible="false" ></asp:Label>
                                <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updated_by")%>' Visible="false"></asp:Label>
                                <asp:Label runat="server" ID="updated_date" Text='<%# Eval("updated_date")%>' Visible="false"></asp:Label>
                                <asp:Label runat="server" ID="offer_num" Text='<%# Eval("offer_num")%>' Visible="false"></asp:Label>
                            </td>
                        </tr>

                    </table>
                </ItemTemplate>
                <EditItemTemplate>
                    <h3>Modifica offerta: <%# Eval("offer_code")%> - <%# Eval("riferimento")%></h3>
                    <hr />
                    <h4>Intestazione</h4>
                    <h5>I campi contrassegnati con * sono obbligatori</h5>
                    <asp:HiddenField ID="ID"  Value='<%# Eval("ID")%>' runat="server" />
                    <table class="acomtable">
                        <tr>
                            <td class="form-label" style="text-align:right" >Agente *:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="agentID" DataValueField="ID" DataTextField="name" SelectMethod="Get_agent" AppendDataBoundItems="true" selectedvalue='<%# Bind("agentID")%>' OnSelectedIndexChanged="agentID_SelectedIndexChanged" OnDataBound="agentID_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="agent_annull" Text="Agente non attivo" Visible="false" ForeColor="Red"></asp:Label>
                                <asp:RequiredFieldValidator ErrorMessage="Inserire agente" ControlToValidate="agentID" runat="server" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Data *:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="data" Text='<%# Bind("data", "{0:dd/MM/yyyy}")%>' CssClass="form-control" ></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data" Format="dd/MM/yyyy" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data" ErrorMessage="Inserire data preventivo" ID="RequiredData" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </td>
                            <td class="form-label" style="text-align:right" >Valida fino al *:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="data_val" Text='<%# Bind("data_valid", "{0:dd/MM/yyyy}")%>' CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data_val" Format="dd/MM/yyyy" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data_val" ErrorMessage="Inserire data validità" ID="RequiredDatavalid" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Cliente *:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="clienteID" AutoPostBack="true" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client" AppendDataBoundItems="true" selectedvalue='<%# Bind("clientID")%>' OnSelectedIndexChanged="DDLClient_SelectedIndexChanged" OnDataBound="DDLClient_SelectedIndexChanged" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="client_annull" Text="Cliente non attivo" Visible="false" ForeColor="Red"></asp:Label>
                                <asp:RequiredFieldValidator ErrorMessage="Inserire cliente" ControlToValidate="clienteID" runat="server" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true" />
                            </td>
                            <td class="form-label" style="text-align:right" >Filiale:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="officeID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" AppendDataBoundItems="true" selectedvalue='<%# Bind("officeID")%>' OnDataBinding="DDLOffice_DataBinding" OnSelectedIndexChanged="officeID_SelectedIndexChanged" OnDataBound="officeID_SelectedIndexChanged" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="office_annull" Text="Filiale non attiva" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Contatto:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="contactID" AutoPostBack="true" DataValueField="ID" DataTextField="cognome"  AppendDataBoundItems="true" selectedvalue='<%# Bind("contactID")%>' OnDataBinding="DDLContact_DataBinding" OnSelectedIndexChanged="contactID_SelectedIndexChanged" OnDataBound="contactID_SelectedIndexChanged" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="contact_annull" Text="Contatto non attivo" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Riferimento offerta:</td>
                            <td><asp:TextBox runat="server"  ID="riferimento" Text='<%# Bind("riferimento")%>' CssClass="form-control" ></asp:TextBox></td>
                            <td class="form-label" style="text-align:right" >Famiglia:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="familyID" AutoPostBack="true" DataValueField="ID" DataTextField="family_name" SelectMethod="Get_families" AppendDataBoundItems="true" selectedvalue='<%# Bind("familyID")%>' OnSelectedIndexChanged="familyID_SelectedIndexChanged" OnDataBound="familyID_SelectedIndexChanged" CssClass="form-control">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="family_annull" Text="Famiglia non attivo" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Offerta esterna:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="offerta_est" Text='<%# Bind("offer_est")%>' AutoPostBack="true" OnTextChanged="offerta_est_TextChanged" CssClass="form-control" ></asp:TextBox>
                            </td>
                            <td class="form-label" style="text-align:right" >Importo:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="importo" Text='<%# Bind("importo")%>' Enabled="false" CssClass="form-control" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Pagamento:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="paymentID" AutoPostBack="true" DataValueField="ID" DataTextField="pagamento" SelectMethod="Get_payment" AppendDataBoundItems="true" selectedvalue='<%# Bind("paymentID")%>' OnSelectedIndexChanged="paymentID_SelectedIndexChanged" OnDataBound="paymentID_SelectedIndexChanged" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="pagam_annull" Text="Pagamento non attivo" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                            <td class="form-label" style="text-align:right" >Resa:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="resaID" DataValueField="ID" DataTextField="resa_desc" SelectMethod="Get_resa" AppendDataBoundItems="true" selectedvalue='<%# Bind("resaID")%>' OnSelectedIndexChanged="resaID_SelectedIndexChanged" OnDataBound="resaID_SelectedIndexChanged" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="resa_annull" Text="Resa non attiva" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Trasporto:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="transportID" AutoPostBack="true" DataValueField="ID" DataTextField="trasporto" SelectMethod="Get_transport" AppendDataBoundItems="true" selectedvalue='<%# Bind("transportID")%>' OnSelectedIndexChanged="transportID_SelectedIndexChanged" OnDataBound="transportID_SelectedIndexChanged" CssClass="form-control">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="trasp_annull" Text="Trasporto non attivo" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                            <td class="form-label" style="text-align:right" >Costo di trasporto:</td>
                            <td>
                                <asp:TextBox runat="server" ID="costo_trasp" Text='<%# Bind("costo_trasporto")%>' CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Consegna:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="consegna" Text='<%# Bind("consegna")%>' CssClass="form-control" ></asp:TextBox>
                            </td>
                            <td class="form-label" style="text-align:right" >Garanzia:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="garanziaID" DataValueField="ID" DataTextField="garanzia_desc" SelectMethod="Get_garanzia" AppendDataBoundItems="true" selectedvalue='<%# Bind("garanziaID")%>' OnSelectedIndexChanged="garanziaID_SelectedIndexChanged" OnDataBound="garanziaID_SelectedIndexChanged" CssClass="form-control">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="garanzia_annull" Text="Garanzia non attiva" Visible="false" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Imballo:</td>
                            <td><asp:TextBox runat="server" ID="imballo" Text='<%# Bind("imballo")%>' CssClass="form-control"></asp:TextBox></td>
                            <td class="form-label" style="text-align:right" >Note:</td> 
                            <td><asp:TextBox runat="server" ID="note" Text='<%# Bind("note")%>' TextMode="MultiLine" CssClass="form-control"></asp:TextBox></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Stato:</td>
                            <td>
                                <asp:DropDownList runat="server"  ID="stato" selectedvalue='<%# Bind("stato")%>' AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Text="In attesa"></asp:ListItem>
                                    <asp:ListItem Text="Vinto"></asp:ListItem>
                                    <asp:ListItem Text="Perso"></asp:ListItem>
                                    <asp:ListItem Text="Aggiornato"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="form-label" style="text-align:right" >Annullata:</td>
                            <td><asp:CheckBox runat="server" ID="annull" Checked='<%# Bind("annull")%>' Enabled="true" ></asp:CheckBox></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="cmd_aggiorna" Text="Salva" runat="server" CssClass="btn btn-primary btn-hover" OnClick="cmd_aggiorna_Click" ValidationGroup="offer_detail" CausesValidation="true" />
                                <asp:Button ID="cmd_cancella" Text="Annulla" runat="server" CssClass="btn btn-primary btn-hover" OnClick="cmd_cancella_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox runat="server"  ID="offer_num" Text='<%# Bind("offer_num")%>' Visible="false" ></asp:TextBox>
                                <asp:TextBox runat="server"  ID="offer_vers" Text='<%# Bind("offer_vers")%>' Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <h3>Inserimento nuova offerta</h3>
                    <hr />
                    <h4>Intestazione</h4>
                    <h5>I campi contrassegnati con * sono obbligatori</h5>
                    <table class="acomtable">
                        <tr>
                            <td class="form-label" style="text-align:right" >Agente *:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="agentID" DataValueField="ID" DataTextField="name" SelectMethod="Get_agent" AppendDataBoundItems="true"  CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ErrorMessage="Inserire agente" ControlToValidate="agentID" runat="server" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Data *:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="data" Text="" CssClass="form-control" ></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data" Format="dd/MM/yyyy" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data" ErrorMessage="Inserire data preventivo" ID="RequiredData" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </td>
                            <td class="form-label" style="text-align:right" >Valida fino al *:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="data_val" Text="" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data_val" Format="dd/MM/yyyy" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data_val" ErrorMessage="Inserire data validità" ID="RequiredDatavalid" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Cliente *:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="clienteID" AutoPostBack="true" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client" AppendDataBoundItems="true" OnSelectedIndexChanged="DDLClient_SelectedIndexChanged"  CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ErrorMessage="Inserire cliente" ControlToValidate="clienteID" runat="server" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true" />
                            </td>
                            <td class="form-label" style="text-align:right" >Filiale:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="officeID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" AppendDataBoundItems="true" OnDataBinding="DDLOffice_DataBinding" OnSelectedIndexChanged="officeID_SelectedIndexChanged" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Contatto:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="contactID" DataValueField="ID" DataTextField="cognome"  AppendDataBoundItems="true" selectedvalue='<%# Bind("contactID")%>' OnDataBinding="DDLContact_DataBinding" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Riferimento offerta:</td>
                            <td><asp:TextBox runat="server"  ID="riferimento" Text="" CssClass="form-control" ></asp:TextBox></td>
                            <td class="form-label" style="text-align:right" >Famiglia:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="familyID" DataValueField="ID" DataTextField="family_name" SelectMethod="Get_families" AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Offerta esterna:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="offerta_est" Text="" AutoPostBack="true" OnTextChanged="offerta_est_TextChanged" CssClass="form-control" ></asp:TextBox>
                            </td>
                            <td class="form-label" style="text-align:right" >Importo:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="importo" Text="" Enabled="false" CssClass="form-control" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Pagamento:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="paymentID" DataValueField="ID" DataTextField="pagamento" SelectMethod="Get_payment" AppendDataBoundItems="true" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="form-label" style="text-align:right" >Resa:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="resaID" DataValueField="ID" DataTextField="resa_desc" SelectMethod="Get_resa" AppendDataBoundItems="true" CssClass="form-control" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Trasporto:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="transportID" DataValueField="ID" DataTextField="trasporto" SelectMethod="Get_transport" AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="form-label" style="text-align:right" >Costo di trasporto:</td>
                            <td>
                                <asp:TextBox runat="server" ID="costo_trasp" Text="" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Consegna:</td>
                            <td>
                                <asp:TextBox runat="server"  ID="consegna" Text="" CssClass="form-control" ></asp:TextBox>
                            </td>
                            <td class="form-label" style="text-align:right" >Garanzia:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="garanziaID" DataValueField="ID" DataTextField="garanzia_desc" SelectMethod="Get_garanzia" AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Imballo:</td>
                            <td><asp:TextBox runat="server" ID="imballo" Text="" CssClass="form-control"></asp:TextBox></td>
                            <td class="form-label" style="text-align:right" >Note:</td> 
                            <td><asp:TextBox runat="server" ID="note" Text="" TextMode="MultiLine" CssClass="form-control"></asp:TextBox></td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Stato:</td>
                            <td>
                                <asp:DropDownList runat="server"  ID="stato" AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Text="In attesa" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Vinto"></asp:ListItem>
                                    <asp:ListItem Text="Perso"></asp:ListItem>
                                    <asp:ListItem Text="Aggiornato"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="acomtable-section-intest">
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                            <td style="height:10px"></td>
                        </tr>
                        <tr >
                            <td>
                                <asp:Button ID="cmd_insert" Text="Salva" runat="server" CssClass="btn btn-primary btn-hover" OnClick="cmd_insert_Click" ValidationGroup="offer_detail" CausesValidation="true" />
                                <asp:Button ID="cmd_cancella" Text="Annulla" runat="server" CssClass="btn btn-primary btn-hover" OnClick="cmd_cancella_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox runat="server"  ID="offer_num" Text="" Visible="false" ></asp:TextBox>
                                <asp:TextBox runat="server"  ID="offer_vers" Text="" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
            </asp:FormView>
            </div>
            <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="UpdatePanelDetail" >
                <ProgressTemplate>  
                    <div class="updateprogress-modal">
                        <div class="updateprogress-center">
                            <asp:Label Text="Aggiornamento in corso..." runat="server" ForeColor="Black" BackColor="White" />    
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>
<asp:UpdatePanel ID="UpdatePanelInsertRow" runat="server">
    <ContentTemplate>
    <hr />
    <h3>Dettaglio articoli</h3>
    <h5>Gli articoli selezionati che presentano data di decorrenza evidenziata in rosso sono relativi ad un listino non aggiornato.</h5>
    <br />
    <div>
        <asp:Label runat="server" ID="errmsginsert" Text="" EnableViewState="false" CssClass="alert alert-danger" Visible="false"></asp:Label>
        <br />
        <asp:ValidationSummary runat="server" ID="validateGridRowsInsert"  DisplayMode="BulletList" ShowMessageBox="false" ShowSummary="true" ShowModelStateErrors="true" ShowValidationErrors="true" CssClass="alert alert-danger" ValidationGroup="GridRowInsert" />
        <table id="tableRowInsert" style="grid-column-sizing:auto" class="table table-hover table-bordered table-responsive">
        <tr style="background-color:#DCF5FD; align-content:center; white-space:nowrap" >
               <th ></th>
               <th >Note</th>
               <th >Codice Articolo</th>
               <th >Quantità</th>
               <th >Prezzo</th>
               <th >Decorrenza</th>
               <th >Sconto 1 - %</th>
               <th >Sconto 2 - %</th>
               <th >Sconto 3 - %</th>
               <th >Sconto 4 - %</th>
               <th >Sconto 5 - %</th>
               <th >Sconto 6 - %</th>
          </tr>

       <tr style="">
              <td>
                  <asp:Button runat="server" ID="insertbtn" CommandName="insertRow" Text="Inserisci" OnClick="insertButton_Click" CssClass="btn btn-primary btn-hover" ValidationGroup="GridRowInsert" CausesValidation="true"></asp:Button>
              </td>
              <td>
                  <asp:TextBox ID="note" runat="server" Text="" CssClass="form-control" Width="150px" ></asp:TextBox>
              </td>
              <td style="">
                  <asp:ComboBox ID="ddarticle" AutoCompleteMode="SuggestAppend" MaxLength="500" DropDownStyle="DropDown" runat="server" AutoPostBack="True" AppendDataBoundItems="false" OnSelectedIndexChanged="articleID_SelectedIndexChanged" DataSourceID="SqlDataSourceArticle" DataTextField="article_code" DataValueField="ID" CssClass="WindowsStyle" >
                  </asp:ComboBox>
                  <asp:RequiredFieldValidator runat="server" ID="RequireArticle" Display="None" ControlToValidate="ddarticle" ErrorMessage="Selezionare un articolo" ValidationGroup="GridRowInsert" SetFocusOnError="true"></asp:RequiredFieldValidator>
                  <asp:SqlDataSource ID="SqlDataSourceArticle" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" SelectCommand="SELECT [ID], [article_code], [article_desc], [prezzo], [data_decorrenza] FROM [ViewArticle] where [annull]=0"></asp:SqlDataSource>
              </td>
              <td>
                  <asp:TextBox ID="quantita" runat="server" Text=0 OnTextChanged="quantita_TextChanged" AutoPostBack="false" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredQuantita" ControlToValidate="quantita" Display="None" ErrorMessage="Inserire quantità" SetFocusOnError="true" ValidationGroup="GridRowInsert"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ErrorMessage="Quantità è un campo numerico" ControlToValidate="quantita" SetFocusOnError="true" Display="None" runat="server" ValidationGroup="GridRowInsert" ValidationExpression="^[0-9.,]*$" />
              </td>
              <td>
                  <asp:TextBox ID="prezzo" Text="" runat="server" Enabled="false" CssClass="form-control" Width="100px" ></asp:TextBox>
              </td>
              <td>
                  <asp:TextBox ID="data_decorrenza" Text="" runat="server" ForeColor="Black" Enabled="false" CssClass="form-control" Width="100px"></asp:TextBox>
              </td>
              <td>
                  <asp:TextBox ID="sconto1" runat="server" Text="" OnTextChanged="quantita_TextChanged" AutoPostBack="false" CssClass="form-control" ></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto1" ErrorMessage="Sconto 1 deve essere compreso tra 0 e 100" Display="None" SetFocusOnError="true" MinimumValue="0" MaximumValue="100" Type="Double"  ValidationGroup="GridRowInsert"></asp:RangeValidator>
              </td>
              <td>
                  <asp:TextBox ID="sconto2" runat="server" Text="" OnTextChanged="quantita_TextChanged" AutoPostBack="false" CssClass="form-control" ></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto2" ErrorMessage="Sconto 2 deve essere compreso tra 0 e 100" Display="None" SetFocusOnError="true" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowInsert"></asp:RangeValidator>
              </td>
              <td>
                  <asp:TextBox ID="sconto3" runat="server" Text="" OnTextChanged="quantita_TextChanged" AutoPostBack="false" CssClass="form-control" ></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto3" ErrorMessage="Sconto 3 deve essere compreso tra 0 e 100" Display="None" SetFocusOnError="true" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowInsert"></asp:RangeValidator>
              </td>
              <td>
                  <asp:TextBox ID="sconto4" runat="server" Text="" OnTextChanged="quantita_TextChanged" AutoPostBack="false" CssClass="form-control" ></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto4" ErrorMessage="Sconto 4 deve essere compreso tra 0 e 100" Display="None" SetFocusOnError="true" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowInsert"></asp:RangeValidator>
              </td>
              <td >
                  <asp:TextBox ID="sconto5" runat="server" Text="" OnTextChanged="quantita_TextChanged" AutoPostBack="false" CssClass="form-control" ></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto5" ErrorMessage="Sconto 5 deve essere compreso tra 0 e 100" Display="None" SetFocusOnError="true" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowInsert"></asp:RangeValidator>
              </td>
              <td>
                  <asp:TextBox ID="sconto6" runat="server" Text="" OnTextChanged="quantita_TextChanged" AutoPostBack="false" CssClass="form-control" ></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto6" ErrorMessage="Sconto 6 deve essere compreso tra 0 e 100" Display="None" SetFocusOnError="true" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowInsert"></asp:RangeValidator>
              </td>
          </tr>
           </table>
</div>
            <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="UpdatePanelInsertRow">
                <ProgressTemplate>  
                    <div class="updateprogress-modal">
                        <div class="updateprogress-center">
                            <asp:Label Text="Aggiornamento in corso..." runat="server" ForeColor="Black" BackColor="White" />    
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
<div>
    <asp:ValidationSummary runat="server" ID="ValidationGridRows" DisplayMode="BulletList" ShowMessageBox="false" ShowSummary="true" ShowModelStateErrors="true" ShowValidationErrors="true" CssClass="alert alert-danger" ValidationGroup="GridRowEdit"  />
    <asp:GridView ID="GridViewRows" runat="server" AutoGenerateColumns="false" DataKeyNames="ID" SelectMethod="GridViewRows_GetData" UpdateMethod="GridViewRows_UpdateItem" OnRowEditing="GridViewRows_RowEditing" OnDataBound="GridViewRows_DataBound" ShowFooter="true" FooterStyle-BorderWidth="0px" CssClass="table table-hover table-bordered table-responsive">
        <HeaderStyle Font-Bold="true" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#DCF5FD" />
        <Columns>
            <asp:CommandField ShowCancelButton="true" ShowEditButton="true" ControlStyle-CssClass="btn btn-primary btn-hover" ValidationGroup="GridRowEdit"/>
            <asp:TemplateField HeaderText="Riga" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="rigaID" Text='<%# Eval("rigaID")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="rigaID" Text='<%# Bind("rigaID")%>' CssClass="form-control" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredRiga" SetFocusOnError="true" ControlToValidate="rigaID" Display="None" ErrorMessage="Inserire numero di riga" ValidationGroup="GridRowEdit"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ErrorMessage="Riga è un campo numerico" ControlToValidate="rigaID" runat="server" SetFocusOnError="true" Display="None" ValidationGroup="GridRowEdit" ValidationExpression="^[0-9.,]*$"/>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Note" ControlStyle-Width="150px">
                <ItemTemplate>
                    <asp:Label runat="server" ID="note" Text='<%# Eval("note")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="note" Text='<%# Bind("note")%>' TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ArticoloID" Visible="false" >
                <ItemTemplate>
                    <asp:textbox runat="server" ID="articleID" Text='<%# Eval("articleID")%>' Enabled="false" Visible="false"></asp:textbox>
                </ItemTemplate>
                <EditItemTemplate>
                        <asp:textbox runat="server" ID="articleID" Text='<%# Bind("articleID")%>' Enabled="false" Visible="false"></asp:textbox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Codice articolo" ControlStyle-Width="150px" >
                <ItemTemplate>
                    <asp:label runat="server" ID="article_code" Text='<%# Eval("article_code")%>' ></asp:label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:label runat="server" ID="article_code" Text='<%# Eval("article_code")%>'></asp:label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Descrizione" ControlStyle-Width="150px" >
                <ItemTemplate>
                    <asp:label runat="server" ID="article_desc" Text='<%# Eval("article_desc")%>' ></asp:label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:label runat="server" ID="article_desc" Text='<%# Eval("article_desc")%>' ></asp:label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Quantità" ItemStyle-HorizontalAlign="Right" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="quantita" Text='<%# Eval("quantita")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="quantita" Text='<%# Bind("quantita")%>' CssClass="form-control" AutoPostBack="true" OnTextChanged="quantitaEdit_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredQuantita" ControlToValidate="quantita" Display="None" ErrorMessage="Inserire quantità" SetFocusOnError="true" ValidationGroup="GridRowEdit"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ErrorMessage="Quantità è un campo numerico" ControlToValidate="quantita" runat="server" SetFocusOnError="true" Display="None" ValidationGroup="GridRowEdit" ValidationExpression="^[0-9.,]*$" />
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Prezzo" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"  ControlStyle-Width="100px">
                <ItemTemplate>
                    <asp:Label runat="server" ID="prezzo" Text='<%# Eval("prezzo", "{0:C}")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Textbox runat="server" ID="prezzo" Text='<%# Bind("prezzo")%>' Enabled="false" CssClass="form-control"></asp:Textbox>
                </EditItemTemplate>
            </asp:TemplateField>

<%--            <asp:TemplateField HeaderText="Prezzo netto" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"  ControlStyle-Width="100px" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="prezzo_netto" Text='<%# Eval("prezzo_netto", "{0:C}")%>' Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Textbox runat="server" ID="prezzo_netto" Text='<%# Bind("prezzo_netto")%>' Enabled="false" CssClass="form-control" Visible="false"></asp:Textbox>
                </EditItemTemplate>
            </asp:TemplateField>--%>

            <asp:TemplateField HeaderText="Sconto 1 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" >
                    <ItemTemplate>
                        <asp:Label runat="server" ID="sconto1" Text='<%# Eval("sconto1")%>'></asp:Label>
                    </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="sconto1" Text='<%# Bind("sconto1", "{0:N}")%>' CssClass="form-control" AutoPostBack="true" OnTextChanged="quantitaEdit_TextChanged"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto1" ErrorMessage="Sconto 1 deve essere compreso tra 0 e 100" SetFocusOnError="true" Display="None" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowEdit"></asp:RangeValidator>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 2 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto2" Text='<%# Eval("sconto2", "{0:N}")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="sconto2" Text='<%# Bind("sconto2")%>' CssClass="form-control" AutoPostBack="true" OnTextChanged="quantitaEdit_TextChanged"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto2" ErrorMessage="Sconto 2 deve essere compreso tra 0 e 100" SetFocusOnError="true" Display="None" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowEdit"></asp:RangeValidator>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 3 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto3" Text='<%# Eval("sconto3")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="sconto3" Text='<%# Bind("sconto3", "{0:N}")%>' CssClass="form-control" AutoPostBack="true" OnTextChanged="quantitaEdit_TextChanged"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto3" ErrorMessage="Sconto 3 deve essere compreso tra 0 e 100" SetFocusOnError="true" Display="None" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowEdit"></asp:RangeValidator>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 4 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto4" Text='<%# Eval("sconto4")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="sconto4" Text='<%# Bind("sconto4", "{0:N}")%>' CssClass="form-control" AutoPostBack="true" OnTextChanged="quantitaEdit_TextChanged"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto4" ErrorMessage="Sconto 4 deve essere compreso tra 0 e 100" SetFocusOnError="true" Display="None" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowEdit"></asp:RangeValidator>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 5 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto5" Text='<%# Eval("sconto5")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="sconto5" Text='<%# Bind("sconto5", "{0:N}")%>' CssClass="form-control" AutoPostBack="true" OnTextChanged="quantitaEdit_TextChanged"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto5" ErrorMessage="Sconto 5 deve essere compreso tra 0 e 100" SetFocusOnError="true" Display="None" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowEdit"></asp:RangeValidator>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 6 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto6" Text='<%# Eval("sconto6")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="sconto6" Text='<%# Bind("sconto6", "{0:N}")%>' CssClass="form-control" AutoPostBack="true" OnTextChanged="quantitaEdit_TextChanged"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="sconto6" ErrorMessage="Sconto 6 deve essere compreso tra 0 e 100" SetFocusOnError="true" Display="None" MinimumValue="0" MaximumValue="100" Type="Double" ValidationGroup="GridRowEdit"></asp:RangeValidator>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label runat="server" Text="TOTALE" Font-Bold="true"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Totale" ItemStyle-HorizontalAlign="Right" FooterStyle-Wrap="false" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="totale" Text='<%# Eval("totale", "{0:C}")%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:textbox runat="server" ID="totale" Text='<%# Bind("totale")%>' Enabled="false" CssClass="form-control" ></asp:textbox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="totale" runat="server" Text="" Font-Bold="true" ></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Annullato" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' Enabled="false"></asp:CheckBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox runat="server" ID="annull" Checked='<%# Bind("annull")%>' ></asp:CheckBox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="offerID" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="offerID" Text='<%# Eval("offerID")%>' Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="offerID" Text='<%# Eval("offerID")%>' Visible="false"></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Creato da" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="created_by" Text='<%# Eval("created_by")%>' Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="created_by" Text='<%# Eval("created_by")%>' Visible="false"></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Creato il" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="created_date" Text='<%# Eval("created_date")%>' Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="created_date" Text='<%# Eval("created_date")%>' Visible="false"></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Aggiornato da" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updated_by")%>' Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updated_by")%>' Visible="false"></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Aggiornato il" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="updated_date" Text='<%# Eval("updated_date")%>' Visible="false"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="updated_date" Text='<%# Eval("updated_date")%>' Visible="false"></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField> 


        </Columns>
        
    </asp:GridView>
</div>
         </ContentTemplate>
        </asp:UpdatePanel>
<div class="form-horizontal" >
    <asp:Button ID="cmdDuplica" CssClass="btn btn-primary btn-hover" OnClick="cmdDuplica_Click" runat="server" Text="Duplica offerta" />
    <asp:ConfirmButtonExtender ID="cmdDuplica_ConfirmButtonExtender" runat="server" TargetControlID="cmdDuplica" ConfirmText="Generare un duplicato dell'offerta?" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="cmdNewVers" CssClass="btn btn-primary btn-hover" OnClick="cmdNewVers_Click" runat="server" Text="Genera nuova versione"/>
    <asp:ConfirmButtonExtender ID="cmdNewVers_ConfirmButtonExtender" runat="server" TargetControlID="cmdNewVers" ConfirmText="Generare nuova versione dell'offerta?" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="cmdStampaOfferta" CssClass="btn btn-primary btn-hover" OnClick="cmdStampaOfferta_Click" runat="server" Text="Stampa Offerta" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="cmdStampaOffertaSconti" CssClass="btn btn-primary btn-hover" OnClick="cmdStampaOffertaSconti_Click" runat="server" Text="Stampa Offerta con dettaglio sconti" />
</div>

</asp:Content>
