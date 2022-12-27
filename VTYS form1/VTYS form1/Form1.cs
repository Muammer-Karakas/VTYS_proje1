using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace VTYS_form1
{
    public partial class Form1 : Form
    {

        NpgsqlCommand komut1;
        NpgsqlDataAdapter da1;
        public Form1()
        {
            
            InitializeComponent();
        }

        NpgsqlConnection connection = new NpgsqlConnection("server=localHost;port=5432;Database=Lokanta takip sistemi;userID=postgres; password=12345");


        private void Form1_Load(object sender, EventArgs e)
        {
            string sorgu = "SELECT * FROM \"public\".\"yemek\"  ";
            DataTable dt1 = new DataTable();
            NpgsqlDataAdapter da1 = new NpgsqlDataAdapter(sorgu, connection);
            da1.Fill(dt1);
            dataGridView1.DataSource = dt1;
      

        }

        private void btn_ekle_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand komut1 = new NpgsqlCommand("insert into yemek (yemek_id,lokanta_id,personel_id,yemek_adi,yemek_fiyat,yemek_stok,yemek_kcal) values(@p1,@p2,@p3,@p4,@p5,@p6,@p7)", connection);
            komut1.Parameters.AddWithValue("@p1", int.Parse(txt_id.Text));//int
            komut1.Parameters.AddWithValue("@p2", int.Parse(txt_lokanta_id.Text));
            komut1.Parameters.AddWithValue("@p3", int.Parse(txt_personel_id.Text));
            komut1.Parameters.AddWithValue("@p4", txt_yemekad.Text);
            komut1.Parameters.AddWithValue("@p5", int.Parse(txt_yemek_fiyat.Text));
            komut1.Parameters.AddWithValue("@p6", int.Parse(txt_yemekstok.Text));
            komut1.Parameters.AddWithValue("@p7", int.Parse(txt_yemekkalori.Text));
            komut1.ExecuteNonQuery();//degisikleri veri tabanina yansit
            connection.Close();
            MessageBox.Show("Ekleme Başarılı");
            //listeleme
            string sorgu = "SELECT * FROM yemek  ";
            NpgsqlDataAdapter da1 = new NpgsqlDataAdapter(sorgu, connection);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridView1.DataSource = dt1;

        }

        private void btn_listele_Click(object sender, EventArgs e)
        {
            //listeleme
            string sorgu = "SELECT * FROM yemek order by yemek_id ";
            NpgsqlDataAdapter da1 = new NpgsqlDataAdapter(sorgu, connection);

            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridView1.DataSource = dt1;

         
        }

        private void btn_sil_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("DELETE From yemek where yemek_id=@p1", connection);
            komut2.Parameters.AddWithValue("@p1", int.Parse(txt_id.Text));
            komut2.ExecuteNonQuery();
            connection.Close();
            MessageBox.Show("Silme Başarılı");
            //listeleme
            string sorgu = "SELECT * FROM yemek  ";
            DataTable dt1 = new DataTable();
            NpgsqlDataAdapter da1 = new NpgsqlDataAdapter(sorgu, connection);  
            da1.Fill(dt1);
            dataGridView1.DataSource = dt1;
      

        }

        private void btn_guncelle_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand komut3 = new NpgsqlCommand("UPDATE yemek SET lokanta_id=@p2,personel_id=@p3,yemek_adi=@p4,yemek_fiyat=@p5,yemek_stok=@p6,yemek_kcal=@p7 WHERE yemek_id=@p1", connection);
            komut3.Parameters.AddWithValue("@p1", int.Parse(txt_id.Text));//int
            komut3.Parameters.AddWithValue("@p2", int.Parse(txt_lokanta_id.Text));
            komut3.Parameters.AddWithValue("@p3", int.Parse(txt_personel_id.Text));
            komut3.Parameters.AddWithValue("@p4", txt_yemekad.Text);
            komut3.Parameters.AddWithValue("@p5", int.Parse(txt_yemek_fiyat.Text));
            komut3.Parameters.AddWithValue("@p6", int.Parse(txt_yemekstok.Text));
            komut3.Parameters.AddWithValue("@p7", int.Parse(txt_yemekkalori.Text));
            komut3.ExecuteNonQuery();//degisikleri veri tabanina yansit
            connection.Close();
            MessageBox.Show("Güncelleme Başarılı");
            //listeleme
            string sorgu = "SELECT * FROM yemek  ";
            NpgsqlDataAdapter da1 = new NpgsqlDataAdapter(sorgu, connection);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridView1.DataSource = dt1;
           

        }

        private void btn_form2_Click(object sender, EventArgs e)
        {
            Form2 ff = new Form2();
            ff.Show();
        }

        private void txt_lokanta_id_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_personel_id_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_id_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_yemek_fiyat_TextChanged(object sender, EventArgs e)
        {

        }

        private void btn_silinenyemek_Click(object sender, EventArgs e)
        {
            Form3 ff = new Form3();
            ff.Show();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

                txt_id.Text = row.Cells["yemek_id"].Value.ToString();
                txt_lokanta_id.Text = row.Cells["lokanta_id"].Value.ToString();
                txt_personel_id.Text = row.Cells["personel_id"].Value.ToString();
                txt_yemekad.Text = row.Cells["yemek_adi"].Value.ToString();
                txt_yemek_fiyat.Text = row.Cells["yemek_fiyat"].Value.ToString();
                txt_yemekstok.Text = row.Cells["yemek_stok"].Value.ToString();
                txt_yemekkalori.Text = row.Cells["yemek_kcal"].Value.ToString();
            }


        }

        
    }
}
