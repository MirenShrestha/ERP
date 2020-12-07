using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using ERP.Core.Models;

namespace ERP.Data.SqlHelpers
{
    public static class SqlHelper
    {
        private static int GetCommandTimeOut()
        {
            int seto = 0;
            try
            {
                int.TryParse(ConfigurationSettings.AppSettings["seto"].ToString(), out seto);
                if (seto == 0)
                    seto = 60;
            }
            catch (Exception ex)
            {
                seto = 60;
            }
            return seto;
        }




        public static int ExecuteQuery(string queryString, Dictionary<string, object> values)
        {
            int result = 0;
            using (SqlConnection connection = ConnectionManager.GetSqlConnection())
            using (SqlCommand command = connection.CreateCommand())
            {
                command.CommandText = queryString;
                command.CommandTimeout = GetCommandTimeOut();
                foreach (var item in values)
                {
                    if (queryString.Contains("@" + item.Key))
                    {
                        if (item.Value != null)
                            command.Parameters.AddWithValue("@" + item.Key, item.Value);
                    }
                }
                result = command.ExecuteNonQuery();

                connection.Close();
            }
            return result;
        }

        public static int ExecuteQuery(string queryString)
        {
            int result = 0;
            using (SqlConnection connection = ConnectionManager.GetSqlConnection())
            {
                SqlCommand command = new SqlCommand(queryString, connection);
                command.CommandTimeout = GetCommandTimeOut();
                result = command.ExecuteNonQuery();
                connection.Close();
                connection.Dispose();
            }
            return result;
        }



        public static int ExecuteNonQuery(string commandText, CommandType commandType, params SqlParameter[] commandParameters)
        {
            int result = 0;
            using (var connection = ConnectionManager.GetSqlConnection())
            {
                using (var command = new SqlCommand(commandText, connection))
                {
                    command.CommandType = commandType;
                    command.Parameters.AddRange(commandParameters);
                    command.CommandTimeout = GetCommandTimeOut();
                    result = command.ExecuteNonQuery();
                    connection.Close();
                    connection.Dispose();
                }
            }
            return result;
        }




