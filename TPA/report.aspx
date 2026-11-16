<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="TPA.report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

    <script></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <fieldset id="fd_searcchEmployee">
                    <legend>Report Links</legend>
                    <asp:Panel ID="pnlSearch" runat="server">
                        <asp:Table runat="server">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <a href="http://ec-hr-dbt/Reports/report/HR/TPA/DECE%20Performace%20Appraisal">DECE Performance Appraisal</a>                              
                                </asp:TableCell>
                                <asp:TableCell>
                                     <a href="http://ec-hr-dbt/Reports/report/HR/TPA/LTO%20Performance%20Appraisal">LTO Performance Appraisal</a>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <a href="http://ec-hr-dbt/Reports/report/HR/TPA/NTIP_TO_OCT">NTIP TO OCT</a>                                  
                                </asp:TableCell>
                                <asp:TableCell>
                                    <a href="http://ec-hr-dbt/Reports/report/HR/TPA/NTIP_TO_OCT_file">NTIP TO OCT File</a>                                  
                                </asp:TableCell>
                                <asp:TableCell>
                                    <a href="http://ec-hr-dbt/Reports/report/HR/TPA/Teacher%20Performace%20Appraisal">Teacher Performance Appraisal</a>                                  
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:Panel>
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>
