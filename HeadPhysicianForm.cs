using System;

using System.Data;

using System.Windows.Forms;

using MySql.Data.MySqlClient;

namespace DBCurse

{

    public partial class HeadPhysicianForm : Form

    {

        // reference to the login form

        LoginForm loginForm;

        // reference to the connection

        MySqlConnection connection;

        // for data from SQL-requests

        DataSet dataSet = new DataSet();

        DataTable dataTable = new DataTable();

        public HeadPhysicianForm()

        {

            InitializeComponent();

        }

        public HeadPhysicianForm(LoginForm form, MySqlConnection conn)

        {

            // saving reference to thelogin form

            loginForm = form;

            loginForm.Hide();

            // saving reference to the connection

            connection = conn;

            InitializeComponent();

            // changing selection mode

            HeadPhysicianGrid.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

        }

        private void HeadPhysicianForm_Closed(object sender, EventArgs e)

        {

            // closing connection and showing back login form

            connection.Close();

            // erasing password

            loginForm.PasswordEntry.Text = "";

            loginForm.Show();

        }

        private void TableBox_SelectedIndexChanged(object sender, EventArgs e)

        {

            // making table visible

            HeadPhysicianGrid.Visible = true;

            // ...and everything else not

            AddDoctor.Visible = false;

            UpdateDoctor.Visible = false;

            DeleteDoctor.Visible = false;

            DeleteRandom.Visible = false;

            OrderLabel.Visible = false;

            OrderBox.Visible = false;

            // making according actions and SQL-request

            string request;

            // TODO: adequate requests

            switch (TableBox.Text)

            {

                case "Врачи":

                    request = "SELECT * FROM doctors";

                    AddDoctor.Visible = true;

                    UpdateDoctor.Visible = true;

                    DeleteDoctor.Visible = true;

                    DeleteRandom.Visible = true;

                    break;

                case "Пациенты":

                    request = "SELECT * FROM patients";

                    break;

                case "Текущие записи":

                    OrderLabel.Visible = true;

                    OrderBox.Visible = true;

                    request = "SELECT * FROM receptionsView ORDER BY `id`";

                    break;

                default:

                    request = "SELECT * FROM doctors";

                    break;

            }

            // requesting

            MySqlDataAdapter adapter = new MySqlDataAdapter(request, connection);

            // reseting data set from possible previous data

            dataSet.Reset();

            // filling data table with data from adapter

            adapter.Fill(dataSet);

            dataTable = dataSet.Tables[0];

            // filling grid

            HeadPhysicianGrid.DataSource = dataTable;

        }

        private void OrderBox_SelectedIndexChanged(object sender, EventArgs e)

        {

            string request = "SELECT * FROM receptionsView ORDER BY `" + OrderBox.SelectedItem.ToString() + "`;";

            // requesting

            MySqlDataAdapter adapter = new MySqlDataAdapter(request, connection);

            // reseting data set from possible previous data

            dataSet.Reset();

            // filling data table with data from adapter

            adapter.Fill(dataSet);

            dataTable = dataSet.Tables[0];

            // filling grid

            HeadPhysicianGrid.DataSource = dataTable;

        }

        private void AddDoctor_Click(object sender, EventArgs e)

        {

            DoctorForm doctorForm = new DoctorForm(this, connection)

            {

                Text = "Добавление врача"

            };

            doctorForm.Show();

        }

        private void UpdateDoctor_Click(object sender, EventArgs e)

        {

            // id - value of the firts cell of the first selected row

            string id = HeadPhysicianGrid.SelectedRows[0].Cells[0].Value.ToString();

            DoctorForm doctorForm = new DoctorForm(this, connection, id)

            {

                Text = "Обновление информации о враче"

            };

            doctorForm.Show();

        }

        private void DeleteDoctor_Click(object sender, EventArgs e)

        {

            // id - value of the firts cell of the first selected row

            string id = HeadPhysicianGrid.SelectedRows[0].Cells[0].Value.ToString();

            string sql = "CALL deleteDoctor('" + id + "');";

            MySqlScript script = new MySqlScript(connection, sql);

            script.Execute();

        }

        private void DeleteRandom_Click(object sender, EventArgs e)

        {

            DialogResult result = MessageBox.Show(

            "В нашей поликлинике не нужны неудачники!",

            "Увольняем неудачника!",

            MessageBoxButtons.OKCancel,

            MessageBoxIcon.Exclamation);

            if (result == DialogResult.Cancel)

            {

                MessageBox.Show(":(");

                return;

            }

            string sql = "CALL deleteRandom();";

            MySqlScript script = new MySqlScript(connection, sql);

            script.Execute();

        }

        private void statistics_Click(object sender, EventArgs e)

        {

            Statistics stat = new Statistics(this, connection);

            stat.Show();

        }

    }

}