        public static List<Tuple<string, string>> GetQueryColumns(string strQuery)
        {
            List<Tuple<string, string>> columns = new List<Tuple<string, string>>();
            DbConnection m_connection = ConnectionManager.GetSqlConnection();

            try
            {

                using (DbCommand cmd = m_connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQuery;
                    cmd.CommandTimeout = GetCommandTimeOut();
                    var reader = cmd.ExecuteReader();
                    for (int i = 0; i < reader.FieldCount; i++)
                        columns.Add(new Tuple<string, string>(reader.GetName(i), reader.GetDataTypeName(i)));
                }

                m_connection.Close();

                return columns;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable RunSelectQuery(string strQuery)
        {
            DataTable dtResult = new DataTable();

            dtResult = new DataTable();

            DbConnection m_connection = ConnectionManager.GetSqlConnection();

            try
            {


                using (var cmd = m_connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQuery;
                    cmd.CommandTimeout = GetCommandTimeOut();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    dataAdapter.SelectCommand = (SqlCommand)cmd;
                    dataAdapter.Fill(dtResult);

                }
                m_connection.Close();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return dtResult;
        }




        #region  
        //Fill the datatable with parameterized Stored Procedure
        public static DataTable ExecuteDataTable(String procedureName, SqlParameter[] parameters)
        {
            using (var connection = ConnectionManager.GetSqlConnection())
            {
                SqlCommand command = new SqlCommand(procedureName, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = GetCommandTimeOut();
                if (parameters != null)
                    command.Parameters.AddRange(parameters);

                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataTable dataTable = new DataTable();

                dataAdapter.SelectCommand = command;
                try
                {
                    dataAdapter.Fill(dataTable);
                }
                catch (Exception ex)
                {
                    throw;
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                        connection.Close();
                    connection.Dispose();
                    dataAdapter.Dispose();
                }
                return dataTable;
            }


        }

        #endregion



        #region "FILL DATASET" With Parameter less Stored Procedure

        public static DataSet ExecuteDataSet(String procedureName)
        {
            DataSet dataSet = new DataSet();
            using (var connection = ConnectionManager.GetSqlConnection())
            {
                SqlCommand command = new SqlCommand(procedureName, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = GetCommandTimeOut();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();

                dataAdapter.SelectCommand = command;
                try
                {
                    dataAdapter.Fill(dataSet);

                }
                catch (Exception ex)
                {
                    throw;
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                        connection.Close();
                    connection.Dispose();
                    dataAdapter.Dispose();
                }
            }
            return dataSet;

        }

        public static DataSet ExecuteDataSet(String procedureName, SqlParameter[] parameters)
        {
            using (var connection = ConnectionManager.GetSqlConnection())
            {
                DataSet dataSet = new DataSet();
                SqlCommand command = new SqlCommand(procedureName, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = GetCommandTimeOut();
                if (parameters != null)
                    command.Parameters.AddRange(parameters);

                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                dataAdapter.SelectCommand = command;
                try
                {
                    dataAdapter.Fill(dataSet);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                        connection.Close();
                    connection.Dispose();
                    dataAdapter.Dispose();
                }
                return dataSet;
            }
        }

        #endregion










        /*
                public static string UploadCsvFile(ref DataTable dt, string sql, string TblName)
                {
                    using (var connection = ConnectionManager.GetSqlConnection())
                    {
                        try
                        {
                            using (SqlBulkCopy sqlblkcpy = new SqlBulkCopy(connection))
                            {

                                sqlblkcpy.DestinationTableName = TblName;

                                foreach (DataColumn item in dt.Columns)
                                {
                                    sqlblkcpy.ColumnMappings.Add(new SqlBulkCopyColumnMapping(item.ColumnName, item.ColumnName));
                                }

                                if (dt.Rows.Count > 0)
                                    sqlblkcpy.WriteToServer(dt);
                            }
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                    }
                    return GetSingleResult(sql);
                }

                */
        private static SqlDataReader ExecuteDataReader(string sql)
        {
            using (var connection = ConnectionManager.GetSqlConnection())
            {
                SqlCommand command = new SqlCommand(sql, connection);
                command.CommandTimeout = GetCommandTimeOut();
                try
                {
                    SqlDataReader reader = command.ExecuteReader();
                    return reader;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public static DataTable ExecuteDataReaderAsDataTable(string sql)
        {
            DataTable dt = new DataTable();
            using (var connection = ConnectionManager.GetSqlConnection())
            {
                try
                {

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.CommandTimeout = GetCommandTimeOut();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                var colName = reader.GetName(i);
                                dt.Columns.Add(colName);
                            }

                            while (reader.Read())
                            {
                                var row = dt.NewRow();
                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    var colName = reader.GetName(i);
                                    row[colName] = reader[colName];
                                }

                                dt.Rows.Add(row);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return dt;
        }



        public static DataRow ExecuteDataRow(String procedureName, SqlParameter[] parameters)
        {
            using (var ds = ExecuteDataSet(procedureName, parameters))
            {
                if (ds == null || ds.Tables.Count == 0)
                    return null;

                if (ds.Tables[0].Rows.Count == 0)
                    return null;

                return ds.Tables[0].Rows[0];
            }
        }


        public static DbResult ParseDbResult(String procedureName, SqlParameter[] parameters)
        {
            return ParseDbResult(ExecuteDataRow(procedureName, parameters));
        }




        public static DbResult ParseDbResult(DataRow drow)
        {
            var res = new DbResult();
            if (drow != null)
            {
                res.ErrorCode = drow[0].ToString();
                res.Msg = drow[1].ToString();
                res.Id = drow[2].ToString();
            }

            if (drow.Table.Columns.Count > 3)
            {
                res.Extra = drow[3].ToString();
            }

            if (drow.Table.Columns.Count > 4)
            {
                res.Extra2 = drow[4].ToString();
            }
            return res;
        }

        public static DbResult ParseDbResult(DataTable dt)
        {
            var res = new DbResult();
            if (dt.Rows.Count > 0)
            {
                res.ErrorCode = dt.Rows[0][0].ToString();
                res.Msg = dt.Rows[0][1].ToString();
                res.Id = dt.Rows[0][2].ToString();
            }

            if (dt.Columns.Count > 3)
            {
                res.Extra = dt.Rows[0][3].ToString();
            }

            if (dt.Columns.Count > 4)
            {
                res.Extra2 = dt.Rows[0][4].ToString();
            }
            return res;
        }




        public static String GetSingleResult(String procedureName, SqlParameter[] parameters)
        {
            try
            {
                var ds = ExecuteDataSet(procedureName, parameters);
                if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                    return "";

                return ds.Tables[0].Rows[0][0].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataRow ExecuteDataRow(String procedureName)
        {
            using (var ds = ExecuteDataSet(procedureName))
            {
                if (ds == null || ds.Tables.Count == 0)
                    return null;

                if (ds.Tables[0].Rows.Count == 0)
                    return null;

                return ds.Tables[0].Rows[0];
            }
        }

        public static String GetSingleResult(String procedureName)
        {
            try
            {
                var ds = ExecuteDataSet(procedureName);
                if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                    return "";

                return ds.Tables[0].Rows[0][0].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
