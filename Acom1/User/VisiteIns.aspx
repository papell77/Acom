<%@ Page Title="Eventi" Language="vb" AutoEventWireup="false" MasterPageFile="~/User/UserMaster.master" CodeBehind="VisiteIns.aspx.vb" Inherits="Acom1.VisiteIns1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="OtherContent" runat="server">
    <h3 id="lbltitle" runat="server">Dettaglio evento</h3>
    <h5>I campi contrassegnati con * sono obbligatori</h5>

     <asp:UpdatePanel runat="server" ID="UpdateVisit">
        <ContentTemplate>
            <asp:Label runat="server" ID="errormsg" CssClass="alert alert-danger" EnableViewState="false" Text="" ForeColor="Red" Visible="false"></asp:Label>
            <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" ShowMessageBox="false" ShowModelStateErrors="true" ShowSummary="true" ShowValidationErrors="true"  />
            <br />
            <br />
            <asp:DetailsView ID="DetailsViewVisit" runat="server" HeaderStyle-Wrap="false" AutoGenerateRows="false" SelectMethod="DetailsViewVisit_GetItem" UpdateMethod="DetailsViewVisit_UpdateItem" InsertMethod="DetailsViewVisit_InsertItem" DataKeyNames="ID" OnItemUpdated="DetailsViewVisit_ItemUpdated" OnItemInserted="DetailsViewVisit_ItemInserted" OnItemCommand="DetailsViewVisit_ItemCommand" BorderStyle="None" GridLines="None" >
            <FieldHeaderStyle Font-Bold="true" Wrap="false" />
                <Fields>
                        <asp:BoundField DataField="ID" Visible="false" />
                        <asp:TemplateField HeaderText="Agente *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="agentID" Text='<%# Eval("name")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="agentID" Text='<%# Eval("name")%>'></asp:Label>
                                <%-- <asp:DropDownList runat="server" ID="agentID" DataValueField="ID" DataTextField="name" SelectMethod="Get_agent" AppendDataBoundItems="true" selectedvalue='<%# Bind("agentID")%>' OnSelectedIndexChanged="agentID_SelectedIndexChanged" OnDataBound="agentID_SelectedIndexChanged" AutoPostBack="true" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredAgent" ControlToValidate="agentID" ErrorMessage="Inserire agente" ForeColor="Red" ></asp:RequiredFieldValidator>
                                <asp:Label runat="server" ID="agent_annull" Text="Agente non attivo" Visible="false" ForeColor="Red"></asp:Label>--%>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="agentID" DataValueField="ID" DataTextField="name" SelectMethod="Get_agent" AppendDataBoundItems="true" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredAgent" ControlToValidate="agentID" ErrorMessage="Inserire agente" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Cliente *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="clienteID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="clienteID" Text='<%# Eval("ragione_sociale")%>'></asp:Label>
                                <%-- <asp:DropDownList runat="server" ID="clienteID" AutoPostBack="true" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client" AppendDataBoundItems="true" selectedvalue='<%# Bind("clientID")%>' OnSelectedIndexChanged="clientID_SelectedIndexChanged" OnDataBound="clientID_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredClient" ControlToValidate="clienteID" ErrorMessage="Inserire cliente" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:Label runat="server" ID="client_annull" Text="Cliente non attivo" Visible="false" ForeColor="Red"></asp:Label>--%>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="clienteID" AutoPostBack="true" DataValueField="ID" DataTextField="ragione_sociale" SelectMethod="Get_client" AppendDataBoundItems="true" OnSelectedIndexChanged="clientID_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredClient" ControlToValidate="clienteID" ErrorMessage="Inserire cliente" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Filiale" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="officeID" Text='<%# Eval("nome")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" ID="officeID" Text='<%# Eval("nome")%>' ></asp:Label>
                                <%--<asp:DropDownList runat="server" ID="officeID" AutoPostBack="true" DataValueField="ID" DataTextField="nome" AppendDataBoundItems="true" selectedvalue='<%# Bind("officeID")%>' OnDataBinding="officeID_DataBinding" OnSelectedIndexChanged="officeID_SelectedIndexChanged" OnDataBound="officeID_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="office_annull" Text="Filiale non attiva" Visible="false" ForeColor="Red"></asp:Label>--%>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="officeID" AutoPostBack="true" DataValueField="ID" DataTextField="nome"  AppendDataBoundItems="true" OnDataBinding="officeID_DataBinding" OnSelectedIndexChanged="officeID_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Data evento *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="data" Enabled="false" Text='<%# Eval("data", "{0:dd/MM/yyyy HH:mm}")%>' ></asp:TextBox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="data" AutoPostBack="true"  Text='<%# Bind("data", "{0:dd/MM/yyyy HH:mm}")%>' Enabled="true" OnTextChanged="data_TextChanged" ></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data" Format="dd/MM/yyyy HH:mm" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data" ErrorMessage="Inserire data evento" ID="RequiredData" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="data" Text="" AutoPostBack="true" OnTextChanged="data_TextChanged"></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data" Format="dd/MM/yyyy HH:mm"  />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data" ErrorMessage="Inserire data evento" ID="RequiredData" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Motivo *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:DropDownList runat="server" ID="motivo_tipo" selectedvalue='<%# Eval("motivo_type")%>' OnDataBinding="motivo_tipo_DataBinding" Enabled="false"></asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownlist runat="server" ID="motivo_tipo" AutoPostBack="true" Enabled="false" selectedvalue='<%# Bind("motivo_type")%>' AppendDataBoundItems="true" OnDataBinding="motivo_tipo_DataBinding" OnSelectedIndexChanged="motivo_tipo_SelectedIndexChanged" >
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownlist>
                                <asp:RequiredFieldValidator ID="Required_motivo" runat="server" ControlToValidate="motivo_tipo" ErrorMessage="Inserire motivo evento" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="motivo_tipo" AutoPostBack="true" AppendDataBoundItems="true" OnDataBinding="motivo_tipo_DataBinding" OnSelectedIndexChanged="motivo_tipo_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="Required_motivo" runat="server" ControlToValidate="motivo_tipo" ErrorMessage="Inserire motivo evento" Display="None" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descrizione evento *" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="motivo_descrizione" Enabled="false" Text='<%# Eval("motivo_desc")%>'></asp:TextBox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="motivo_descrizione" Text='<%# Bind("motivo_desc")%>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Required_motivo_desc" runat="server" ControlToValidate="motivo_descrizione" ErrorMessage="Inserire descrizione evento" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="motivo_descrizione" Text=""></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Required_motivo_desc" runat="server" ControlToValidate="motivo_descrizione" ErrorMessage="Inserire descrizione evento"  Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>                            
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        
                        <%-- <asp:TemplateField HeaderText="Riferimento ordine Acom" Visible="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="ordine_num" Text='<%# Eval("ordine_num")%>'  Visible="false"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="ordine_num" Text='<%# Bind("ordine_num")%>' Visible="false"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="ordine_num" Text="" Visible="false"></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>--%>

                        <asp:TemplateField HeaderText="Numero offerta" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="preventivo_num" Enabled="false" Text='<%# Eval("preventivo_num")%>' ></asp:TextBox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="preventivo_num" AutoPostBack="true" OnTextChanged="preventivo_num_TextChanged" Text='<%# Bind("preventivo_num")%>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Required_offerta" ControlToValidate="preventivo_num" ErrorMessage="Inserire numero offerta" Enabled="false" runat="server" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="preventivo_num" Text="" AutoPostBack="true" OnTextChanged="preventivo_num_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Required_offerta" ControlToValidate="preventivo_num" ErrorMessage="Inserire numero offerta" Enabled="false" runat="server" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <%-- <asp:TemplateField HeaderText="Riferimento offerta esterna" Visible="false">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="offerta_est" Text='<%# Eval("offerta_est")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="offerta_est" Text='<%# Bind("offerta_est")%>' AutoPostBack="true" OnTextChanged="offerta_est_TextChanged" Visible="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Required_offerta_est" ControlToValidate="offerta_est" ErrorMessage="Inserire numero offerta esterna" Enabled="false" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server" ID="offerta_est" Text=""  AutoPostBack="true" OnTextChanged="offerta_est_TextChanged" Visible="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Required_offerta_est" ControlToValidate="offerta_est" ErrorMessage="Inserire numero offerta esterna" Enabled="false" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>--%>

                        <asp:TemplateField HeaderText="Data prossimo evento" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:textbox runat="server" ID="data_prossima" Enabled="false" Text='<%# Eval("data_prossima", "{0:dd/MM/yyyy HH:mm}")%>' ></asp:textbox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"  ID="data_prossima" Text='<%# Bind("data_prossima", "{0:dd/MM/yyyy HH:mm}")%>' AutoPostBack="true" OnTextChanged="data_prossima_TextChanged" ></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data_prossima" Format="dd/MM/yyyy HH:mm" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data_prossima" ErrorMessage="Inserire data prossimo evento" ID="Required_data_prossima" Enabled="false" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox runat="server"  ID="data_prossima" Text="" AutoPostBack="true" OnTextChanged="data_prossima_TextChanged"></asp:TextBox>
                                <asp:CalendarExtender runat="server" TargetControlID="data_prossima" Format="dd/MM/yyyy HH:mm"  />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="data_prossima" ErrorMessage="Inserire data prossimo evento" ID="Required_data_prossima" Enabled="false" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Stato" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:DropDownList runat="server" ID="stato" selectedvalue='<%# Eval("stato")%>' AppendDataBoundItems="true" Enabled="false">
                                    <asp:ListItem Value="pending" Text="In attesa"></asp:ListItem>
                                    <asp:ListItem Value="review" Text="Da rivedere"></asp:ListItem>
                                    <asp:ListItem Value="closed" Text="Concluso"></asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="stato" selectedvalue='<%# Bind("stato")%>' AppendDataBoundItems="true" Enabled="false" AutoPostBack="false" OnSelectedIndexChanged="stato_SelectedIndexChanged">
                                    <asp:ListItem Value="pending" Text="In attesa"></asp:ListItem>
                                    <asp:ListItem Value="review" Text="Da rivedere"></asp:ListItem>
                                    <asp:ListItem Value="closed" Text="Concluso"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList runat="server" ID="stato" AutoPostBack="false" OnSelectedIndexChanged="stato_SelectedIndexChanged" Enabled="false" AppendDataBoundItems="true">
                                    <asp:ListItem Value="pending" Text="In attesa" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="review" Text="Da rivedere"></asp:ListItem>
                                    <asp:ListItem Value="closed" Text="Concluso"></asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Annullato" InsertVisible="false">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Eval("annull")%>' Enabled="false" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox runat="server" ID="annull" Checked='<%# Bind("annull")%>' Enabled="true" />
                            </EditItemTemplate>
                        </asp:TemplateField>        
                
                        <asp:TemplateField HeaderText="Creato da" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="createdby" Text='<%# Eval("createdby")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField headertext="Creato il" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="created_date" Text='<%# Eval("data_ins")%>' Visible="false" ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato da" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_by" Text='<%# Eval("updatedby")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificato il" Visible="false" ControlStyle-CssClass="form-control">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="updated_date" Text='<%# Eval("data_upd")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-primary btn-hover" ShowCancelButton="true" ShowEditButton="true" ShowInsertButton="true"/>
                
            </Fields>
    </asp:DetailsView>
       </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="UpdateVisit">
        <ProgressTemplate>  
            <div class="updateprogress-modal">
                <div class="updateprogress-center">
                    <asp:Label Text="Aggiornamento in corso..." runat="server" ForeColor="Black" BackColor="White" />    
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:Label ID="lblpopupTargetID" runat="server" style="display:none" ></asp:Label>
    <asp:ModalPopupExtender ID="modalpop" DropShadow="false" BackgroundCssClass="modalBackground" Drag="true" TargetControlID="lblpopupTargetID" runat="server" PopupControlID="popPanel"></asp:ModalPopupExtender>
    <asp:Panel ID="popPanel" runat="server" BackColor="White" HorizontalAlign="Center" Width="300px" Height="150px" BorderColor="Black" BorderWidth="1px" style="border-radius:5px; display:none"  ><br />
        <p>
        <asp:Label ID="popPanelLabel" Text="Inserire nuovo evento?" runat="server" ForeColor="Black" Font-Bold="true" />
        </p>
        <asp:Button ID="btnok" runat="server" Text="SI" CssClass="btn btn-primary btn-hover" OnClick="btnok_Click" Width="50px" />
        <asp:Button ID="btnNo" runat="server" Text="NO" CssClass="btn btn-primary btn-hover" OnClick="btnNo_Click" Width="50px" />
    </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    
</asp:Content>
