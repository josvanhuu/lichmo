using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class x : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["user"] != null)
        {
            TextBox1.Text = Request.QueryString["user"].ToString();
            DetailsView1.DataBind();
        }
    }
	
	protected void Button1_Click2(object sender, EventArgs e)
	{
		DetailsView1.DataBind();
	}
}
