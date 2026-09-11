<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="TPA.reports" %>

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
                <asp:ListView ID="lv_search" runat="server" DataSourceID="DataSource_search" >                    
                    <LayoutTemplate>
                        <table class="table table-responsive table-bordered">
                            <tr>
                                <asp:Literal runat="server" ID="litDetails"></asp:Literal>
                            </tr>
                            <tr>
                                <th>EIN</th>
                                <th>Name (Surname, Firstname)</th>                               
                                <th>Group (Code | Desc)</th>                                  
                                <th>Location (Code | Desc)</th>                                                
                                <th>Contract (Code | Desc | Date)</th>
                                <th>Start Date</th>
                                <th>Review Date</th>
                                <th>Termination (Code | Desc | Date)</th>
                                <th>Previous Termination (Code | Desc | Date)</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server"></tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><asp:Label ID="lbl_emp" runat="server" Text='<%#Eval("EIN")%>'></asp:Label></td>                           
                            <td><asp:Label ID="lbl_name" runat="server" Text='<%# Eval("NAME") %>'></asp:Label> </td>                         
                            <td><asp:Label ID="lbl_group_code" runat="server" Text='<%#Eval("GROUPS")%>'></asp:Label></td>                              
                            <td><asp:Label ID="lbl_homelocation" runat="server" Text='<%#Eval("LOCATION")%>'></asp:Label></td>                                   
                            <td><asp:Label ID="Label5" runat="server" Text='<%#Eval("CONTRACT")%>'></asp:Label></td>  
                            <td><asp:Label ID="Label6" runat="server" Text='<%#Eval("ORIGINAL_START_DATE")%>'></asp:Label></td>  
                            <td><asp:Label ID="Label7" runat="server" Text='<%#Eval("REVIEW_DATE")%>'></asp:Label></td>  
                             <td><asp:Label ID="Label9" runat="server" Text='<%#Eval("TERMINATION")%>'></asp:Label></td>  
                            <td><asp:Label ID="Label8" runat="server" Text='<%#Eval("PREVIOUS_TERMINATION")%>'></asp:Label></td> 
                         </tr>  
                    </ItemTemplate>
                    
                    
                    <EmptyDataTemplate>
                        We didn't find any data.
                    </EmptyDataTemplate>
                </asp:ListView>
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
    </div>


    <!-- Custom Modal -->
   <%-- <div id="detailsModal" class="myModal">
        <div class="myModal-content">
            <span class="myClose" onclick="document.getElementById('detailsModal').style.display='none';">&times;</span>
            <asp:Literal ID="litDetails" runat="server"></asp:Literal>
        </div>
    </div>--%>


    <asp:SqlDataSource ID="DataSource_search" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>" ></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_status" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>"
        SelectCommand="SELECT DISTINCT(emp_activity_code) FROM ec_employee ORDER BY emp_activity_code"></asp:SqlDataSource>
</asp:Content>
