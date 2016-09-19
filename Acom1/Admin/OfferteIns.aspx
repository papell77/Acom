<%@ Page Title="Offerta" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="OfferteIns.aspx.vb" Inherits="Acom1.OfferteIns" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <asp:Label runat="server" ID="errormsg" EnableViewState="false" Text="" CssClass="alert alert-danger" Visible="false"></asp:Label>

            <div>
            <asp:FormView runat="server" ID="FormOfferIns" SelectMethod="FormOfferIns_GetItem" DataKeyNames="ID" >
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
                            <td><asp:Label ID="contactID" Text='<%# Eval("cognome")%>' runat="server" CssClass="form-control"/></td>
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
                        <tr>
                            <td class="form-label" style="text-align:right" >Creato da:</td>
                            <td><asp:Label runat="server" ID="created_by" CssClass="form-control" Text='<%# Eval("created_by")%>' Visible="true"></asp:Label></td>
                            <td class="form-label" style="text-align:right" >Creato il:</td>
                            <td><asp:Label runat="server" ID="created_date" CssClass="form-control" Text='<%# Eval("created_date", "{0:dd/MM/yyyy}")%>' Visible="true" ></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="form-label" style="text-align:right" >Modificato da:</td>
                            <td><asp:Label runat="server" ID="updated_by" CssClass="form-control" Text='<%# Eval("updated_by")%>' Visible="true"></asp:Label></td>
                            <td class="form-label" style="text-align:right" >Modificato il:</td>
                            <td><asp:Label runat="server" ID="updated_date" CssClass="form-control" Text='<%# Eval("updated_date", "{0:dd/MM/yyyy}")%>' Visible="true"></asp:Label>
                            <asp:Label runat="server" ID="offer_num" Text='<%# Eval("offer_num")%>' Visible="false"></asp:Label></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
        </div>
    <hr />
<h3>Dettaglio articoli</h3>

    <div>
        <asp:Label runat="server" ID="errmsginsert" Text="" EnableViewState="false" CssClass="alert alert-danger" Visible="false"></asp:Label>
    <br />
        <asp:GridView ID="GridViewRows" runat="server" AutoGenerateColumns="false" DataKeyNames="ID" SelectMethod="GridViewRows_GetData" OnDataBound="GridViewRows_DataBound" ShowFooter="true" FooterStyle-BorderWidth="0px" CssClass="table table-hover table-bordered table-responsive">
        <HeaderStyle Font-Bold="true" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#DCF5FD" />
        <Columns>
            <asp:TemplateField HeaderText="Riga" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="rigaID" Text='<%# Eval("rigaID")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Note" ControlStyle-Width="150px">
                <ItemTemplate>
                    <asp:Label runat="server" ID="note" Text='<%# Eval("note")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ArticoloID" Visible="false" >
                <ItemTemplate>
                    <asp:textbox runat="server" ID="articleID" Text='<%# Eval("articleID")%>' Enabled="false" Visible="false"></asp:textbox>
<%--                <asp:ComboBox runat="server" ID="articleID" DataValueField="ID" DataTextField="article_desc" selectedvalue='<%# Eval("articleID")%>' SelectMethod="Get_article_from_pricelist" Enabled="false" >
                    </asp:ComboBox>--%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Codice articolo" ControlStyle-Width="150px" >
                <ItemTemplate>
                    <asp:label runat="server" ID="article_code" Text='<%# Eval("article_code")%>' ></asp:label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Descrizione" ControlStyle-Width="150px" >
                <ItemTemplate>
                    <asp:label runat="server" ID="article_desc" Text='<%# Eval("article_desc")%>' ></asp:label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Quantità" ItemStyle-HorizontalAlign="Right" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="quantita" Text='<%# Eval("quantita")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Prezzo" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false"  ControlStyle-Width="100px">
                <ItemTemplate>
                    <asp:Label runat="server" ID="prezzo" Text='<%# Eval("prezzo", "{0:C}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 1 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" >
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto1" Text='<%# Eval("sconto1")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 2 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto2" Text='<%# Eval("sconto2", "{0:N}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 3 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto3" Text='<%# Eval("sconto3")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 4 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto4" Text='<%# Eval("sconto4")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 5 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto5" Text='<%# Eval("sconto5")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Sconto 6 - %" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="sconto6" Text='<%# Eval("sconto6")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label runat="server" Text="TOTALE" Font-Bold="true"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Totale" ItemStyle-HorizontalAlign="Right" FooterStyle-Wrap="false" ItemStyle-Wrap="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="totale" Text='<%# Eval("totale", "{0:C}")%>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="totale" runat="server" Text="" Font-Bold="true" ></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Annullato" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' Enabled="false"></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="offerID" Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="offerID" Text='<%# Eval("offerID")%>' Visible="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Creato da" Visible="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="created_by" Text='<%# Eval("created_by")%>' Visible="true"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Creato il" Visible="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="created_date" Text='<%# Eval("created_date", "{0:dd/MM/yyyy}")%>' Visible="true"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Modificato da" Visible="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updated_by")%>' Visible="true"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Aggiornato il" Visible="true">
                <ItemTemplate>
                    <asp:Label runat="server" ID="updated_date" Text='<%# Eval("updated_date", "{0:dd/MM/yyyy}")%>' Visible="true"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField> 


        </Columns>
        
    </asp:GridView>
</div>

<div class="form-horizontal" >
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="cmdStampaOfferta" CssClass="btn btn-primary btn-hover" OnClick="cmdStampaOfferta_Click" runat="server" Text="Stampa Offerta" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="cmdStampaOffertaSconti" CssClass="btn btn-primary btn-hover" OnClick="cmdStampaOffertaSconti_Click" runat="server" Text="Stampa Offerta con dettaglio sconti" />
</div>
</asp:Content>
