<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="OfferteDettaglio.aspx.vb" Inherits="Acom1.OfferteDettaglio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3>Dettaglio offerta</h3>
    <h5>In questa maschera è possibile solo annullare l'offerta o modificarne lo stato</h5>
    <table style="width:100%;">
        <tr>
            <td style="">
                <asp:Label runat="server" ID="errormsg" EnableViewState="false" Text="" CssClass="text-danger"></asp:Label>
                <asp:ValidationSummary runat="server" CssClass="text-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true" />
                <asp:DetailsView ID="DetailsViewOffer" runat="server" AutoGenerateRows="false"  DataKeyNames="ID" SelectMethod="DetailsViewOffer_GetItem" UpdateMethod="DetailsViewOffer_UpdateItem" Width="30%" BorderStyle="None" GridLines="None">
                    <FieldHeaderStyle Wrap="False" Font-Bold="true" />
                    <Fields>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true" Visible="false" />
                        <asp:BoundField DataField="offer_code" HeaderText="Offerta n." ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="agentname" HeaderText="Agente" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:TemplateField HeaderText="Data" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="data" Text='<%# Eval("data", "{0:dd/MM/yyyy}")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="data" Text='<%# Bind("data", "{0:dd/MM/yyyy}")%>' ></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data" Format="dd/MM/yyyy" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data" ErrorMessage="Inserire data offerta" ID="RequiredData" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
<%--                        <asp:BoundField DataField="data" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true" />--%>
                        <asp:TemplateField HeaderText="Valida fino al" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="data_valid" Text='<%# Eval("data_valid", "{0:dd/MM/yyyy}")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="data_val" Text='<%# Bind("data_valid", "{0:dd/MM/yyyy}")%>'></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data_val" Format="dd/MM/yyyy" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data_val" ErrorMessage="Inserire data validità" ID="RequiredDatavalid" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
<%--                        <asp:BoundField DataField="data_valid" HeaderText="Valida fino al" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true" />--%>
                        <asp:TemplateField HeaderText="Cliente *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="clienteID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="clienteID" AutoPostBack="true" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client" AppendDataBoundItems="true" selectedvalue='<%# Bind("clientID")%>' OnSelectedIndexChanged="DDLClient_SelectedIndexChanged" OnDataBound="DDLClient_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="client_annull" Text="Cliente non attivo" Visible="false" ForeColor="Red"></asp:Label>
                                <asp:RequiredFieldValidator ErrorMessage="Inserire cliente" ControlToValidate="clienteID" runat="server" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Filiale" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="officeID" Text='<%# Eval("nome")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="officeID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" AppendDataBoundItems="true" selectedvalue='<%# Bind("officeID")%>' OnDataBinding="DDLoffice_DataBinding" OnSelectedIndexChanged="officeID_SelectedIndexChanged" OnDataBound="officeID_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="office_annull" Text="Filiale non attiva" Visible="false" ForeColor="Red"></asp:Label>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contatto" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="contactID" Text='<%# Eval("cognome")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="contactID" AutoPostBack="true" DataValueField="ID" DataTextField="cognome"  AppendDataBoundItems="true" selectedvalue='<%# Bind("contactID")%>' OnDataBinding="DDLContact_DataBinding" OnSelectedIndexChanged="contactID_SelectedIndexChanged" OnDataBound="contactID_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="contact_annull" Text="Contatto non attivo" Visible="false" ForeColor="Red"></asp:Label>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Riferimento" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="riferimento" Text='<%# Eval("riferimento")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="riferimento" Text='<%# Bind("riferimento")%>' ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Famiglia" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="familyID" Text='<%# Eval("family_name")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="familyID" AutoPostBack="true" DataValueField="ID" DataTextField="family_name" SelectMethod="Get_families" AppendDataBoundItems="true" selectedvalue='<%# Bind("familyID")%>' OnSelectedIndexChanged="familyID_SelectedIndexChanged" OnDataBound="familyID_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="family_annull" Text="Famiglia non attivo" Visible="false" ForeColor="Red"></asp:Label>
<%--                                <asp:RequiredFieldValidator runat="server" ControlToValidate="familyID" ID="RequiredFamily" ErrorMessage="Inserire famiglia" Display="None" ValidationGroup="offer_detail" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Importo" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="importo" Text='<%# Eval("importo", "{0:C}")%>' ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
<%--                        <asp:BoundField DataField="importo" HeaderText="Importo" DataFormatString="{0:C}" ReadOnly="true" />--%>
                        <asp:TemplateField HeaderText="Giorni consegna" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="consegna" Text='<%# Eval("consegna")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="consegna" Text='<%# Bind("consegna")%>' ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="offer_est" HeaderText="Offerta esterna" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="pagamento" HeaderText="Pagamento" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="trasporto" HeaderText="Trasporto" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:TemplateField HeaderText="Costo di trasporto" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="costo_trasporto" Text='<%# Eval("costo_trasporto", "{0:C}")%>'></asp:Label>
                            </ItemTemplate> 
                        </asp:TemplateField>
