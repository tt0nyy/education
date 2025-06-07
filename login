using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DemoApp
{
    public partial class LoginForm : Form
    {
        
        public LoginForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string login = txtUserName.Text;
            string password = txtPassword.Text;

            using (SqlConnection conn = new SqlConnection(@"Data Source=DESKTOP-MBJQ0QD;Initial Catalog=Демо;Integrated Security=True;Connect Timeout=30;Encrypt=True;TrustServerCertificate=True"))
            {
                conn.Open();
                string query = "SELECT UserId, Role FROM Users WHERE login = @login AND password = @password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", login);
                cmd.Parameters.AddWithValue("@password", password);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    int userId = reader.GetInt32(0);
                    string role = reader.GetString(1);

                    this.Hide();
                    if (role == "Student")
                        new StudentForm(userId).Show();
                    else if (role == "Teacher")
                        new TeacherForm(userId).Show();
                    else
                        MessageBox.Show("Неизвестная роль.");
                }
                else
                {
                    MessageBox.Show("Неверный логин или пароль.");
                }
            }
        }
    }
}
