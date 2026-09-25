<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TPA._default" %>

<%--<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server"></asp:Content>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

    <script>

        $(function () {
            $(".search_groupcode").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "reports.aspx/GetGroupCode",
                        type: "POST",
                        data: JSON.stringify({ prefix: request.term }),
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response(data.d);
                        }
                    });
                },
                minLength: 1
            });
        });

        $(function () {
            $(".search_job").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "reports.aspx/GetJob",
                        type: "POST",
                        data: JSON.stringify({ prefix: request.term }),
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response(data.d);
                        }
                    });
                },
                minLength: 1
            });
        });

        function openAddModal() {
            // Reset form fields for new record entry
            document.getElementById('<%= hfRecordId.ClientID %>').value = "0";
            document.getElementById('<%= ddlCategory.ClientID %>').selectedIndex = 0;
            document.getElementById('<%= txtReviewDate.ClientID %>').value = "";
            document.getElementById('<%= ddlRating.ClientID %>').selectedIndex = 0;
            document.getElementById('<%= txtLocation.ClientID %>').value = "";
            document.getElementById('<%= txtComment.ClientID %>').value = "";

            // Change modal title
            document.getElementById('recordModalLabel').innerText = "Add New Record";

            // Open Bootstrap 5 Modal
            var modalElement = document.getElementById('recordModal');
            var modalInstance = bootstrap.Modal.getOrCreateInstance(modalElement);
            modalInstance.show();
        }

    </script>
    <style>
        .ui-autocomplete {
            max-height: 200px; /* Adjust height as needed */
            overflow-y: auto; /* Enable scroll */
            overflow-x: hidden; /* Hide horizontal scrollbar */
            border: 1px solid #ccc; /* Optional: nicer border */
            z-index: 99999 !important; /* Make sure it appears above other controls */
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btn_search">
                    <asp:Table runat="server">
                        <asp:TableRow>
                            <asp:TableCell>Emp Id</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="tb_empId" runat="server" Width="150px" CssClass="form-control"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>Surname</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="tb_surname" runat="server" Width="150px" CssClass="form-control"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>First Name</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="tb_firstname" runat="server" Width="150px" CssClass="form-control"></asp:TextBox>
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
            </div>
        </div>

        <!-- For Grid -->

        <div class="row">
            <div class="col-md-12" style="min-height: 200px;">
                <asp:ListView ID="lv_search" runat="server" DataSourceID="DataSource_search">
                    <LayoutTemplate>
                        <table class="table table-responsive table-bordered">
                            <tr>
                                <asp:Literal runat="server" ID="litDetails"></asp:Literal>
                            </tr>
                            <tr>
                                <th>EIN</th>
                                <th>Name
                                    <br />
                                    (Surname, Firstname)</th>
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
                            <td>
                                <asp:Label ID="lbl_emp" runat="server" Text='<%#Eval("EIN")%>'></asp:Label></td>
                            <td>
                                <asp:Label ID="lbl_name" runat="server" Text='<%# Eval("NAME") %>'></asp:Label>
                            </td>
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

                <!-- Add Button (hidden) -->
                <asp:Button ID="btnAdd" runat="server" Text="Add New Appraisal" Visible="false"
                    CssClass="btn btn-primary mb-3" OnClick="btnAdd_Click" />
                <%-- <asp:DataPager ID="MyDataPager" EnableEventValidation="false" runat="server" PagedControlID="lv_search" PageSize="25">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button"
                            ShowFirstPageButton="True" ShowLastPageButton="True"
                            PreviousPageText="&laquo; Prev"
                            NextPageText="Next &raquo;"
                            FirstPageText="First"
                            LastPageText="Last" />
                        <asp:NumericPagerField ButtonCount="5" />
                    </Fields>
                </asp:DataPager>
                <!-- Add multiple &nbsp; for more space -->
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblCount" runat="server" CssClass="text-info"></asp:Label>--%>
            </div>
        </div>




        <!-- For Appraisal Grid -->
        <div class="row">
            <div class="col-md-12" style="min-height: 200px;">



                <asp:GridView ID="appraisalRecordsGrid" runat="server" DataKeyNames="ReviewDate" AutoGenerateColumns="False" CssClass="table-responsive table-bordered">
                    <Columns>
                        <asp:BoundField DataField="EvaluationCategory" HeaderText="Category" />
                        <asp:BoundField DataField="ReviewYear" HeaderText="Review Year" />
                        <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" DataFormatString="{0:MM-dd-yyyy HH:mm:ss}"  />
                        <asp:BoundField DataField="Rating" HeaderText="Rating" />
                        <asp:BoundField DataField="Location" HeaderText="Location" />
                        <asp:BoundField DataField="SuperintendentId" HeaderText="Superintendent Id" />
                        <asp:BoundField DataField="Comment" HeaderText="Comment" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit"
                                    runat="server"
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
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>


                <!-- Form Panel (Hidden by default) -->


                <asp:Panel ID="pnlRecordForm" runat="server" Visible="false" CssClass="card card-body mb-4 bg-light">

                    <div class="announcement">
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
                            <asp:TableCell> Evaluation Category </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddlCategory" runat="server" Width="200px" CssClass="form-control">
                                    <asp:ListItem Text="-- Select Category --" Value="" />
                                    <asp:ListItem Text="NEW" Value="NEW" />
                                    <asp:ListItem Text="PERMANENT" Value="PERMANENT" />
                                    <asp:ListItem Text="EVAL_YEAR" Value="EVAL_YEAR" />
                                </asp:DropDownList>
                            </asp:TableCell>
                            <asp:TableCell>Review Start Year</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtReviewStartYear" runat="server" CssClass="form-control" Placeholder="e.g. 1992" />
                            </asp:TableCell>
                            <asp:TableCell>Review End Year</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtReviewEndYear" runat="server" CssClass="form-control" Placeholder="e.g. 1993" />
                            </asp:TableCell>
                            <asp:TableCell>Review Date</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtReviewDate" runat="server" TextMode="Date" CssClass="form-control" />
                            </asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow>
                            <asp:TableCell>Rating</asp:TableCell>
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
                            </asp:TableCell>

                            <asp:TableCell>Location</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" />
                            </asp:TableCell>


                            <asp:TableCell>Superintendent Id</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtSuperintendentId" runat="server" CssClass="form-control" />
                            </asp:TableCell>
                        </asp:TableRow>

                    </asp:Table>

                    <div class="col-md-12">
                        <label class="form-label">Comment</label>
                        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                    </div>

                    <div class="col-md-12 text-end mt-3">
                        <asp:Button ID="btnSave" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                        <asp:Label ID="lblsubmit" runat="server" Font-Bold ="true" Font-Size="Large" BackColor="YellowGreen" Visible="false"></asp:Label> 
                    </div>

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
