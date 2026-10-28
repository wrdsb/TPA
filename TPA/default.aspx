<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TPA._default" %>

<%--<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server"></asp:Content>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

    <script>

        $(function () {
            $(".search_employee_surname").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "default.aspx/GetEmployeeSurname",
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
            $(".search_employee_firstname").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "default.aspx/GetEmployeeFirstname",
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
                    if (ui.item && ui.item.value) {
                        var parts = ui.item.value.split(" - ");
                        var codeOnly = parts[0] ? parts[0].trim() : "";
                        var name = parts[1] ? parts[1].trim() : "";
                
                        $("#<%=txtLocDesc.ClientID %>").val(name);
                        $(this).val(codeOnly);
                    }
                    return false; // Prevents jQuery UI from restoring full string
                },
                focus: function (event, ui) {
                    if (ui.item && ui.item.value) {
                        var parts = ui.item.value.split(" - ");
                        var codeOnly = parts[0] ? parts[0].trim() : "";
                        var name = parts[1] ? parts[1].trim() : "";
                
                        $("#<%=txtLocDesc.ClientID %>").val(name);
                        $(this).val(codeOnly);
                    }
                    return false;
                },
                change: function (event, ui) {
                    // If nothing valid is selected or the field is cleared, reset description
                    if (!ui.item || $.trim($(this).val()) === "") {
                        $("#<%=txtLocDesc.ClientID %>").val("");
                    }
                }
            });

            // Instantly clear description as the user types/deletes characters
            $(".search_location").on("input", function () {
                if ($.trim($(this).val()) === "") {
                    $("#<%=txtLocDesc.ClientID %>").val("");
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
                    if (ui.item && ui.item.value) {
                        var parts = ui.item.value.split(" - ");
                        var codeOnly = parts[0] ? parts[0].trim() : "";
                        var name = parts[1] ? parts[1].trim() : "";

                        // Use .text() or .html() for <asp:Label> (<span>)
                        $("#<%=txtSuperintendentName.ClientID %>").val(name);

                        // If lblSuperintendentName is an <asp:TextBox>, use .val(name) instead

                        $(this).val(codeOnly);
                    }
                    return false; // Prevents jQuery UI from restoring full string
                },
                focus: function (event, ui) {
                    if (ui.item && ui.item.value) {
                        var parts = ui.item.value.split(" - ");
                        var codeOnly = parts[0] ? parts[0].trim() : "";
                        var name = parts[1] ? parts[1].trim() : "";

                        // Use .text() or .html() for <asp:Label> (<span>)
                        $("#<%=txtSuperintendentName.ClientID %>").val(name);

                        $(this).val(codeOnly);
                    }
                    return false;
                },
                change: function (event, ui) {
                    // If nothing valid is selected or the field is cleared, reset description
                    if (!ui.item || $.trim($(this).val()) === "") {
                        $("#<%=txtSuperintendentName.ClientID %>").val("");
                    }
                }
            });

            // Instantly clear description as the user types/deletes characters
            $(".search_location").on("input", function () {
                if ($.trim($(this).val()) === "") {
                    $("#<%=txtSuperintendentName.ClientID %>").val("");
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
                                <asp:TableCell>
                                    <asp:Label ID="lblEmp" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Employee ID"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="tb_empId" TextMode="Number" runat="server" Width="150px" CssClass="form-control search_employeebyempId"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_tb_empId" runat="server" ControlToValidate="tb_empId"
                                        Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required" ValidationGroup="Search">   
                                    </asp:RequiredFieldValidator>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblSurname" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Surname"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="tb_surname" runat="server" Width="150px" CssClass="form-control search_employee_surname"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_tb_surname" runat="server" ControlToValidate="tb_surname"
                                        Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required" ValidationGroup="Search">   
                                    </asp:RequiredFieldValidator>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblFirstName" runat="server" Font-Bold="true" ForeColor="GrayText" Text="First Name"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="tb_firstname" runat="server" Width="150px" CssClass="form-control search_employee_firstname"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_tb_firstname" runat="server" ControlToValidate="tb_firstname"
                                        Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required" ValidationGroup="Search">   
                                    </asp:RequiredFieldValidator>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Button ID="btn_clear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btn_clear_Click" />
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Button ID="btn_search" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btn_search_Click" ValidationGroup="Search" />
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
                        <legend>
                            <asp:Label ID="lblEmpDetails" runat="server" Text="Employee Details"></asp:Label></legend>
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
                                <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" DataFormatString="{0:yyyy-MM-dd}">
                                    <HeaderStyle Width="110px" CssClass="text-nowrap" />
                                    <ItemStyle Width="110px" CssClass="text-nowrap" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Rating" HeaderText="Rating" />
                                <asp:BoundField DataField="Location" HeaderText="Location" />
                                <asp:BoundField DataField="SuperintendentId" HeaderText="Superintendent ID" />
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
                        <br />
                        <!-- Form Panel (Hidden by default) -->


                        <asp:Panel ID="pnlRecordForm" runat="server" Visible="false" BorderStyle="Double" BorderColor="LightGray" CssClass="card card-body mb-4 bg-light">
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
                                    <asp:TableCell>
                                        <asp:Label ID="lblEvaluationCategory" runat="server" Font-Bold="true" ForeColor="GrayText" Width="180 px " Text="Evaluation Category"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="3">
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="-- Select Category --" Value="" />
                                            <asp:ListItem Text="NEW" Value="NEW" />
                                            <asp:ListItem Text="PERMANENT" Value="PERMANENT" />
                                            <asp:ListItem Text="EVAL YEAR" Value="EVAL YEAR" />
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfv_ddlCategory" runat="server" ControlToValidate="ddlCategory"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                </asp:TableRow>


                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:Label ID="lblReviewStartYear" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Review Start Year"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtReviewStartYear" runat="server" Width="330 px" TextMode="Number" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfv_txtReviewStartYear" runat="server" ControlToValidate="txtReviewStartYear"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblReviewEndYear" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Review End Year"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtReviewEndYear" runat="server" Width="330 px" TextMode="Number" CssClass="form-control" />
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
                                </asp:TableRow>


                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:Label ID="lblReviewDate" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Review Date"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtReviewDate" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfv_txtReviewDate" runat="server" ControlToValidate="txtReviewDate"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                        <!-- JavaScript -->
                                        <script type="text/javascript">
                                            $(function () {
                                                $("#txtReviewDate").datepicker({
                                                    dateFormat: "yy-mm-dd" // In jQuery UI, 'yy' stands for a 4-digit year
                                                });
                                            });
                                        </script>
                                        <!-- Enforces the strict yyyy-mm-dd format -->
                                        <asp:RegularExpressionValidator
                                            ID="rev_revDate"
                                            runat="server"
                                            ControlToValidate="txtReviewDate"
                                            ValidationExpression="^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$"
                                            ErrorMessage="Invalid date format. Please use YYYY-MM-DD."
                                            ForeColor="Red"
                                            Display="Dynamic">
                                        </asp:RegularExpressionValidator>

                                        <%-- jQuery Date control example to maintain specific date format - for reference

                                            <!-- Markup -->
                                        <asp:TextBox ID="txtJqueryDate" runat="server" clientidmode="Static"></asp:TextBox>
                                        <!-- JavaScript -->
                                        <script type="text/javascript">
                                            $(function () {
                                                $("#txtJqueryDate").datepicker({
                                                    dateFormat: "yy-mm-dd" // In jQuery UI, 'yy' stands for a 4-digit year
                                                });
                                            });
                                        </script>--%>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblRating" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Rating"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="-- Select Rating --" Value="" />
                                            <asp:ListItem Text="EXEMPLARY" Value="EXEMPLARY" />
                                            <asp:ListItem Text="GOOD" Value="GOOD" />
                                            <asp:ListItem Text="PRE TPA" Value="PRE TPA" />
                                            <asp:ListItem Text="DEVELOPMENT NEEDED" Value="DEVELOPMENT NEEDED" />
                                            <asp:ListItem Text="SATISFACTORY" Value="SATISFACTORY" />
                                            <asp:ListItem Text="UNSATISFACTORY" Value="UNSATISFACTORY" />
                                        </asp:DropDownList>
                                        <%--<asp:RequiredFieldValidator ID="rfv_ddlRating" runat="server" ControlToValidate="ddlRating"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>--%>
                                    </asp:TableCell>
                                </asp:TableRow>


                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:Label ID="lblLocation" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Location"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control search_location" />
                                        <asp:TextBox ID="txtLocDesc" runat="server" CssClass="form-control" Enabled="false" />
                                        <asp:RequiredFieldValidator ID="rfv_txtLocation" runat="server" ControlToValidate="txtLocation"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblSuperIntendentId" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Superintendent ID"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtSuperintendentId" runat="server" CssClass="form-control search_superintent" />
                                        <asp:TextBox ID="txtSuperintendentName" runat="server" CssClass="form-control" Enabled="false" />
                                        <%--<asp:RequiredFieldValidator ID="rfv_txtSuperintendentId" runat="server" ControlToValidate="txtSuperintendentId"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>--%>
                                    </asp:TableCell>
                                </asp:TableRow>


                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:Label ID="lblComment" runat="server" Font-Bold="true" ForeColor="GrayText" Text="Comment"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="3">
                                        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                                        <%--<asp:RequiredFieldValidator ID="rfv_txtComment" runat="server" ControlToValidate="txtComment"
                                            Display="Dynamic" Text="Required" ForeColor="Red" ErrorMessage="Required"
                                            ValidationGroup="submit">
                                        </asp:RequiredFieldValidator>--%>
                                    </asp:TableCell>
                                </asp:TableRow>


                                <asp:TableFooterRow>
                                    <asp:TableCell>
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" OnClick="btnCancel_Click" CausesValidation="false" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Button ID="btnSave" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSave_Click" ValidationGroup="submit" />
                                    </asp:TableCell>
                                </asp:TableFooterRow>

                            </asp:Table>
                        </asp:Panel>
                        <br />
                    </fieldset>
                </asp:Panel>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="DataSource_search" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>"></asp:SqlDataSource>

</asp:Content>
