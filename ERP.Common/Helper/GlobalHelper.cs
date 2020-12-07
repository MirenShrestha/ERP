using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace ERP.Common.Helper
{
  public static  class GlobalHelper
    {
        public static string RenderRazorViewToString(Controller controller, string viewName, object model = null)
        {
            controller.ViewData.Model = model;
            using (var sw = new StringWriter())
            {
                ViewEngineResult viewResult;
                viewResult = ViewEngines.Engines.FindPartialView(controller.ControllerContext, viewName);
                var viewContext = new ViewContext(controller.ControllerContext, viewResult.View, controller.ViewData, controller.TempData, sw);
                viewResult.View.Render(viewContext, sw);
                viewResult.ViewEngine.ReleaseView(controller.ControllerContext, viewResult.View);
                return sw.GetStringBuilder().ToString();
            }
        }


        public static string GetHash(string password)
        {
            using (SHA1Managed sha1 = new SHA1Managed())
            {
                var hash = sha1.ComputeHash(Encoding.UTF8.GetBytes(password));
                var sb = new StringBuilder(hash.Length * 2);

                foreach (byte b in hash)
                {
                    sb.Append(b.ToString("X2"));
                }

                return sb.ToString();
            }
        }
        public static string RemoveDecimal(double amt)
        {
            return Math.Floor(amt).ToString();
        }

        public static String FilterStringForXml(string strVal)
        {
            var str = FilterQuote(strVal);

            if (str.ToLower() == "null")
                str = "";
            return str;
        }

        public static String FilterStringNative(string strVal)
        {
            var str = FilterQuoteNative(strVal);

            if (str.ToLower() != "null")
                str = "'" + str + "'";

            return str;
        }

        public static String FilterString(string strVal)
        {
            var str = FilterQuote(strVal);

            if (str.ToLower() != "null")
                str = "'" + str + "'";

            return str;
        }

        private static string Encode(string strVal)
        {

            var sb = new StringBuilder(HttpUtility.HtmlEncode(HttpUtility.JavaScriptStringEncode(strVal)));
            sb.Replace("&lt;b&gt;", "<b>");
            sb.Replace("&lt;/b&gt;", "");
            sb.Replace("&lt;i&gt;", "<i>");
            sb.Replace("&lt;/i&gt;", "");
            return sb.ToString();

        }

        public static String FilterQuoteNative(string strVal)
        {
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "";
            }
            var str = Encode(strVal.Trim());


            if (!string.IsNullOrEmpty(str))
            {
                str = str.Replace(";", "");
                str = str.Replace("--", "");
                str = str.Replace("'", "");

                str = str.Replace("/*", "");
                str = str.Replace("*/", "");

                str = str.Replace(" select ", "");
                str = str.Replace(" insert ", "");
                str = str.Replace(" update ", "");
                str = str.Replace(" delete ", "");

                str = str.Replace(" drop ", "");
                str = str.Replace(" truncate ", "");
                str = str.Replace(" create ", "");

                str = str.Replace(" begin ", "");
                str = str.Replace(" end ", "");
                str = str.Replace(" char(", "");

                str = str.Replace(" exec ", "");
                str = str.Replace(" xp_cmd ", "");


                str = str.Replace("<script", "");

            }
            else
            {
                str = "null";
            }
            return str;
        }

        public static String FilterQuote(string strVal)
        {
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "";
            }

            var str = strVal.Trim();

            if (!string.IsNullOrEmpty(str))
            {
                str = str.Replace(";", "");
                //str = str.Replace(",", "");
                str = str.Replace("--", "");
                str = str.Replace("'", "");

                str = str.Replace("/*", "");
                str = str.Replace("*/", "");

                str = str.Replace(" select ", "");
                str = str.Replace(" insert ", "");
                str = str.Replace(" update ", "");
                str = str.Replace(" delete ", "");

                str = str.Replace(" drop ", "");
                str = str.Replace(" truncate ", "");
                str = str.Replace(" create ", "");

                str = str.Replace(" begin ", "");
                str = str.Replace(" end ", "");
                str = str.Replace(" char(", "");

                str = str.Replace(" exec ", "");
                str = str.Replace(" xp_cmd ", "");
                str = str.Replace("svg/onload", "");


                str = str.Replace("<script", "");

            }
            else
            {
                str = "null";
            }
            return str;
        }

        public static string SingleQuoteToDoubleQuote(string strVal)
        {
            strVal = strVal.Replace("\"", "");
            return strVal.Replace("'", "\"");
        }

        public static string ReadFileContent(string fileName)
        {
            return ReadFileContent(fileName, false);
        }

        public static string ReadFileContent(string fileName, bool ignoreFirstLine)
        {
            var contents = "";
            using (var streamReader = new StreamReader(fileName))
            {
                if (streamReader.EndOfStream)
                    return "";
                if (ignoreFirstLine)
                {
                    streamReader.ReadLine();
                    if (streamReader.EndOfStream)
                        return "";
                }
                contents = streamReader.ReadToEnd();
            }

            return contents;
        }

        public static string ParseDate(string data)
        {
            data = FilterString(data);
            if (data.ToUpper() == "NULL")
                return data;
            data = data.Replace("'", "");
            var dateParts = data.Split('/');
            if (dateParts.Length < 3)
                return "NULL";
            var m = dateParts[0];
            var d = dateParts[1];
            var y = dateParts[2];

            return "'" + y + "-" + (m.Length == 1 ? "0" + m : m) + "-" + (d.Length == 1 ? "0" + d : d) + "'";

        }

        public static string DataTableToText(ref DataTable dt, string delemeter, Boolean includeColHeader)
        {
            var sb = new StringBuilder();
            var del = "";
            var rowcnt = 0;
            if (includeColHeader)
            {
                foreach (DataColumn col in dt.Columns)
                {
                    sb.Append(del);
                    sb.Append(col.ColumnName);
                    del = delemeter;
                }
                rowcnt++;
            }

            foreach (DataRow row in dt.Rows)
            {
                if (rowcnt > 0)
                {
                    sb.AppendLine();
                }
                del = "";
                foreach (DataColumn col in dt.Columns)
                {
                    sb.Append(del);
                    sb.Append((row[col.ColumnName].ToString().Replace(",", "")));
                    del = delemeter;
                }
                rowcnt++;
            }
            return sb.ToString();
        }

        public static string DataTableToText(ref DataTable dt, string delemeter)
        {
            return DataTableToText(ref dt, delemeter, true);
        }
        public static string GetSQLDate(object data)
        {
            try
            {
                return Convert.ToDateTime(data.ToString()).ToString("yyyy-MM-dd HH:mm:ss");
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public static string ToShortDate(string datetime)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(datetime))
                    return "";

                DateTime dt;
                DateTime.TryParse(datetime, out dt);

                return dt.ToShortDateString();
            }
            catch
            {
                return "";
            }
        }

        public static string GetToday()
        {
            return DateTime.Today.ToShortDateString();
        }
        public static string DateFormatter(object date)
        {
            var shortDateLocalFormat = "";
            if (date != null)
            {
                shortDateLocalFormat = ((DateTime)date).ToString("MM/dd/yyyy");
            }

            return shortDateLocalFormat;
        }

        public static DataTable ListToDataTable<T>(IList<T> list)
        {
            DataTable table = CreateTable<T>();
            Type entityType = typeof(T);
            PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(entityType);

            foreach (T item in list)
            {
                DataRow row = table.NewRow();

                foreach (PropertyDescriptor prop in properties)
                {
                    row[prop.Name] = prop.GetValue(item);
                }

                table.Rows.Add(row);
            }

            return table;
        }

        public static DataTable CreateTable<T>()
        {
            Type entityType = typeof(T);
            DataTable table = new DataTable(entityType.Name);
            PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(entityType);

            foreach (PropertyDescriptor prop in properties)
            {
                table.Columns.Add(prop.Name, prop.PropertyType);
            }

            return table;
        }

        public static List<T> BindDataTableToList<T>(DataTable dt)
        {
            List<string> columns = new List<string>();
            foreach (DataColumn dc in dt.Columns)
            {
                columns.Add(dc.ColumnName);
            }
            //dt.Rows[0].Delete();
            var fields = typeof(T).GetFields();
            var properties = typeof(T).GetProperties();

            List<T> lst = new List<T>();

            foreach (DataRow dr in dt.Rows)
            {
                var ob = Activator.CreateInstance<T>();

                foreach (var fieldInfo in fields)
                {
                    if (columns.Contains(fieldInfo.Name))
                    {
                        fieldInfo.SetValue(ob, dr[fieldInfo.Name]);
                    }
                }

                foreach (var propertyInfo in properties)
                {

                    if (columns.Contains(propertyInfo.Name))
                    {
                        if (propertyInfo.PropertyType == typeof(int))
                        {
                            int i = ExtractInt(dr[propertyInfo.Name]);
                            propertyInfo.SetValue(ob, i);
                        }
                        else if (propertyInfo.PropertyType == typeof(decimal))
                        {
                            decimal i = ExtractDecimal(dr[propertyInfo.Name]);
                            propertyInfo.SetValue(ob, i);
                        }
                        else if (propertyInfo.PropertyType == typeof(string))
                        {
                            string i = ExtractString(dr[propertyInfo.Name]);
                            propertyInfo.SetValue(ob, i);
                        }
                        else if (propertyInfo.PropertyType == typeof(bool))
                        {
                            bool i = ExtractBool(dr[propertyInfo.Name]);
                            propertyInfo.SetValue(ob, i);
                        }
                        //try
                        //{
                        //    propertyInfo.SetValue(ob, dr[propertyInfo.Name]);
                        //}
                        //catch
                        //{
                        //    propertyInfo.SetValue(ob, " ");
                        //}
                    }


                }

                lst.Add(ob);
            }

            return lst;
        }
        public static int ExtractInt(object data)
        {
            if (data.GetType() == typeof(int))
            {
                return (int)data;
            }
            else
            {
                int i = 0;
                int.TryParse(data + "", out i);
                return i;
            }
        }
        public static decimal ExtractDecimal(object data)
        {
            if (data.GetType() == typeof(decimal))
            {
                return (decimal)data;
            }
            else
            {
                decimal i = 0;
                decimal.TryParse(data + "", out i);
                return i;
            }
        }
        public static string ExtractString(object data)
        {
            if (data.GetType() == typeof(string))
            {
                return (string)data;
            }
            else
            {
                string i = " ";
                return i;
            }
        }
        public static bool ExtractBool(object data)
        {
            if(data.GetType() == typeof(bool))
            {
                return (bool)data;
            }
            else
            {
                bool i = false;
                return i;
            }
        }
        /// <summary>
        ///  Function to convert CSV Excel File to Datatable
        /// </summary>
        /// <param name="strFilePath"></param>
        /// <returns></returns>
        public static DataTable ConvertCSVtoDataTable(string strFilePath)
        {
            DataTable dt = new DataTable();
            using (StreamReader sr = new StreamReader(strFilePath))
            {
                string[] headers = sr.ReadLine().Split(',');
                foreach (string header in headers)
                {
                    dt.Columns.Add(header);
                }
                while (!sr.EndOfStream)
                {
                    string[] rows = sr.ReadLine().Split(',');
                    if (rows.Length > 1)
                    {
                        DataRow dr = dt.NewRow();
                        for (int i = 0; i < headers.Length; i++)
                        {
                            dr[i] = rows[i].Trim();
                        }
                        dt.Rows.Add(dr);
                    }
                }
            }
            return dt;
        }
        /// <summary>
        /// Function to convert xls and xlsx file to Datatable
        /// </summary>
        /// <param name="filePath"></param>
        /// <param name="fileExtension"></param>
        /// <returns></returns>
        public static DataTable ConvertXSLXtoDataTable(string filePath, string fileExtension)
        {
            string excelConnectionString = string.Empty;
             if (fileExtension.Trim() == ".xls")
            {
                excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (excelConnectionString.Trim() == ".xlsx")
            {
                excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            OleDbConnection oledbConn = new OleDbConnection(excelConnectionString);
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            try
            {
                oledbConn.Open();
                using (DataTable Sheets = oledbConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null))
                {
                    for (int i = 0; i < Sheets.Rows.Count; i++)
                    {
                        string worksheets = Sheets.Rows[i]["TABLE_NAME"].ToString();
                        OleDbCommand cmd = new OleDbCommand(String.Format("SELECT * FROM [{0}]", worksheets), oledbConn);
                        OleDbDataAdapter oleda = new OleDbDataAdapter();
                        oleda.SelectCommand = cmd;
                        oleda.Fill(ds);
                    }
                    dt = ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oledbConn.Close();
            }
            return dt;
        }

    }
}
