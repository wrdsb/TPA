using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Reflection.Emit;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPA
{
    public partial class reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            if (Session["auditComplete"] == null || Convert.ToBoolean(Session["auditComplete"]) == false)
            {
                Response.Redirect("Login.aspx");
            }

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetAllowResponseInBrowserHistory(false);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();

            if (!Page.IsPostBack)
            {
                if (Session["surname"] == null || Session["firstname"] == null)
                {
                    Session.Clear();
                    Session.Abandon();

                    Response.Redirect("login.aspx");
                }
                string qry = Global.searchQuery;

                if (!string.IsNullOrEmpty(qry)) // if redirected from smartphone page.
                {
                    tb_empId.Text = Session["empId_text"] != null ? Session["empId_text"].ToString() : string.Empty;
                    tb_surname.Text = Session["surname_text"] != null ? Session["surname_text"].ToString() : string.Empty;
                    tb_firstname.Text = Session["firstname_text"] != null ? Session["firstname_text"].ToString() : string.Empty;


                    showSearchData();
                }

            }
        }


        protected void btn_search_Click(object sender, EventArgs e)
        {
            if (!GenerateQuery())
            {
                return;
            }

            showSearchData();
            saveSearchDetailsintoDB();
            LoadAppraisalrecords();
        }

        string searchFilter = string.Empty;
        string empid
        {
            get { return tb_empId.Text.Trim(); }
        }

        string surname
        {
            get { return tb_surname.Text.Trim(); }
        }

        string firstname
        {
            get { return tb_firstname.Text.Trim(); }
        }




        bool GenerateQuery()
        {

            searchFilter = string.Empty;


            try
            {
                string query = "";

                if (string.IsNullOrEmpty(surname) &&

                    string.IsNullOrEmpty(empid) &&
                    string.IsNullOrEmpty(firstname)

                    )
                    return false;

                var filtersObj = new
                {
                    Empid = empid,
                    Surname = surname,
                    Firstname = firstname

                };

                searchFilter = "Search Parameters : " + JsonConvert.SerializeObject(filtersObj);



                query = @"  SELECT		emp.EMPLOYEE_ID                                                     AS EIN
			                            , emp.SURNAME+', '+emp.FIRST_NAME                                   AS NAME
                                        , CONCAT_WS
											(' | ', 
			                                emp.EMP_GROUP_CODE,                    
			                                grp.DESCRIPTION_ABBR                    
                                            )                                                               AS GROUPS                
                                        , CONCAT_WS
											(' | ', 
			                                emp.HOME_LOCATION_CODE,                
			                                loc.DESCRIPTION_ABBR                  
                                            )                                                               AS LOCATION
                                        , CONCAT_WS
											(' | ', 
			                                emp.CONTRACT_CODE,                     
			                                cnt.DESCRIPTION_ABBR,                  
			                                CONVERT(VARCHAR(10), emp.CONTRACT_DATE, 120)                   
                                            )                                                               AS CONTRACT
			                            , CONVERT(VARCHAR(10), emp.ORIGINAL_START_DATE, 120)                AS ORIGINAL_START_DATE
			                            , CONVERT(VARCHAR(10), emp.REVIEW_DATE , 120)                       AS REVIEW_DATE
			                            , CONCAT_WS
											(' | ', 
											emp.TERMINATION_CODE,                 
											t.DESCRIPTION_ABBR,					
											CONVERT(VARCHAR(10), emp.TERMINATION_DATE, 120)                 
											)									                            AS TERMINATION
			                            , CONCAT_WS
											(' | ', 
											emp.PREVIOUS_TERMINATION_CODE, 
											pt.DESCRIPTION_ABBR, 
											CONVERT(VARCHAR(10), emp.PREVIOUS_TERMINATION_DATE, 120)
											)									                            AS PREVIOUS_TERMINATION
                            FROM		EC_EMPLOYEE emp
                            JOIN		EC_GROUP_CODES grp			ON  grp.EMP_GROUP_CODE = emp.EMP_GROUP_CODE
                            JOIN		EC_LOCATIONS loc			ON	loc.LOCATION_CODE = emp.HOME_LOCATION_CODE
                            LEFT JOIN	EC_CODE_CONTRACT_CODE cnt	ON	cnt.CODE_VALUE = emp.CONTRACT_CODE
                            LEFT JOIN	EC_CODE_TERMINATION_CODE t	ON	t.CODE_VALUE = emp.TERMINATION_CODE
                            LEFT JOIN	EC_CODE_TERMINATION_CODE pt	ON	pt.CODE_VALUE = emp.PREVIOUS_TERMINATION_CODE
                            WHERE ";



                query += string.IsNullOrEmpty(firstname) ? "" : "emp.first_name LIKE '%' +@firstname+ '%' AND ";
                query += string.IsNullOrEmpty(surname) ? "" : "emp.surname LIKE '%' + @surname+ '%' AND ";
                query += string.IsNullOrEmpty(empid) ? "" : "emp.employee_id = @empid AND ";

                query = query.Substring(0, query.Length - 4);


                Global.searchQuery = query;
                return true;
            }
            catch (Exception ex)
            {
                Loggers.Log("Error occurred while building search query from reports page by user: " + Session["username"] + " . Error: " + ex.Message);
                Loggers.Log("Stack Trace: " + ex.StackTrace);
                Loggers.Log("Inner Exception: " + (ex.InnerException != null ? ex.InnerException.Message : "N/A"));
                Loggers.Log("Source: " + ex.Source);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while building the search query. Please try again later.');", true);
                return false;
            }
        }

        protected void showSearchData()
        {
            try
            {
                DataSource_search.SelectCommand = Global.searchQuery;
                //Response.Write("Executing Query: " + DataSource_search.SelectCommand);
                LoadParameters();
                lv_search.DataBind();
                lv_search.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                Loggers.Log("Error occurred while binding search query " + Session["username"] + " . Error: " + ex.Message);
                Loggers.Log("Stack Trace: " + ex.StackTrace);
                Loggers.Log("Inner Exception: " + (ex.InnerException != null ? ex.InnerException.Message : "N/A"));
                Loggers.Log("Source: " + ex.Source);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while binding search query. Please try again later.');", true);
            }

        }

        void LoadParameters()
        {
            try
            {
                // Clear old parameters(important!)
                DataSource_search.SelectParameters.Clear();

                if (!string.IsNullOrEmpty(firstname))
                    DataSource_search.SelectParameters.Add("firstname", firstname);
                if (!string.IsNullOrEmpty(surname))
                    DataSource_search.SelectParameters.Add("surname", surname);

                if (!string.IsNullOrEmpty(empid))
                    DataSource_search.SelectParameters.Add("empid", empid);


            }
            catch (Exception ex)
            {
                Loggers.Log("Error occurred while loading parameters from reports page by user: " + Session["username"] + " . Error: " + ex.Message);
                Loggers.Log("Stack Trace: " + ex.StackTrace);
                Loggers.Log("Inner Exception: " + (ex.InnerException != null ? ex.InnerException.Message : "N/A"));
                Loggers.Log("Source: " + ex.Source);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while loading parameters. Please try again later.');", true);
            }
        }



        protected void btn_clear_Click(object sender, EventArgs e)
        {
            Global.searchQuery = string.Empty;
            clearSessionValues();
            Response.Redirect("reports.aspx");
        }

        void clearSessionValues()
        {
            Session["empId_text"] = null;
            Session["surname_text"] = null;
            Session["firstname_text"] = null;
            Session["formername_text"] = null;
            Session["knownasfirstname_text"] = null;
            Session["knownassurname_text"] = null;
            Session["pal_text"] = null;
            Session["email_text"] = null;
            Session["phone_text"] = null;
            Session["groupcode_text"] = null;
            Session["job_text"] = null;
            Session["status_list"] = null;
        }








        [System.Web.Services.WebMethod]
        public static List<string> GetGroupCode(string prefix)
        {
            List<string> result = new List<string>();
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLDB"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT DISTINCT emp_group_code AS grpcode " +
                                                    "FROM ec_employee_positions " +
                                                    "WHERE emp_group_code LIKE '%' + @p + '%' " +
                                                    "ORDER BY emp_group_code", con);
                    cmd.Parameters.AddWithValue("@p", prefix);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        result.Add(dr["grpcode"].ToString());
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                Loggers.Log("Error in GetGroupCode autocomplete method: " + ex.Message);
                return result;
            }
        }

        [System.Web.Services.WebMethod]
        public static List<string> GetJob(string prefix)
        {
            List<string> result = new List<string>();
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLDB"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT DISTINCT job_code AS jobcode, description_text AS jobdesc " +
                                                    "FROM ec_jobs " +
                                                    "WHERE job_code LIKE '%' + @p + '%' OR description_text LIKE '%' + @p2 + '%' " +
                                                    "ORDER BY job_code", con);
                    cmd.Parameters.AddWithValue("@p", prefix);
                    cmd.Parameters.AddWithValue("@p2", prefix);
                    var query = cmd.CommandText;
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        result.Add(dr["jobcode"].ToString() + " - " + dr["jobdesc"].ToString());
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                Loggers.Log("Error in GetJob autocomplete method: " + ex.Message);
                return result;

            }
        }

        void saveSearchDetailsintoDB()
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SQLDB_HDHRP"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    var query = "INSERT INTO hd_tpa_audit (employee_id, firstname, surname, emailaddress, userid, Purpose, inquiry_date) " +
                                "VALUES (@empId, @firstName, @surName, @email, @userId, @purpose, @currenDate)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@empId", Session["ein"]);
                        cmd.Parameters.AddWithValue("@firstName", Session["firstname"]);
                        cmd.Parameters.AddWithValue("@surName", Session["surname"]);
                        cmd.Parameters.AddWithValue("@email", Session["email"]);
                        cmd.Parameters.AddWithValue("@userId", Session["username"]);
                        cmd.Parameters.AddWithValue("@purpose", searchFilter);
                        cmd.Parameters.AddWithValue("@currenDate", DateTime.Now);

                        cmd.ExecuteNonQuery();
                    }

                    con.Close();
                }
            }
            catch (Exception ex)
            {
                Loggers.Log("Error inserting audit record: " + ex.Message);
                throw new Exception("Error inserting audit record: " + ex.Message);
            }
        }

        void LoadAppraisalrecords()
        {
            //TODO : load data from the table into the grid

            foreach (ListViewItem item in lv_search.Items)
            {
                // Check to ensure it is a data row, not a header/footer
                if (item.ItemType == ListViewItemType.DataItem)
                {
                    // Find the label control inside this row
                    System.Web.UI.WebControls.Label lblEmp = (System.Web.UI.WebControls.Label)item.FindControl("lbl_emp");

                    if (lblEmp != null)
                    {
                        string einValue = lblEmp.Text;
                        BindGrid(einValue);

                        // Do something with the EIN value for each row
                    }
                }
            }

        }
        void BindGrid(string empId)
        {
            DataTable dt = new DataTable();
            string connString = ConfigurationManager.ConnectionStrings["SQLDB_HDHRP"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string sql = @" SELECT      CONTRACT_CATEGORY                               AS EvaluationCategory
                                                , REVIEW_YEAR_START                             AS ReviewYearStart
                                                , REVIEW_YEAR_END                               AS ReviewYearEnd
                                                , REVIEW_DATE                                   AS ReviewDate
                                                , RATING                                        AS Rating
                                                , LOCATION_CODE                                 AS Location
                                                , SUPERINTENDENT_ID                             AS SuperintendentId
                                                , COMMENT_TEXT                                  AS Comment                                                                                                         
                                    FROM        [HDHRP].[IPDBA].[HD_TEACHER_EVAL_RESULT] 
                                    WHERE       employee_id =  @EmployeeID
                                    ORDER BY    ADDED_DATE, CHANGED_DATE";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", empId);

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
                appraisalRecordsGrid.DataSource = dt;
                appraisalRecordsGrid.DataBind();
            }
            catch (Exception ex)
            {
            }

          
        }


    }
}