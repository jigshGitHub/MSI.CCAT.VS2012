﻿﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Data.Entity;

using MSI.CCAT.Data.Models;
using System.Configuration;

namespace MSI.CCAT.Data.Repositories
{

    public class Disposable : IDisposable
    {
        private bool isDisposed;

        ~Disposable()
        {
            Dispose(false);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        private void Dispose(bool disposing)
        {
            if (!isDisposed && disposing)
            {
                DisposeCore();
            }

            isDisposed = true;
        }

        protected virtual void DisposeCore()
        {
        }
    }

    public interface IDatabaseFactory : IDisposable
    {
        DbContext Get();
        int SaveChanges();
    }

    public class DBFactory : IDatabaseFactory
    {
        private DbContext dbContext;
        private string _dbEntities;
        public DBFactory(string dbEntities)
        {
            _dbEntities = dbEntities;
            //mCN = ConfigurationManager.ConnectionStrings[dbEntities] .ToString(); ;
            System.Data.EntityClient.EntityConnection con = new System.Data.EntityClient.EntityConnection(ConfigurationManager.ConnectionStrings[dbEntities].ToString());
            mCN = con.StoreConnection.ConnectionString;
        }

        private string mCN;
        //public DBFactory()
        //{
        //    //Allows us to use a CN String Other then the Default
        //    mCN = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString(); ;
        //}

        protected SqlConnection GetConnection()
        {
            SqlConnection ret_conn = null;

            if (string.IsNullOrEmpty(mCN))
            {
                mCN = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                ret_conn = new SqlConnection(mCN);
                //Use Default
            }
            else
            {
                ret_conn = new SqlConnection(mCN);
            }
            ret_conn.Open();
            return ret_conn;
        }

        protected void CloseConnection(SqlConnection conn)
        {
            conn.Close();
            conn = null;
        }

