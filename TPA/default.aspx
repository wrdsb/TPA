<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TPA._default" %>

<%--<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server"></asp:Content>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

    <script>

        $(function () {
            $(".search_employee").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "default.aspx/GetEmployee",
                        type: "POST",
                        data: JSON.stringify({ prefix: request.term }),
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.DisplayText, // Text shown in the dropdown list
                                    value: item.DisplayText,
                                    empId: item.EmpId,
                                    surname: item.Surname,
                                    firstName: item.FirstName
                                };
                            }));
                        }
                    });
                },
                minLength: 1,
                select: function (event, ui) {
                    // Fill all three textboxes when an item is chosen
                    $("#<%= tb_empId.ClientID %>").val(ui.item.empId);
                    $("#<%= tb_surname.ClientID %>").val(ui.item.surname);
                    $("#<%= tb_firstname.ClientID %>").val(ui.item.firstName);

                    return false; // Prevents default replacement behavior
                }
            });
        });

        $(function () {
            $(".search_employeebyempId").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "default.aspx/GetEmployeebyempId",
                        type: "POST",
                        data: JSON.stringify({ prefix: request.term }),
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.DisplayText, // Text shown in the dropdown list
                                    value: item.DisplayText,
                                    empId: item.EmpId,
                                    surname: item.Surname,
                                    firstName: item.FirstName
                                };
                            }));
                        }
                    });
                },
                minLength: 1,
                select: function (event, ui) {
                    // Fill all three textboxes when an item is chosen
                    $("#<%= tb_empId.ClientID %>").val(ui.item.empId);
                    $("#<%= tb_surname.ClientID %>").val(ui.item.surname);
                    $("#<%= tb_firstname.ClientID %>").val(ui.item.firstName);

                    return false; // Prevents default replacement behavior
                }
            });
        });

        $(function () {
            $(".search_location").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "default.aspx/GetLocation",
                        type: "POST",
                        data: JSON.stringify({ prefix: request.term }),
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response(data.d);
                        }
                    });
                },
                minLength: 1,
                select: function (event, ui) {
                    // Extract only the code part before " - "
                    var codeOnly = ui.item.value.split(" - ")[0].trim();
                    $(this).val(codeOnly);
                    return false; // Prevents jQuery UI from restoring full string
                },
                focus: function (event, ui) {
                    // Updates textbox while navigating dropdown with arrow keys
                    var codeOnly = ui.item.value.split(" - ")[0].trim();
                    $(this).val(codeOnly);
                    return false;
                }
            });
        });

        $(function () {
            $(".search_superintent").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "default.aspx/GetSuperintent",
                        type: "POST",
                        data: JSON.stringify({ prefix: request.term }),
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response(data.d);
                        }
                    });
                },
                minLength: 1,
                select: function (event, ui) {
                    // Extract only the code part before " - "
                    var codeOnly = ui.item.value.split(" - ")[0].trim();
                    $(this).val(codeOnly);
                    return false; // Prevents jQuery UI from restoring full string
                },
                focus: function (event, ui) {
                    // Updates textbox while navigating dropdown with arrow keys
                    var codeOnly = ui.item.value.split(" - ")[0].trim();
                    $(this).val(codeOnly);
                    return false;
                }
            });
        });


    </script>
    <style>
        .ui-autocomplete {
            max-height: 200px; /* Adjust height as needed */
            overflow-y: auto; /* Enable scroll */
            overflow-x: hidden; /* Hide horizontal scrollbar */
            border: 1px solid #ccc; /* Optional: nicer border */
            z-index: 99999 !important; /* Make sure it appears above other controls */
        }

        /* Existing green style */
        .announcement {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
        }

        /* New orange style for modify mode */
        .announcement-modify {
            background-color: #fff3cd;
            border: 1px solid #ffeeba;
            color: #856404;
            padding: 10px;
            border-radius: 4px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <fieldset id="fd_searcchEmployee">
                    <legend>Search Employee</legend>
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btn_search">
                        <asp:Table runat="server">
                            <asp:TableRow>
                                <asp:TableCell><asp:Label ID ="lblEmp" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Emp Id"></asp:Label></asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="tb_empId" TextMode="Number" runat="server" Width="150px" CssClass="form-control search_employeebyempId"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell><asp:Label ID="lblSurname" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Surname"></asp:Label></asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="tb_surname" runat="server" Width="150px" CssClass="form-control search_employee"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell><asp:Label ID="lblFirstName" runat="server" Font-Bold="true" ForeColor="GrayText" Text="First Name"></asp:Label></asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="tb_firstname" runat="server" Width="150px" CssClass="form-control search_employee"></asp:TextBox>
                                </asp:TableCell>

                                <asp:TableCell>
                                    <asp:Button ID="btn_clear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btn_clear_Click" />
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Button ID="btn_search" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btn_search_Click" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:Panel>
                    <br />
                </fieldset>
            </div>
        </div>

        <!-- For Grid -->

        <div class="row">
            <div class="col-md-12" style="min-height: 200px;">
                <asp:Panel ID="pnl_employee" Visible="false" runat="server">
                    <fieldset id="fd_employeeDetails" runat="server">
                        <legend>Employee Details</legend>
                        <asp:ListView ID="lv_search" runat="server" DataSourceID="DataSource_search">
                            <LayoutTemplate>
                                <table class="table table-responsive table-bordered">
                                    <tr>
                                        <asp:Literal runat="server" ID="litDetails"></asp:Literal>
                                    </tr>
                                    <tr>
                                        <%--<th>EIN</th>
                                        <th>Name
                                    <br />
                                            (Surname, Firstname)</th>--%>
                                        <th><span style="white-space: nowrap;">Group</span>
                                            <br />
                                            <span style="white-space: nowrap;">(Code | Desc)</span></th>
                                        <th><span style="white-space: nowrap;">Location</span>
                                            <br />
                                            <span style="white-space: nowrap;">(Code | Desc)</span></th>
                                        <th><span style="white-space: nowrap;">Contract</span>
                                            <br />
                                            <span style="white-space: nowrap;">(Code | Desc | Date)</span></th>
                                        <th style="white-space: nowrap;">Start Date</th>
                                        <th style="white-space: nowrap;">Review Date</th>
                                        <th><span style="white-space: nowrap;">Termination</span>
                                            <br />
                                            <span style="white-space: nowrap;">(Code | Desc | Date)</span></th>
                                        <th><span style="white-space: nowrap;">Previous Termination </span>
                                            <br />
                                            <span style="white-space: nowrap;">(Code | Desc | Date)</span></th>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <%--<td>
                                        <asp:Label ID="lbl_emp" runat="server" Text='<%#Eval("EIN")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_name" runat="server" Text='<%# Eval("NAME") %>'></asp:Label>
                                    </td>--%>
                                    <td>
                                        <asp:Label ID="lbl_group_code" runat="server" Text='<%#Eval("GROUPS")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_homelocation" runat="server" Text='<%#Eval("LOCATION")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_contract" runat="server" Text='<%#Eval("CONTRACT")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_startdate" runat="server" Text='<%#Eval("ORIGINAL_START_DATE")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_reviewdate" runat="server" Text='<%#Eval("REVIEW_DATE")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_termination" runat="server" Text='<%#Eval("TERMINATION")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_prevtermination" runat="server" Text='<%#Eval("PREVIOUS_TERMINATION")%>'></asp:Label></td>
                                </tr>
                            </ItemTemplate>


                            <EmptyDataTemplate>
                                We didn't find any data.
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </fieldset>
                </asp:Panel>
            </div>
        </div>

        <!-- For Appraisal Grid -->
        <div class="row">
            <div class="col-md-12" style="min-height: 200px;">
                <asp:Panel ID="pnl_appraisal" Visible="false" runat="server">
                    <fieldset id="fd_appraisalDetails" runat="server">
                        <legend>Appraisal Details</legend>

                        <asp:GridView ID="appraisalRecordsGrid" runat="server" DataKeyNames="Id" AutoGenerateColumns="False" CssClass="table-responsive table-bordered" OnRowCommand="appraisalRecordsGrid_RowCommand">

                            <SelectedRowStyle BackColor="#FFF3CD" ForeColor="#856404" Font-Bold="true" />

                            <Columns>
                                <asp:BoundField DataField="EvaluationCategory" HeaderText="Evaluation Category" />
                                <asp:BoundField DataField="ReviewStartYear" HeaderText="Review Start Year" />
                                <asp:BoundField DataField="ReviewEndYear" HeaderText="Review End Year" />
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="Rating" HeaderText="Rating" />
                                <asp:BoundField DataField="Location" HeaderText="Location" />
                                <asp:BoundField DataField="SuperintendentId" HeaderText="Superintendent Id" />
                                <asp:BoundField DataField="Comment" HeaderText="Comment" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <div style="display: flex; gap: 5px; white-space: nowrap;">
                                            <asp:LinkButton ID="btnEdit"
                                                runat="server"
                                                CommandName="ModifyRecord"
                                                CommandArgument='<%# Container.DataItemIndex %>'
                                                Text="Modify"
                                                CssClass="btn btn-sm btn-warning"
                                                OnClick="btnEdit_Click" />
                                            <asp:LinkButton ID="btnDelete"
                                                runat="server"
                                                Text="Delete"
                                                CssClass="btn btn-sm btn-danger"
                                                CommandArgument='<%# Container.DataItemIndex %>'
                                                OnClick="btnDelete_Click"
                                                OnClientClick="return confirm('Are you sure to delete the appraisal record?');" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                        <!-- Add Button (hidden) -->
                        <asp:Button ID="btnAdd" runat="server" Text="Add New Appraisal" Visible="false"
                            CssClass="btn btn-success mb-3" OnClick="btnAdd_Click" />

                        <br />
                        <!-- Form Panel (Hidden by default) -->


                        <asp:Panel ID="pnlRecordForm" runat="server" Visible="false" CssClass="card card-body mb-4 bg-light">
                            <br />
                            <div id="div_appraisalAlert" runat="server" class="announcement">
                                <asp:Label ID="lblFormTitle"
                                    runat="server"
                                    Font-Bold="true"
                                    Text="Please submit new appraisal">                       
                                </asp:Label>
                            </div>



                            <!-- Hidden Field to track Edit vs Add (0 = New) -->
                            <asp:HiddenField ID="hfRecordId" runat="server" Value="0" />
                            <asp:Table runat="server">
                                <asp:TableRow>
                                    <asp:TableCell><asp:Label ID="lblEvaluationCategory" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Evaluation Category"></asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlCategory" runat="server" Width="200px" CssClass="form-control">
                                            <asp:ListItem Text="-- Select Category --" Value="" />
                                            <asp:ListItem Text="NEW" Value="NEW" />
                                            <asp:ListItem Text="PERMANENT" Value="PERMANENT" />
                                            <asp:ListItem Text="EVAL_YEAR" Value="EVAL_YEAR" />
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfv_ddlCategory" runat="server" ControlToValidate="ddlCategory"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                    <asp:TableCell><asp:Label ID="lblReviewStartYear" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Review Start Year"></asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtReviewStartYear" runat="server" TextMode="Number" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfv_txtReviewStartYear" runat="server" ControlToValidate="txtReviewStartYear"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                    <asp:TableCell><asp:Label ID="lblReviewEndYear" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Review End Year"></asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtReviewEndYear" runat="server" TextMode="Number" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfv_txtReviewEndYear" runat="server" ControlToValidate="txtReviewEndYear"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="cv_YearRange" runat="server"
                                            ControlToValidate="txtReviewEndYear"
                                            ControlToCompare="txtReviewStartYear"
                                            Operator="GreaterThan"
                                            Type="Integer"
                                            ErrorMessage="End year must be greater than start year."
                                            ForeColor="Red" Display="Dynamic"
                                            ValidationGroup="submit" />
                                    </asp:TableCell>
                                    <asp:TableCell><asp:Label ID="lblReviewDate" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Review Date"></asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtReviewDate" runat="server" TextMode="Date" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfv_txtReviewDate" runat="server" ControlToValidate="txtReviewDate"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>

                                    </asp:TableCell>
                                </asp:TableRow>

                                <asp:TableRow>
                                    <asp:TableCell><asp:Label ID="lblRating" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Rating"></asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlRating" runat="server" Width="200px" CssClass="form-control">
                                            <asp:ListItem Text="-- Select Rating --" Value="" />
                                            <asp:ListItem Text="EXEMPLARY" Value="EXEMPLARY" />
                                            <asp:ListItem Text="GOOD" Value="GOOD" />
                                            <asp:ListItem Text="PRE TPA" Value="PRE TPA" />
                                            <asp:ListItem Text="DEVELOPMENT NEEDED" Value="DEVELOPMENT NEEDED" />
                                            <asp:ListItem Text="SATISFACTORY" Value="SATISFACTORY" />
                                            <asp:ListItem Text="UNSATISFACTORY" Value="UNSATISFACTORY" />
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfv_ddlRating" runat="server" ControlToValidate="ddlRating"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>

                                    <asp:TableCell><asp:Label ID="lblLocation" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Location"></asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control search_location" />
                                        <asp:RequiredFieldValidator ID="rfv_txtLocation" runat="server" ControlToValidate="txtLocation"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>


                                    <asp:TableCell><asp:Label ID="lblSuperIntendentId" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Superintendent Id"></asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtSuperintendentId" runat="server" CssClass="form-control search_superintent" />
                                        <asp:RequiredFieldValidator ID="rfv_txtSuperintendentId" runat="server" ControlToValidate="txtSuperintendentId"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>

                            </asp:Table>

                            <div class="col-md-12">
                                <asp:Label runat="server" Font-Bold="true" ForeColor="GrayText" Text="Comment"></asp:Label>
                                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfv_txtComment" runat="server" ControlToValidate="txtComment"
                                    Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                    ValidationGroup="submit">
                                </asp:RequiredFieldValidator>
                                <br />
                            </div>

                            <div class="col-md-12 text-end mt-3">
                                <asp:Button ID="btnSave" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSave_Click" ValidationGroup="submit" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                                <asp:Label ID="lblsubmit" runat="server" Font-Bold="true" Font-Size="Large" BackColor="LightYellow" Visible="false"></asp:Label>
                            </div>

                        </asp:Panel>
                        <br />
                    </fieldset>
                </asp:Panel>


            </div>
        </div>




    </div>


    <!-- Custom Modal -->
    <%-- <div id="detailsModal" class="myModal">
        <div class="myModal-content">
            <span class="myClose" onclick="document.getElementById('detailsModal').style.display='none';">&times;</span>
            <asp:Literal ID="litDetails" runat="server"></asp:Literal>
        </div>
    </div>--%>


    <asp:SqlDataSource ID="DataSource_search" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_status" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>"
        SelectCommand="SELECT DISTINCT(emp_activity_code) FROM ec_employee ORDER BY emp_activity_code"></asp:SqlDataSource>
</asp:Content>
