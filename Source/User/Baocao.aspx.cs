using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_Baocao : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["workcontext"]!=null)
        {
            WorkContext context = (WorkContext)Session["workcontext"];
            ltSience.Text += "<script type='text/javascript'/>";
            ltSience.Text += "var scienceId = " + context.SienceId + ";";
            ltSience.Text += "</script>";
        }
    }
}