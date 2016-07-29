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
using MHWeb.Entities;
using MHWeb.Services;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                // This is an unauthorized, authenticated request...
                Response.Redirect("~/admin/Warning/UnauthorizedAccess.aspx");
            TextBox txtUser = Login1.FindControl("UserName") as TextBox;
            //TextBox txtPassword = Login1.FindControl("Password") as TextBox;
            if (Request.Cookies["myCookie"] != null)
            {
                HttpCookie cookie = Request.Cookies.Get("myCookie");
                Login1.UserName = cookie.Values["username"].ToString();
                liscript.Text = "document.getElementById('Login1_Password').value = '" + cookie.Values["password"].ToString() + "';";
                CheckBox rm = (CheckBox)Login1.FindControl("RememberMe");
                rm.Checked = true;
            }
            this.SetFocus(txtUser);
        }
        if (IsPostBack)
        {
            TextBox txtUser = Login1.FindControl("UserName") as TextBox;
            TextBox txtPassword = Login1.FindControl("Password") as TextBox;
            CheckBox rm = (CheckBox)Login1.FindControl("RememberMe");
            if (rm.Checked)
            {
                HttpCookie myCookie = new HttpCookie("myCookie");
                Response.Cookies.Remove("myCookie");
                Response.Cookies.Add(myCookie);
                myCookie.Values.Add("username", txtUser.Text);
                myCookie.Values.Add("password", txtPassword.Text);
                DateTime dtExpiry = DateTime.Now.AddDays(365); //you can add years and months too here
                Response.Cookies["myCookie"].Expires = dtExpiry;
            }
            else
            {
                HttpCookie myCookie = new HttpCookie("myCookie");
                Response.Cookies.Remove("myCookie");
                Response.Cookies.Add(myCookie);
                myCookie.Values.Add("username", txtUser.Text);
                myCookie.Values.Add("password", txtPassword.Text);
                DateTime dtExpiry = DateTime.Now.AddSeconds(1); //you can add years and months too here
                Response.Cookies["myCookie"].Expires = dtExpiry;
            }
            /*Get profile of user*/
            ProfileCommon _ProfileCommon = Profile.GetProfile(txtUser.Text);
            string[] userRole = Roles.GetRolesForUser(_ProfileCommon.UserName);
            WorkContext context = new WorkContext(_ProfileCommon.UserName, 0, null); ;
            int scienceId = 0;
            int.TryParse(_ProfileCommon.Science, out scienceId);
            if(scienceId >0)
            {
                TList<MHWeb.Entities.Science> lst = (new ScienceService()).GetAll();
                foreach (MHWeb.Entities.Science science in lst)
                {
                    if (science.Id == scienceId)
                    {
                        context.SienceId = scienceId;
                        break;
                    }
                }
                if (userRole.Length > 0)
                    context.UserRoles = userRole;

                Session["workcontext"] = context;
            }
        }
    }    
}
