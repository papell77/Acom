<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminMaster.master" CodeBehind="VisiteIns.aspx.vb" Inherits="Acom1.VisiteIns" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
        <h3 id="lbltitle" runat="server">Dettaglio evento</h3>

            <asp:Label runat="server" ID="errormsg" CssClass="alert alert-danger" EnableViewState="false" Text="" ForeColor="Red" Visible="false"></asp:Label>
            <br />
            <asp:DetailsView ID="DetailsViewVisit" runat="server" HeaderStyle-Wrap="false" AutoGenerateRows="false" SelectMethod="DetailsViewVisit_GetItem" UpdateMethod="DetailsViewVisit_UpdateItem" InsertMethod="DetailsViewVisit_InsertItem" DataKeyNames="ID" BorderStyle="None" GridLines="None" >
            <FieldHeaderStyle Font-Bold="true" Wrap="false" />
                <Fields>
                        <asp:BoundField DataField="ID" Visible="false" />
                        <asp:TemplateField HeaderText="Agente" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="agentID" Text='<%# Eval("name")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Cliente" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="clienteID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Filiale" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="officeID" Text='<%# Eval("nome")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Data evento" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="data" Text='<%# Eval("data", "{0:dd/MM/yyyy HH:mm}")%>' ></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Motivo" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:DropDownList runat="server" ID="motivo_tipo" selectedvalue='<%# Eval("motivo_type")%>' OnDataBinding="motivo_tipo_DataBinding"></asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descrizione evento" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="motivo_descrizione" Text='<%# Eval("motivo_desc")%>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Numero offerta" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="preventivo_num" Text='<%# Eval("preventivo_num")%>' ></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Data prossimo evento" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:textbox runat="server" ID="data_prossima" Text='<%# Eval("data_prossima", "{0:dd/MM/yyyy HH:mm}")%>' ></asp:textbox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Stato" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:DropDownList runat="server" ID="stato" selectedvalue='<%# Eval("stato")%>' AppendDataBoundItems="true" >
                                    <asp:ListItem Value="pending" Text="In attesa"></asp:ListItem>
                                    <asp:ListItem Value="review" Text="Da rivedere"></asp:ListItem>
                                    <asp:ListItem Value="closed" Text="Concluso"></asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Annullato" InsertVisible="false" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>        
                
                        <asp:TemplateField HeaderText="Creato da" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="createdby" Text='<%# Eval("createdby")%>' Visible="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField headertext="Creato il" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="created_date" Text='<%# Eval("data_ins", "{0:dd/MM/yyyy}")%>' Visible="true" ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato da" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updatedby")%>' Visible="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato il" Visible="true" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_date" Text='<%# Eval("data_upd", "{0:dd/MM/yyyy}")%>' Visible="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
            </Fields>
    </asp:DetailsView>

</asp:Content>
