using System.Configuration;
using System.Data.SqlClient;
namespace ERP.Data.SqlHelpers
{
    public class ConnectionManager
    {
        public static SqlConnection GetSqlConnection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ERPConnection"].ConnectionString;
            var connection = new SqlConnection(connectionString);
            connection.Open();
            return connection;
        }
    }
}
