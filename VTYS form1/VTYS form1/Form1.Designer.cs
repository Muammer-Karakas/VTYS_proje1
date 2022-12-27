
namespace VTYS_form1
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.btn_ekle = new System.Windows.Forms.Button();
            this.btn_listele = new System.Windows.Forms.Button();
            this.btn_sil = new System.Windows.Forms.Button();
            this.btn_guncelle = new System.Windows.Forms.Button();
            this.btn_form2 = new System.Windows.Forms.Button();
            this.txt_lokanta_id = new System.Windows.Forms.TextBox();
            this.txt_yemekad = new System.Windows.Forms.TextBox();
            this.txt_personel_id = new System.Windows.Forms.TextBox();
            this.txt_id = new System.Windows.Forms.TextBox();
            this.txt_yemek_fiyat = new System.Windows.Forms.TextBox();
            this.txt_yemekstok = new System.Windows.Forms.TextBox();
            this.txt_yemekkalori = new System.Windows.Forms.TextBox();
            this.btn_silinenyemek = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.lokanta_takip_sistemiDataSet1 = new VTYS_form1.Lokanta_takip_sistemiDataSet1();
            this.lokantatakipsistemiDataSet1BindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lokanta_takip_sistemiDataSet1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lokantatakipsistemiDataSet1BindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.DataSource = this.lokantatakipsistemiDataSet1BindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(29, 43);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersWidth = 5;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(739, 260);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // btn_ekle
            // 
            this.btn_ekle.Location = new System.Drawing.Point(235, 341);
            this.btn_ekle.Name = "btn_ekle";
            this.btn_ekle.Size = new System.Drawing.Size(90, 32);
            this.btn_ekle.TabIndex = 2;
            this.btn_ekle.Text = "ekle";
            this.btn_ekle.UseVisualStyleBackColor = true;
            this.btn_ekle.Click += new System.EventHandler(this.btn_ekle_Click);
            // 
            // btn_listele
            // 
            this.btn_listele.Location = new System.Drawing.Point(235, 388);
            this.btn_listele.Name = "btn_listele";
            this.btn_listele.Size = new System.Drawing.Size(90, 32);
            this.btn_listele.TabIndex = 1;
            this.btn_listele.Text = "listele";
            this.btn_listele.UseVisualStyleBackColor = true;
            this.btn_listele.Click += new System.EventHandler(this.btn_listele_Click);
            // 
            // btn_sil
            // 
            this.btn_sil.Location = new System.Drawing.Point(235, 436);
            this.btn_sil.Name = "btn_sil";
            this.btn_sil.Size = new System.Drawing.Size(90, 32);
            this.btn_sil.TabIndex = 3;
            this.btn_sil.Text = "sil";
            this.btn_sil.UseVisualStyleBackColor = true;
            this.btn_sil.Click += new System.EventHandler(this.btn_sil_Click);
            // 
            // btn_guncelle
            // 
            this.btn_guncelle.Location = new System.Drawing.Point(235, 477);
            this.btn_guncelle.Name = "btn_guncelle";
            this.btn_guncelle.Size = new System.Drawing.Size(90, 32);
            this.btn_guncelle.TabIndex = 4;
            this.btn_guncelle.Text = "güncelle";
            this.btn_guncelle.UseVisualStyleBackColor = true;
            this.btn_guncelle.Click += new System.EventHandler(this.btn_guncelle_Click);
            // 
            // btn_form2
            // 
            this.btn_form2.Location = new System.Drawing.Point(476, 324);
            this.btn_form2.Name = "btn_form2";
            this.btn_form2.Size = new System.Drawing.Size(61, 57);
            this.btn_form2.TabIndex = 5;
            this.btn_form2.Text = "Kişiler";
            this.btn_form2.UseVisualStyleBackColor = true;
            this.btn_form2.Click += new System.EventHandler(this.btn_form2_Click);
            // 
            // txt_lokanta_id
            // 
            this.txt_lokanta_id.Location = new System.Drawing.Point(92, 372);
            this.txt_lokanta_id.Name = "txt_lokanta_id";
            this.txt_lokanta_id.Size = new System.Drawing.Size(100, 22);
            this.txt_lokanta_id.TabIndex = 6;
            this.txt_lokanta_id.Text = "1";
            this.txt_lokanta_id.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txt_lokanta_id.TextChanged += new System.EventHandler(this.txt_lokanta_id_TextChanged);
            // 
            // txt_yemekad
            // 
            this.txt_yemekad.Location = new System.Drawing.Point(92, 434);
            this.txt_yemekad.Name = "txt_yemekad";
            this.txt_yemekad.Size = new System.Drawing.Size(100, 22);
            this.txt_yemekad.TabIndex = 7;
            this.txt_yemekad.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // txt_personel_id
            // 
            this.txt_personel_id.Location = new System.Drawing.Point(92, 403);
            this.txt_personel_id.Name = "txt_personel_id";
            this.txt_personel_id.Size = new System.Drawing.Size(100, 22);
            this.txt_personel_id.TabIndex = 8;
            this.txt_personel_id.Text = "1";
            this.txt_personel_id.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txt_personel_id.TextChanged += new System.EventHandler(this.txt_personel_id_TextChanged);
            // 
            // txt_id
            // 
            this.txt_id.Location = new System.Drawing.Point(92, 341);
            this.txt_id.Name = "txt_id";
            this.txt_id.Size = new System.Drawing.Size(100, 22);
            this.txt_id.TabIndex = 9;
            this.txt_id.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txt_id.TextChanged += new System.EventHandler(this.txt_id_TextChanged);
            // 
            // txt_yemek_fiyat
            // 
            this.txt_yemek_fiyat.Location = new System.Drawing.Point(92, 465);
            this.txt_yemek_fiyat.Name = "txt_yemek_fiyat";
            this.txt_yemek_fiyat.Size = new System.Drawing.Size(100, 22);
            this.txt_yemek_fiyat.TabIndex = 10;
            this.txt_yemek_fiyat.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txt_yemek_fiyat.TextChanged += new System.EventHandler(this.txt_yemek_fiyat_TextChanged);
            // 
            // txt_yemekstok
            // 
            this.txt_yemekstok.Location = new System.Drawing.Point(92, 496);
            this.txt_yemekstok.Name = "txt_yemekstok";
            this.txt_yemekstok.Size = new System.Drawing.Size(100, 22);
            this.txt_yemekstok.TabIndex = 18;
            // 
            // txt_yemekkalori
            // 
            this.txt_yemekkalori.Location = new System.Drawing.Point(92, 527);
            this.txt_yemekkalori.Name = "txt_yemekkalori";
            this.txt_yemekkalori.Size = new System.Drawing.Size(100, 22);
            this.txt_yemekkalori.TabIndex = 19;
            // 
            // btn_silinenyemek
            // 
            this.btn_silinenyemek.Location = new System.Drawing.Point(562, 324);
            this.btn_silinenyemek.Name = "btn_silinenyemek";
            this.btn_silinenyemek.Size = new System.Drawing.Size(82, 57);
            this.btn_silinenyemek.TabIndex = 25;
            this.btn_silinenyemek.Text = "Silinen yemekler";
            this.btn_silinenyemek.UseVisualStyleBackColor = true;
            this.btn_silinenyemek.Click += new System.EventHandler(this.btn_silinenyemek_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(16, 344);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 17);
            this.label1.TabIndex = 11;
            this.label1.Text = "yemek id";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(11, 376);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(69, 17);
            this.label2.TabIndex = 12;
            this.label2.Text = "lokanta id";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(2, 406);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(78, 17);
            this.label3.TabIndex = 13;
            this.label3.Text = "personel id";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(11, 435);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(69, 17);
            this.label4.TabIndex = 14;
            this.label4.Text = "yemek ad";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(1, 465);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(79, 17);
            this.label5.TabIndex = 15;
            this.label5.Text = "yemek fiyat";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(2, 529);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(87, 17);
            this.label6.TabIndex = 16;
            this.label6.Text = "yemek kalori";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(1, 495);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(79, 17);
            this.label7.TabIndex = 17;
            this.label7.Text = "yemek stok";
            // 
            // lokanta_takip_sistemiDataSet1
            // 
            this.lokanta_takip_sistemiDataSet1.DataSetName = "Lokanta_takip_sistemiDataSet1";
            this.lokanta_takip_sistemiDataSet1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // lokantatakipsistemiDataSet1BindingSource
            // 
            this.lokantatakipsistemiDataSet1BindingSource.DataSource = this.lokanta_takip_sistemiDataSet1;
            this.lokantatakipsistemiDataSet1BindingSource.Position = 0;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(982, 653);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btn_silinenyemek);
            this.Controls.Add(this.txt_yemekkalori);
            this.Controls.Add(this.txt_yemekstok);
            this.Controls.Add(this.txt_yemek_fiyat);
            this.Controls.Add(this.txt_id);
            this.Controls.Add(this.txt_personel_id);
            this.Controls.Add(this.txt_yemekad);
            this.Controls.Add(this.txt_lokanta_id);
            this.Controls.Add(this.btn_form2);
            this.Controls.Add(this.btn_guncelle);
            this.Controls.Add(this.btn_sil);
            this.Controls.Add(this.btn_listele);
            this.Controls.Add(this.btn_ekle);
            this.Controls.Add(this.dataGridView1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lokanta_takip_sistemiDataSet1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lokantatakipsistemiDataSet1BindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button btn_ekle;
        private System.Windows.Forms.Button btn_listele;
        private System.Windows.Forms.Button btn_sil;
        private System.Windows.Forms.Button btn_guncelle;
        private System.Windows.Forms.Button btn_form2;
        private System.Windows.Forms.TextBox txt_lokanta_id;
        private System.Windows.Forms.TextBox txt_yemekad;
        private System.Windows.Forms.TextBox txt_personel_id;
        private System.Windows.Forms.TextBox txt_id;
        private System.Windows.Forms.TextBox txt_yemek_fiyat;
        private System.Windows.Forms.TextBox txt_yemekstok;
        private System.Windows.Forms.TextBox txt_yemekkalori;
        private System.Windows.Forms.Button btn_silinenyemek;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.BindingSource lokantatakipsistemiDataSet1BindingSource;
        private Lokanta_takip_sistemiDataSet1 lokanta_takip_sistemiDataSet1;
    }
}