using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VTYS_form1
{
    public partial class Form2 : Form
    {
       
        //baglanti
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost;port=5432;Database=Lokanta takip sistemi;userID=postgres; password=12345");

      
        

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