<%--                        <asp:BoundField DataField="costo_trasporto" HeaderText="Costo di trasporto" DataFormatString="{0:C}"  ReadOnly="true" />--%>
                        <asp:BoundField DataField="resa_desc" HeaderText="Resa" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="garanzia_desc" HeaderText="Garanzia" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="imballo" HeaderText="Imballo" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="note" HeaderText="Note" ReadOnly="true" ItemStyle-CssClass="form-control"/>
                        <asp:TemplateField ItemStyle-BorderColor="Gray" HeaderStyle-BorderColor="Gray" ItemStyle-BorderWidth="1" HeaderStyle-BorderWidth="1" HeaderText="Stato" HeaderStyle-BackColor="Yellow" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="stato" Text='<%# Eval("stato")%>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="stato" selectedvalue='<%# Bind("stato")%>' AppendDataBoundItems="true" >
                                    <asp:ListItem Text="In attesa"></asp:ListItem>
                                    <asp:ListItem Text="Vinto"></asp:ListItem>
                                    <asp:ListItem Text="Perso"></asp:ListItem>
                                    <asp:ListItem Text="Aggiornato" />
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField ItemStyle-BorderColor="Gray" HeaderStyle-BorderColor="Gray" ItemStyle-BorderWidth="1" HeaderStyle-BorderWidth="1" ItemStyle-HorizontalAlign="Center"  HeaderText="Annullato" InsertVisible="false" HeaderStyle-BackColor="Yellow" >
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' Enabled="false" ></asp:CheckBox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Bind("annull")%>' Enabled="true" ></asp:CheckBox>
                            </EditItemTemplate>
                        </asp:TemplateField>                      
                        <asp:BoundField DataField="created_by" HeaderText="Inserita da" Visible="false" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="created_date" HeaderText="Inserita il" Visible="false" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="updated_by" HeaderText="Aggiornata da" Visible="false" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="updated_date" HeaderText="Aggiornata il" Visible="false" ItemStyle-CssClass="form-control"/>
                        <asp:BoundField DataField="offer_num" Headertext="Offerta numero" Visible="false" />
                        <asp:BoundField DataField="offer_vers" HeaderText="Versione numero" Visible="false" />
                        <asp:CommandField ShowEditButton="true" ShowCancelButton="true" ControlStyle-CssClass="btn btn-primary btn-hover" />
                    </Fields>
                    <RowStyle Wrap="False" />
                </asp:DetailsView>
            </td>
            <td style="">
                <br />
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:GridView ID="GridViewRows" runat="server" CssClass="table table-hover table-bordered table-responsive" AutoGenerateColumns="false" RowStyle-HorizontalAlign="Right" DataKeyNames="ID" ItemType="Acom1.ViewOfferRowDetail" ShowFooter="true" SelectMethod="GridViewRows_GetData" OnDataBound="GridViewRows_DataBound">
        <HeaderStyle  Wrap="False" BackColor ="#DCF5FD" Font-Bold="true" />
        <Columns>
            <asp:BoundField DataField="rigaID" HeaderText="Riga n." ReadOnly="true" />
            <asp:BoundField DataField="note" HeaderText="Note" />
            <asp:BoundField DataField="article_code" HeaderText="Codice Articolo" />
            <asp:BoundField DataField="article_desc" HeaderText="Articolo" />
            <asp:BoundField DataField="quantita" HeaderText="Quantità" />
            <asp:BoundField DataField="prezzo" DataFormatString="{0:C}" HeaderText="Prezzo" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="sconto1" HeaderText="Sconto 1 - %" ItemStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="sconto2" HeaderText="Sconto 2 - %" ItemStyle-HorizontalAlign="Right"/>
            <asp:BoundField DataField="sconto3" HeaderText="Sconto 3 - %" ItemStyle-HorizontalAlign="Right"/>
            <asp:BoundField DataField="sconto4" HeaderText="Sconto 4 - %" ItemStyle-HorizontalAlign="Right"/>
            <asp:BoundField DataField="sconto5" HeaderText="Sconto 5 - %" ItemStyle-HorizontalAlign="Right"/>
            <asp:TemplateField HeaderText="Sconto 6 - %" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# Eval("sconto6")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label runat="server" Text="TOTALE" Font-Bold="true"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Totale" ItemStyle-HorizontalAlign="Right" FooterStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="totale" Text='<%# Eval("totale", "{0:C}")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label runat="server" ID="totale" Text="" Font-Bold="true"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField DataField="annull" HeaderText="Annullata" Visible="false" />
            <asp:BoundField DataField="offerID" HeaderText="ID offerta" Visible="false" />
            <asp:BoundField DataField="created_by" HeaderText="Inserita da" Visible="false"/>
            <asp:BoundField DataField="created_date" HeaderText="Inserita il" Visible="false" />
            <asp:BoundField DataField="updated_by" HeaderText="Aggiornata da" Visible="false" />
            <asp:BoundField DataField="updated_date" HeaderText="Aggiornata il" Visible="false" />

        </Columns>
    </asp:GridView>
        <br />
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
    <asp:HiddenField runat="server" ID="offertaID" Value="" />
    <asp:SqlDataSource ID="SqlDataSourceReportOffer" runat="server" ConnectionString="<%$ ConnectionStrings:AcomdbConnectionString %>" SelectCommand="SELECT * FROM [ViewReportOffer] WHERE ([ID] = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="ID" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