        public SqlDataReader ExecuteReader(string strSP, params SqlParameter[] commandParameters)
        {
            SqlConnection cn = GetConnection();
            SqlDataReader rdr = null;

            SqlCommand cmd = new SqlCommand(strSP, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;
            SqlParameter p = null;
            foreach (SqlParameter p_loopVariable in commandParameters)
            {
                p = p_loopVariable;
                p = cmd.Parameters.Add(p);
                p.Direction = ParameterDirection.Input;
            }
            rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            cmd.Dispose();
            return rdr;
        }

        public SqlDataReader ExecuteReader(string strSP)
        {

            SqlConnection cn = GetConnection();
            SqlDataReader rdr = null;

            SqlCommand cmd = new SqlCommand(strSP, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;
            rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            cmd.Dispose();
            return rdr;
        }

        public SqlDataReader ExecuteReaderFromQuery(string strQeury)
        {

            SqlConnection cn = GetConnection();
            SqlDataReader rdr = null;

            SqlCommand cmd = new SqlCommand(strQeury, cn);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 0;
            rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            cmd.Dispose();
            return rdr;
        }

        public object ExecuteScalar(string strSP)
        {

            SqlConnection cn = GetConnection();
            object val = 0;

            SqlCommand cmd = new SqlCommand(strSP, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                val = cmd.ExecuteScalar();
                cmd.Dispose();

            }
            finally
            {
                CloseConnection(cn);
            }

            return val;
        }
        public object ExecuteScalar(string strSP, params SqlParameter[] commandParameters)
        {

            SqlConnection cn = GetConnection();
            object val = 0;

            SqlCommand cmd = new SqlCommand(strSP, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter p = null;
            foreach (SqlParameter p_loopVariable in commandParameters)
            {
                p = p_loopVariable;
                p = cmd.Parameters.Add(p);
                p.Direction = ParameterDirection.Input;
            }
            try
            {
                val = cmd.ExecuteScalar();
                cmd.Dispose();

            }
            finally
            {
                CloseConnection(cn);
            }

            return val;
        }

        public SqlDataReader RunPassSQL(string strSQL)
        {

            SqlConnection cn = GetConnection();
            SqlDataReader rdr = null;

            SqlCommand cmd = new SqlCommand(strSQL, cn);
            rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            cmd.Dispose();

            return rdr;

        }


        public void RunActionQuery(string strSQL)
        {
            SqlConnection cn = GetConnection();
            SqlCommand cmd = new SqlCommand(strSQL, cn);

            try
            {
                cmd.ExecuteNonQuery();

                cmd.Dispose();

            }
            finally
            {
                CloseConnection(cn);
            }

        }

        public long ExecuteNonQuery(string strSP)
        {

            SqlConnection cn = GetConnection();
            long rowCount = 0;
            SqlCommand cmd = new SqlCommand(strSP, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;

            try
            {
                rowCount = cmd.ExecuteNonQuery();

                cmd.Dispose();

            }
            finally
            {
                CloseConnection(cn);
            }
            return rowCount;
        }

        public long ExecuteNonQuery(string strSP, params SqlParameter[] commandParameters)
        {

            SqlConnection cn = GetConnection();
            long rowCount = 0;
            SqlCommand cmd = new SqlCommand(strSP, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;
            SqlParameter p = null;
            foreach (SqlParameter p_loopVariable in commandParameters)
            {
                p = p_loopVariable;
                p = cmd.Parameters.Add(p);
                p.Direction = ParameterDirection.Input;
            }
            try
            {
                rowCount = cmd.ExecuteNonQuery();

                cmd.Dispose();

            }
            finally
            {
                CloseConnection(cn);

            }
            return rowCount;
        }

        public int RunSPReturnInteger(string strSP, params SqlParameter[] commandParameters)
        {

            SqlConnection cn = GetConnection();
            int retVal = 0;


            try
            {
                SqlCommand cmd = new SqlCommand(strSP, cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter p = null;
                foreach (SqlParameter p_loopVariable in commandParameters)
                {
                    p = p_loopVariable;
                    p = cmd.Parameters.Add(p);
                    p.Direction = ParameterDirection.Input;
                }

                p = cmd.Parameters.Add(new SqlParameter("@RetVal", SqlDbType.Int));
                p.Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                retVal = int.Parse(cmd.Parameters["@RetVal"].Value.ToString());
                cmd.Dispose();


            }
            finally
            {
                CloseConnection(cn);
            }

            return retVal;

        }

        public DataSet ExecuteDataset(string strSP, string DataTableName)
        {

            SqlConnection cn = GetConnection();

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(strSP, cn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.CommandTimeout = 0;

            da.Fill(ds, DataTableName);

            CloseConnection(cn);

            da.Dispose();

            return ds;

        }

        public DataSet ExecuteDataset(string strSP, string DataTableName, params SqlParameter[] commandParameters)
        {

            SqlConnection cn = GetConnection();

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(strSP, cn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.CommandTimeout = 0;
            SqlParameter p = null;


            foreach (SqlParameter p_loopVariable in commandParameters)
            {
                p = p_loopVariable;
                da.SelectCommand.Parameters.Add(p);
                p.Direction = ParameterDirection.Input;
            }

            da.Fill(ds, DataTableName);

            CloseConnection(cn);

            da.Dispose();

            return ds;

        }

        public DataSet ExecuteDataset(string strQuery)
        {

            SqlConnection cn = GetConnection();

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(strQuery, cn);
            da.SelectCommand.CommandType = CommandType.Text;
            da.SelectCommand.CommandTimeout = 0;

            da.Fill(ds);

            CloseConnection(cn);

            da.Dispose();

            return ds;

        }

        public long ExecuteNonQuery(string strSP, List<SqlParameter> commandParameters)
        {

            SqlConnection cn = GetConnection();
            long rowCount = 0;
            SqlCommand cmd = new SqlCommand(strSP, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;
            SqlParameter p = null;

            try
            {
                foreach (SqlParameter p_loopVariable in commandParameters)
                {
                    p = p_loopVariable;
                    p = cmd.Parameters.Add(p);
                    p.Direction = ParameterDirection.Input;
                }
                rowCount = cmd.ExecuteNonQuery();

                cmd.Dispose();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                CloseConnection(cn);

            }
            return rowCount;
        }

        public System.Data.Entity.DbContext Get()
        {
            if (_dbEntities == "CCATDBEntities")
            {
                dbContext = (CCATDBEntities)UnitOfWorkStore.GetInstance("CCATDBEntities");
                if (dbContext == null)
                {
                    dbContext = new CCATDBEntities();
                    dbContext.Configuration.ProxyCreationEnabled = false;
                    UnitOfWorkStore.SetInstance("CCATDBEntities", dbContext);
                }
                return dbContext;
            }
            else if (_dbEntities == "CascadeDBEntities")
            {
                dbContext = (CascadeDBEntities)UnitOfWorkStore.GetInstance("CascadeDBEntities");
                if (dbContext == null)
                {
                    dbContext = new CascadeDBEntities();
                    dbContext.Configuration.ProxyCreationEnabled = false;
                    UnitOfWorkStore.SetInstance("CascadeDBEntities", dbContext);
                }
                return dbContext;
            }
            return null;
        }

        //public System.Data.Entity.DbContext Get()
        //{
        //    dbContext = (CCATDBEntities)UnitOfWorkStore.GetInstance("DBEntities");
        //    if (dbContext == null)
        //    {
        //        dbContext = new CCATDBEntities();
        //        dbContext.Configuration.ProxyCreationEnabled = false;
        //        UnitOfWorkStore.SetInstance("DBEntities", dbContext);
        //    }
        //    return dbContext;
        //}

        public void Dispose()
        {
            throw new System.NotImplementedException();
        }

        public int SaveChanges()
        {
            //this.ApplyStateChanges();
            return Get().SaveChanges();
        }
    }

    public static class UnitOfWorkStore
    {
        public static object GetInstance(string key)
        {
            if (System.Web.HttpContext.Current != null)
                return System.Web.HttpContext.Current.Items[key];
            throw new Exception("Not found");
        }

        public static void SetInstance(string key, object instance)
        {
            if (System.Web.HttpContext.Current != null)
                System.Web.HttpContext.Current.Items[key] = instance;
            else
                throw new Exception("Not found");
        }
    }

}
