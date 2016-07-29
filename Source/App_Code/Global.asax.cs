using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Principal;
using System.Threading;
using System.Net;
using System.Diagnostics;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.Mail;
using System.Web.Caching;
using System.Web.SessionState;
using System.IO;
using System.Configuration;

namespace DoanhNghiep 
{
	/// <summary>
	/// Summary description for Global.
	/// </summary>
	public class Global : System.Web.HttpApplication
	{		
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		public Global()
		{
			InitializeComponent();
		}	
		
		protected void Application_Start(Object sender, EventArgs e)
		{
            Application["Online"] = 0;
		}		

		protected void Session_Start(Object sender, EventArgs e)
		{
            Application["Online"] = Convert.ToInt32(Application["Online"]) + 1;
            //MH.WebUtil.AddPageView();
            //if (Request.Headers["host"].ToLower().EndsWith("goyo-koun.com"))
            //{
            //    MH.Settings settings = new MH.Settings();
            //    settings.Language = "en";
            //}
		}

		protected void Application_BeginRequest(Object sender, EventArgs e)
		{
            
		}

		protected void Application_EndRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_AuthenticateRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_Error(Object sender, EventArgs e)
		{
		}

		protected void Session_End(Object sender, EventArgs e)
		{
            Application["Online"] = Convert.ToInt32(Application["Online"]) - 1;
            if (Convert.ToInt32(Application["Online"]) < 0)
                Application["Online"] = 0;

            Session.Abandon();

        }

		protected void Application_End(Object sender, EventArgs e)
		{

		}
			
		#region Web Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.components = new System.ComponentModel.Container();
		}
		#endregion
	}
}

