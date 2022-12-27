SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = ON;
SELECT pg_catalog.set_config('search_path', '', FALSE);
SET check_function_bodies = FALSE;
SET xmloption = CONTENT;
SET client_min_messages = warning;
SET row_security = OFF;

-- CREATE SCHEMA "public" --------------------------------------
CREATE SCHEMA "public";
-- -------------------------------------------------------------

-- CHANGE "COMMENT" OF "SCHEMA "public" ------------------------
COMMENT ON SCHEMA "public" IS 'standard public schema';
-- -------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.kcal_toplam()         --(fonksiyon 1)--
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
	 DECLARE
	 toplam INTEGER; 
	 BEGIN
	 toplam:=(SELECT SUM("yemek_kcal")FROM "yemek");
	 RETURN toplam;
	END; 
	$function$;
	
	ALTER FUNCTION public.kcal_toplam() OWNER TO postgres;
	
	
CREATE OR REPLACE FUNCTION public.kcal_maks()           --(fonksiyon 2)--
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
	 DECLARE
	 maks INTEGER;
	 BEGIN
	 maks:=(SELECT MAX("yemek_kcal")FROM "yemek");
	 RETURN maks;
	END; 
	$function$;
	
	ALTER FUNCTION public.kcal_max() OWNER TO postgres;
		
	
CREATE OR REPLACE FUNCTION public.yemek_miktari()                 --(fonksiyon 3)--
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
	 DECLARE 
	 miktar INTEGER;
	 BEGIN
	 SELECT COUNT(*) INTO miktar FROM "yemek";
	 RETURN miktar;
	END; 
	$function$;
	
	ALTER FUNCTION public.yemek_miktari() OWNER TO postgres;
	
CREATE OR REPLACE FUNCTION public.siparis_sayisi()            --(fonksiyon 4)--
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
	 DECLARE
	 siparis_sayi INTEGER;
	  BEGIN
	  SELECT COUNT(*) INTO siparis_sayi FROM "siparis";
	   RETURN siparis_sayi;
	END; 
	$function$;
	
	ALTER FUNCTION public.siparis_sayisi() OWNER TO postgres;
	
	
	CREATE OR REPLACE FUNCTION public.silinen_yemek_trigger()    --(trigger fonksiyon 1)--
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
	BEGIN
	INSERT INTO tbl_silinen_yemek (yemek_id_s,yemek_ad_s)
	VALUES(OLD.yemek_id,OLD.yemek_ad);
	RETURN NEW;
	END; 
	$function$;
	
	ALTER FUNCTION public.silinen_yemek_trigger() OWNER TO postgres;
	
CREATE OR REPLACE FUNCTION public.toplam_yemek_trigger()       --(trigger fonksiyon 2)--
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
	BEGIN
	UPDATE tbl_toplam_yemek SET sayi=sayi+1;
	RETURN NEW;
	END; 
	$function$;
	
	ALTER FUNCTION public.toplam_yemek_trigger() OWNER TO postgres;
	
CREATE OR REPLACE FUNCTION public.toplam_yemek2_trigger()         --(trigger fonksiyon 3)--
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
	BEGIN
	UPDATE tbl_toplam_yemek SET sayi=sayi-1;
	RETURN NEW;
	END; 
	$function$;
	
	ALTER FUNCTION public.toplam_yemek2_trigger() OWNER TO postgres;


	CREATE OR REPLACE FUNCTION public.yemek_guncel_trigger()                 --(trigger fonksiyon 4)--
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
	BEGIN
	 IF NEW."yemek_fiyat" <> OLD."yemek_fiyat" THEN
        INSERT INTO "tbl_son_urun"("urunNo", "eski_fiyat", "yeni_fiyat")
        VALUES(OLD."yemek_id", OLD."yemek_fiyat", NEW."yemek_fiyat");
    END IF;

RETURN NEW;
	END; 
	$function$;
	
	ALTER FUNCTION public.yemek_guncel_trigger() OWNER TO postgres;
	
	SET default_tablespace = '';
	
	SET default_table_access_method = heap;


-- CREATE TABLE "kisi" -----------------------------------------
CREATE TABLE "public"."kisi" ( 
	"kisi_id" INTEGER NOT NULL,
	"kisi_ad" CHARACTER VARYING NOT NULL,
	"kisi_soyad" CHARACTER VARYING NOT NULL,
	"kisi_tel" TEXT,
	"kisi_tur" TEXT NOT NULL,
	PRIMARY KEY ( "kisi_id" ) );
 ;
-- -------------------------------------------------------------

ALTER TABLE public."kisi" OWNER TO postgres;

-- CREATE SEQUENCE "kisi_kisi_id_seq" --------------------------
CREATE SEQUENCE "public"."kisi_kisi_id_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE "public"."kisi_kisi_id_seq" OWNER TO postgres;

ALTER SEQUENCE "public"."kisi_kisi_id_seq" OWNED BY public."kisi".kisi_id;

-- CREATE TABLE "musteri" -------------------------------------- (kisi tablosundan kalıtım alır.)
CREATE TABLE "public"."musteri" ( 
	"kisi_id" INTEGER NOT NULL,
	"temsilci_id" INTEGER NOT NULL,
	"musteri_adres" TEXT NOT NULL,
	PRIMARY KEY ( "kisi_id" ),
	CONSTRAINT "unique_musteri_temsilci_id" UNIQUE( "temsilci_id" ) );

-- -------------------------------------------------------------

ALTER TABLE public."musteri" OWNER TO postgres;

-- CREATE SEQUENCE "musteri_kisi_id_seq" -----------------------
CREATE SEQUENCE "public"."musteri_kisi_id_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE "public"."musteri_kisi_id_seq" OWNER TO postgres;

ALTER SEQUENCE "public"."musteri_kisi_id_seq" OWNED BY public.musteri."kisi_id";


-- CREATE TABLE "musteri_temsilcisi" ---------------------------(kisi tablosundan kalıtım alır.)
CREATE TABLE "public"."musteri_temsilcisi" ( 
	"kisi_id" INTEGER NOT NULL,
	PRIMARY KEY ( "kisi_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.musteri_temsilcisi OWNER TO postgres;

-- CREATE SEQUENCE "musteri_temsilcisi_kisi_id_seq" ------------
CREATE SEQUENCE "public"."musteri_temsilcisi_kisi_id_seq"
MINVALUE 1
MAXVALUE 100
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE "public"."musteri_temsilcisi_kisi_id_seq" OWNER TO postgres;

ALTER SEQUENCE "public"."musteri_temsilcisi_kisi_id_seq" OWNED BY public.musteri_temsilcisi."kisi_id";

-- CREATE TABLE "personel" -------------------------------------(kisi tablosundan kalıtım alır.)
CREATE TABLE "public"."personel" ( 
	"kisi_id" INTEGER NOT NULL,
	"lokanta_id" INTEGER NOT NULL,
	"personel_ad" CHARACTER VARYING NOT NULL,
	"personel_soyad" CHARACTER VARYING NOT NULL,
	PRIMARY KEY ( "kisi_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public."personel" OWNER TO postgres;

-- CREATE SEQUENCE "personel_kisi_id_seq" ----------------------
CREATE SEQUENCE "public"."personel_kisi_id_seq"
MINVALUE 1
MAXVALUE 1000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public."personel_kisi_id_seq" OWNER TO postgres;

ALTER SEQUENCE public."personel_kisi_id_seq" OWNED BY public.personel."kisi_id";

-- CREATE TABLE "kurye" ----------------------------------------(kisi tablosundan kalıtım alır.)
CREATE TABLE "public"."kurye" ( 
	"kisi_id" INTEGER NOT NULL,
	"siparis_id" INTEGER NOT NULL,
	"musteri_id" INTEGER NOT NULL,
	"yemek_id" INTEGER NOT NULL,
	"temsilci_id" INTEGER NOT NULL );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.kurye OWNER TO postgres;

-- CREATE SEQUENCE "kurye_kisi_id_seq" -------------------------
CREATE SEQUENCE "public"."kurye_kisi_id_seq"
MINVALUE 1
MAXVALUE 100
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public."kurye_kisi_id_seq" OWNER TO postgres;

ALTER SEQUENCE public."kurye_kisi_id_seq" OWNED BY public.kurye."kisi_id";

-- CREATE TABLE "siparis" --------------------------------------
CREATE TABLE "public"."siparis" ( 
	"siparis_id" INTEGER NOT NULL,
	"siparis_tarih" Date NOT NULL,
	"musteri_id" INTEGER NOT NULL,
	"fatura_id" INTEGER NOT NULL,
	PRIMARY KEY ( "siparis_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.siparis OWNER TO postgres;

-- CREATE SEQUENCE "siparis_siparis_id_seq" --------------------
CREATE SEQUENCE "public"."siparis_siparis_id_seq"
MINVALUE 1
MAXVALUE 100000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.siparis_siparis_id_seq OWNER TO postgres;

ALTER SEQUENCE public.siparis_siparis_id_seq OWNED BY public.siparis."siparis_id";

-- CREATE TABLE "yemek_siparis" --------------------------------
CREATE TABLE "public"."yemek_siparis" ( 
	"yemek_id" INTEGER NOT NULL,
	"siparis_id" INTEGER NOT NULL,
	PRIMARY KEY ( "yemek_id", "siparis_id" ) );
 ;
-- -------------------------------------------------------------

ALTER TABLE public."yemek_siparis" OWNER TO postgres;

-- CREATE SEQUENCE "yemek_siparis_siparis_id_seq" --------------
CREATE SEQUENCE "public"."yemek_siparis_siparis_id_seq"
MINVALUE 1
MAXVALUE 100000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public."yemek_siparis_siparis_id_seq" OWNER TO postgres;

ALTER SEQUENCE public."yemek_siparis_siparis_id_seq" OWNED BY public."yemek_siparis".siparis_id;

-- CREATE SEQUENCE "yemek_siparis_yemek_id_seq" ----------------
CREATE SEQUENCE "public"."yemek_siparis_yemek_id_seq"
MINVALUE 1
MAXVALUE 1000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public."yemek_siparis_yemek_id_seq" OWNER TO postgres;

ALTER SEQUENCE public."yemek_siparis_yemek_id_seq" OWNED BY public."yemek_siparis".yemek_id;

-- CREATE TABLE "yemek_tipi" -----------------------------------
CREATE TABLE "public"."yemek_tipi" ( 
	"ytipi_id" INTEGER NOT NULL,
	"yemek_id" INTEGER NOT NULL,
	"ytipi_adi" TEXT NOT NULL,
	PRIMARY KEY ( "ytipi_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.yemek_tipi OWNER TO postgres;

-- CREATE SEQUENCE "yemek_tipi_ytipi_id_seq" -------------------
CREATE SEQUENCE "public"."yemek_tipi_ytipi_id_seq"
MINVALUE 1
MAXVALUE 1000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.yemek_tipi_ytipi_id_seq OWNER TO postgres;

ALTER SEQUENCE public.yemek_tipi_ytipi_id_seq OWNED BY public.yemek_tipi.ytipi_id;


-- CREATE TABLE "malzeme_yemek" --------------------------------
CREATE TABLE "public"."malzeme_yemek" ( 
	"malzeme_id" INTEGER NOT NULL,
	"yemek_id" INTEGER NOT NULL,
	PRIMARY KEY ( "malzeme_id", "yemek_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public."malzeme_yemek" OWNER TO postgres;

-- CREATE TABLE "yemek" ----------------------------------------
CREATE TABLE "public"."yemek" ( 
	"yemek_id" INTEGER NOT NULL,
	"lokanta_id" INTEGER NOT NULL,
	"personel_id" INTEGER NOT NULL,
	"yemek_adi" TEXT NOT NULL,
	"yemek_fiyat" Money NOT NULL,
	"yemek_stok" INTEGER NOT NULL,
	"yemek_kcal" INTEGER NOT NULL,
	PRIMARY KEY ( "yemek_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.yemek OWNER TO postgres;

-- CREATE SEQUENCE "yemek_yemek_id_seq" ------------------------
CREATE SEQUENCE "public"."yemek_yemek_id_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.yemek_yemek_id_seq OWNER TO postgres;

ALTER SEQUENCE public.yemek_yemek_id_seq OWNED BY public.yemek.yemek_id;

-- CREATE TABLE "fatura" ---------------------------------------
CREATE TABLE "public"."fatura" ( 
	"fatura_id" INTEGER NOT NULL,
	"fatura_tutar" Money NOT NULL,
	"fatura_tarih" Date NOT NULL,
	PRIMARY KEY ( "fatura_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.fatura OWNER TO postgres;

-- CREATE SEQUENCE "fatura_fatura_id_seq" ----------------------
CREATE SEQUENCE "public"."fatura_fatura_id_seq"
MINVALUE 1
MAXVALUE 100000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.fatura_fatura_id_seq OWNER TO postgres;

ALTER SEQUENCE public.fatura_fatura_id_seq OWNED BY public.fatura.fatura_id;

-- CREATE TABLE "lokanta" --------------------------------------
CREATE TABLE "public"."lokanta" ( 
	"lokanta_id" INTEGER NOT NULL,
	"lokanta_adi" TEXT NOT NULL,
	"lokanta_adres" TEXT NOT NULL,
	"lokanta_tel" TEXT,
	PRIMARY KEY ( "lokanta_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.lokanta OWNER TO postgres;

-- CREATE SEQUENCE "lokanta_lokanta_id_seq" --------------------
CREATE SEQUENCE "public"."lokanta_lokanta_id_seq"
MINVALUE 1
MAXVALUE 10
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.lokanta_lokanta_id_seq OWNER TO postgres;

ALTER SEQUENCE public.lokanta_lokanta_id_seq OWNED BY public.lokanta.lokanta_id;

-- CREATE TABLE "tedarik" --------------------------------------
CREATE TABLE "public"."tedarik" ( 
	"tedarik_id" INTEGER NOT NULL,
	"tedarik_adi" TEXT NOT NULL,
	"tedarik_tarih" Date NOT NULL,
	"tedarikci_ad" TEXT NOT NULL,
	"tedarikci_soyad" TEXT NOT NULL,
	PRIMARY KEY ( "tedarik_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.tedarik OWNER TO postgres;

-- CREATE SEQUENCE "tedarik_tedarik_id_seq" --------------------
CREATE SEQUENCE "public"."tedarik_tedarik_id_seq"
MINVALUE 1
MAXVALUE 100
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.tedarik_tedarik_id_seq OWNER TO postgres;

ALTER SEQUENCE public.tedarik_tedarik_id_seq OWNED BY public.tedarik.tedarik_id;


-- CREATE TABLE "malzeme" --------------------------------------
CREATE TABLE "public"."malzeme" ( 
	"malzeme_id" INTEGER NOT NULL,
	"malzeme_adi" TEXT NOT NULL,
	"malzeme_fiyat" Money NOT NULL,
	"malzeme_stok" INTEGER NOT NULL,
	"tedarik_id" INTEGER NOT NULL,
	PRIMARY KEY ( "malzeme_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme OWNER TO postgres;

-- CREATE SEQUENCE "malzeme_malzeme_adi_seq" -------------------
CREATE SEQUENCE "public"."malzeme_malzeme_adi_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme_malzeme_adi_seq OWNER TO postgres;

ALTER SEQUENCE public.malzeme_malzeme_adi_seq OWNED BY public.malzeme.malzeme_adi;

-- CREATE SEQUENCE "malzeme_malzeme_fiyat_seq" -----------------
CREATE SEQUENCE "public"."malzeme_malzeme_fiyat_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme_malzeme_fiyat_seq OWNER TO postgres;

ALTER SEQUENCE public.malzeme_malzeme_fiyat_seq OWNED BY public.malzeme.malzeme_fiyat;

-- CREATE SEQUENCE "malzeme_malzeme_id_seq" --------------------
CREATE SEQUENCE "public"."malzeme_malzeme_id_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme_malzeme_id_seq OWNER TO postgres;

ALTER SEQUENCE public.malzeme_malzeme_id_seq OWNED BY public.malzeme.malzeme_id;

-- CREATE SEQUENCE "malzeme_malzeme_stok_seq" ------------------
CREATE SEQUENCE "public"."malzeme_malzeme_stok_seq"
MINVALUE 1
MAXVALUE 100000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme_malzeme_stok_seq OWNER TO postgres;

ALTER SEQUENCE public.malzeme_malzeme_stok_seq OWNED BY public.malzeme.malzeme_stok;

-- CREATE SEQUENCE "malzeme_tedarik_id_seq" --------------------
CREATE SEQUENCE "public"."malzeme_tedarik_id_seq"
MINVALUE 1
MAXVALUE 100
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme_tedarik_id_seq OWNER TO postgres;

ALTER SEQUENCE public.malzeme_tedarik_id_seq OWNED BY public.malzeme.tedarik_id;

-- CREATE TABLE "malzeme_tipi" ---------------------------------
CREATE TABLE "public"."malzeme_tipi" ( 
	"malzeme_tipi_id" INTEGER NOT NULL,
	"malzeme_id" INTEGER NOT NULL,
	"malzeme_tipi_adi" TEXT NOT NULL,
	PRIMARY KEY ( "malzeme_tipi_id" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme_tipi OWNER TO postgres;

-- CREATE SEQUENCE "malzeme_tipi_malzeme_tipi_id_seq" ----------
CREATE SEQUENCE "public"."malzeme_tipi_malzeme_tipi_id_seq"
MINVALUE 1
MAXVALUE 1000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.malzeme_tipi_malzeme_tipi_id_seq OWNER TO postgres;

ALTER SEQUENCE public.malzeme_tipi_malzeme_tipi_id_seq OWNED BY public.malzeme_tipi.malzeme_tipi_id;

-- CREATE TABLE "tbl_silinen_yemek" ----------------------------
CREATE TABLE "public"."tbl_silinen_yemek" ( 
	"kayit" INTEGER NOT NULL,
	"yemek_id_s" INTEGER NOT NULL,
	"public""yemek_ad_s" TEXT NOT NULL, 
	PRIMARY KEY ( "kayit" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.tbl_silinen_yemek OWNER TO postgres;

-- CREATE SEQUENCE "tbl_silinen_yemek_kayit_seq" ---------------
CREATE SEQUENCE "public"."tbl_silinen_yemek_kayit_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public.tbl_silinen_yemek_kayit_seq OWNER TO postgres;

ALTER SEQUENCE public.tbl_silinen_yemek_kayit_seq OWNED BY public.tbl_silinen_yemek.kayit;

-- CREATE TABLE "tbl_toplam_yemek" -----------------------------
CREATE TABLE "public"."tbl_toplam_yemek" ( 
	"sayi" INTEGER NOT NULL,
	PRIMARY KEY ( "sayi" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.tbl_toplam_yemek OWNER TO postgres;

-- CREATE TABLE "tbl_son_urun" ---------------------------------
CREATE TABLE "public"."tbl_son_urun" ( 
	"kayitNo" INTEGER NOT NULL,
	"urunNo" SMALLINT NOT NULL,
	"eski_fiyat" Money NOT NULL,
	"yeni_fiyat" Money NOT NULL,
	PRIMARY KEY ( "kayitNo" ) );
 ;
-- -------------------------------------------------------------
ALTER TABLE public.tbl_son_urun OWNER TO postgres;

-- CREATE SEQUENCE "tbl_son_urun_kayitNo_seq" ------------------
CREATE SEQUENCE "public"."tbl_son_urun_kayitNo_seq"
MINVALUE 1
MAXVALUE 10000
START 1
CACHE 1;
-- -------------------------------------------------------------
ALTER TABLE public."tbl_son_urun_kayitNo_seq" OWNER TO postgres;

ALTER SEQUENCE public."tbl_son_urun_kayitNo_seq" OWNED BY public.tbl_son_urun."kayitNo";


-- CREATE LINK "musteri_temsilcisi>musteri" --------------------
ALTER TABLE "public"."musteri"
	ADD CONSTRAINT "musteri_temsilcisi>musteri" FOREIGN KEY ( "temsilci_id" )
	REFERENCES "public"."musteri_temsilcisi" ( "kisi_id" ) MATCH FULL
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
-- -------------------------------------------------------------

-- CREATE LINK "kisi>musteri" ----------------------------------
ALTER TABLE "public"."musteri"
	ADD CONSTRAINT "kisi>musteri" FOREIGN KEY ( "kisi_id" )
	REFERENCES "public"."kisi" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "kisi>musteri_temsilcisi" -----------------------
ALTER TABLE "public"."musteri_temsilcisi"
	ADD CONSTRAINT "kisi>musteri_temsilcisi" FOREIGN KEY ( "kisi_id" )
	REFERENCES "public"."kisi" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "lokanta>personel" ------------------------------
ALTER TABLE "public"."personel"
	ADD CONSTRAINT "lokanta>personel" FOREIGN KEY ( "lokanta_id" )
	REFERENCES "public"."lokanta" ( "lokanta_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "kisi>personel" ---------------------------------
ALTER TABLE "public"."personel"
	ADD CONSTRAINT "kisi>personel" FOREIGN KEY ( "kisi_id" )
	REFERENCES "public"."kisi" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "musteri_temsicisi>kurye" -----------------------
ALTER TABLE "public"."kurye"
	ADD CONSTRAINT "musteri_temsicisi>kurye" FOREIGN KEY ( "temsilci_id" )
	REFERENCES "public"."musteri_temsilcisi" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "musteri>kurye" ---------------------------------
ALTER TABLE "public"."kurye"
	ADD CONSTRAINT "musteri>kurye" FOREIGN KEY ( "musteri_id" )
	REFERENCES "public"."musteri" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "fatura>kurye" ----------------------------------
ALTER TABLE "public"."kurye"
	ADD CONSTRAINT "fatura>kurye" FOREIGN KEY ( "siparis_id" )
	REFERENCES "public"."fatura" ( "fatura_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "yemek>kurye" -----------------------------------
ALTER TABLE "public"."kurye"
	ADD CONSTRAINT "yemek>kurye" FOREIGN KEY ( "yemek_id" )
	REFERENCES "public"."yemek" ( "yemek_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "kisi>kurye" ------------------------------------
ALTER TABLE "public"."kurye"
	ADD CONSTRAINT "kisi>kurye" FOREIGN KEY ( "kisi_id" )
	REFERENCES "public"."kisi" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "musteri>siparis" -------------------------------
ALTER TABLE "public"."siparis"
	ADD CONSTRAINT "musteri>siparis" FOREIGN KEY ( "musteri_id" )
	REFERENCES "public"."musteri" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "fatura>siparis" --------------------------------
ALTER TABLE "public"."siparis"
	ADD CONSTRAINT "fatura>siparis" FOREIGN KEY ( "fatura_id" )
	REFERENCES "public"."fatura" ( "fatura_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "siparis>yemek_siparis" -------------------------
ALTER TABLE "public"."yemek_siparis"
	ADD CONSTRAINT "siparis>yemek_siparis" FOREIGN KEY ( "siparis_id" )
	REFERENCES "public"."siparis" ( "siparis_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "yemek>yemek_tipi" ------------------------------
ALTER TABLE "public"."yemek_tipi"
	ADD CONSTRAINT "yemek>yemek_tipi" FOREIGN KEY ( "yemek_id" )
	REFERENCES "public"."yemek" ( "yemek_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "yemek>malzeme_yemek" ---------------------------
ALTER TABLE "public"."malzeme_yemek"
	ADD CONSTRAINT "yemek>malzeme_yemek" FOREIGN KEY ( "yemek_id" )
	REFERENCES "public"."yemek" ( "yemek_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "malzeme>malzeme_yemek" -------------------------
ALTER TABLE "public"."malzeme_yemek"
	ADD CONSTRAINT "malzeme>malzeme_yemek" FOREIGN KEY ( "malzeme_id" )
	REFERENCES "public"."malzeme" ( "malzeme_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "personel>yemek" --------------------------------
ALTER TABLE "public"."yemek"
	ADD CONSTRAINT "personel>yemek" FOREIGN KEY ( "personel_id" )
	REFERENCES "public"."personel" ( "kisi_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
	
	-- CREATE LINK "lokanta>yemek" ---------------------------------
ALTER TABLE "public"."yemek"
	ADD CONSTRAINT "lokanta>yemek" FOREIGN KEY ( "lokanta_id" )
	REFERENCES "public"."lokanta" ( "lokanta_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "tedarik>malzeme" -------------------------------
ALTER TABLE "public"."malzeme"
	ADD CONSTRAINT "tedarik>malzeme" FOREIGN KEY ( "tedarik_id" )
	REFERENCES "public"."tedarik" ( "tedarik_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

-- CREATE LINK "malzeme>malzeme_tipi" --------------------------
ALTER TABLE "public"."malzeme_tipi"
	ADD CONSTRAINT "malzeme>malzeme_tipi" FOREIGN KEY ( "malzeme_id" )
	REFERENCES "public"."malzeme" ( "malzeme_id" ) MATCH FULL
	ON DELETE CASCADE;
	ON UPDATE CASCADE;
-- -------------------------------------------------------------

INSERT INTO "public"."kisi" ( "kisi_id", "kisi_ad", "kisi_soyad", "kisi_tel", "kisi_tur") 
VALUES ( kisi_id, kisi_ad, kisi_soyad, kisi_tel, kisi_tur );  --(Degerler girildi)--

INSERT INTO "public"."musteri" ( "kisi_id", "temsilci_id", "musteri_adres") 
VALUES ( kisi_id, temsilci_id, musteri_adres );    --(Degerler girildi)--

INSERT INTO "public"."musteri_temsilcisi" ( "kisi_id") 
VALUES ( kisi_id );            --(Degerler girildi)--

INSERT INTO "public"."kurye" ( "kisi_id", "siparis_id", "musteri_id", "yemek_id", "temsilci_id") 
VALUES ( kisi_id, siparis_id, musteri_id, yemek_id, temsilci_id );   --(Degerler girildi)--

INSERT INTO "public"."siparis" ( "siparis_id", "siparis_tarih", "musteri_id", "fatura_id") 
VALUES ( siparis_id, siparis_tarih, musteri_id, fatura_id );      --(Degerler girildi)--

INSERT INTO "public"."yemek_siparis" ( "yemek_id", "siparis_id") 
VALUES ( yemek_id, siparis_id );            --(Degerler girildi)--

INSERT INTO "public"."yemek_tipi" ( "ytipi_id", "yemek_id", "ytipi_adi") 
VALUES ( ytipi_id, yemek_id, ytipi_adi );       --(Degerler girildi)--

INSERT INTO "public"."malzeme_yemek" ( "malzeme_id", "yemek_id") 
VALUES ( malzeme_id, yemek_id );       --(Degerler girildi)--

INSERT INTO "public"."yemek" ( "yemek_id", "lokanta_id", "personel_id", "yemek_adi", "yemek_fiyat", "yemek_stok", "yemek_kcal") 
VALUES ( yemek_id, lokanta_id, personel_id, yemek_adi, yemek_fiyat, yemek_stok, yemek_kcal );     --(Degerler girildi)--

INSERT INTO "public"."fatura" ( "fatura_id", "fatura_tutar", "fatura_tarih") 
VALUES ( fatura_id, fatura_tutar, fatura_tarih );        --(Degerler girildi)--

INSERT INTO "public"."lokanta" ( "lokanta_id", "lokanta_adi", "lokanta_adres", "lokanta_tel") 
VALUES ( lokanta_id, lokanta_adi, lokanta_adres, lokanta_tel );      --(Degerler girildi)--

INSERT INTO "public"."tedarik" ( "tedarik_id", "tedarik_adi", "tedarik_tarih", "tedarikci_ad", "tedarikci_soyad") 
VALUES ( tedarik_id, tedarik_adi, tedarik_tarih, tedarikci_ad, tedarikci_soyad );         --(Degerler girildi)--

INSERT INTO "public"."malzeme" ( "malzeme_id", "malzeme_adi", "malzeme_fiyat", "malzeme_stok", "tedarik_id") 
VALUES ( malzeme_id, malzeme_adi, malzeme_fiyat, malzeme_stok, tedarik_id );         --(Degerler girildi)--

INSERT INTO "public"."malzeme_tipi" ( "malzeme_tipi_id", "malzeme_id", "malzeme_tipi_adi") 
VALUES ( malzeme_tipi_id, malzeme_id, malzeme_tipi_adi );         --(Degerler girildi)--

INSERT INTO "public"."tbl_silinen_yemek" ( "kayit", "yemek_id_s", "yemek_ad_s") 
VALUES ( kayit, yemek_id_s, yemek_ad_s );           --(Degerler girildi)--

INSERT INTO "public"."tbl_son_urun" ( "kayitNo", "urunNo", "eski_fiyat", "yeni_fiyat") 
VALUES ( kayitNo, urunNo, eski_fiyat, yeni_fiyat );         --(Degerler girildi)--

INSERT INTO "public"."tbl_toplam_yemek" ( "sayi") 
VALUES ( sayi );        --(Degerler girildi)--



ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT "fk_kisi_id" FOREIGN KEY ("kisi_id") REFERENCES public.kisi(kisi_id);

ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT fk_musteri_id FOREIGN KEY (musteri_id) REFERENCES public.musteri("kisi_id");
    
ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT fk_siparis FOREIGN KEY (siparis_id) REFERENCES public.siparis(siparis_id);
    
ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT fk_temsilci_id FOREIGN KEY (temsilci_id) REFERENCES public.musteri_temsilcisi("kisi_id");
    
ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.yemek(yemek_id);
    
ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT fk_kisi_id FOREIGN KEY ("kisi_id") REFERENCES public.kisi(kisi_id);
    
ALTER TABLE ONLY public.musteri_temsilcisi
    ADD CONSTRAINT fk_kisi_id FOREIGN KEY ("kisi_id") REFERENCES public.kisi(kisi_id);
    
ALTER TABLE ONLY public.personel
    ADD CONSTRAINT fk_kisi_id FOREIGN KEY ("kisi_id") REFERENCES public.kisi(kisi_id);
    
ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT fk_fatura_id FOREIGN KEY (fatura_id) REFERENCES public.fatura(fatura_id);
    
ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT fk_musteri_id FOREIGN KEY (musteri_id) REFERENCES public.musteri("kisi_id");
    
ALTER TABLE ONLY public.yemek
    ADD CONSTRAINT fk_lokanta_id FOREIGN KEY (lokanta_id) REFERENCES public.lokanta(lokanta_id);
    
ALTER TABLE ONLY public.yemek
    ADD CONSTRAINT fk_personel_id FOREIGN KEY (personel_id) REFERENCES public.personel("kisi_id");
    
ALTER TABLE ONLY public."yemek_siparis"
    ADD CONSTRAINT fk_siparis_id FOREIGN KEY (siparis_id) REFERENCES public.siparis(siparis_id);
    
ALTER TABLE ONLY public."yemek_siparis"
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.yemek(yemek_id);
    
ALTER TABLE ONLY public.yemek_tipi
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.yemek(yemek_id);
    
ALTER TABLE ONLY public."malzeme_yemek"
    ADD CONSTRAINT fk_malzeme_id FOREIGN KEY (malzeme_id) REFERENCES public.malzeme(malzeme_id);
    
ALTER TABLE ONLY public."malzeme_yemek"
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.yemek(yemek_id);
    
ALTER TABLE ONLY public.malzeme_tipi
    ADD CONSTRAINT fk_malzeme_id FOREIGN KEY (malzeme_id) REFERENCES public.malzeme(malzeme_id);
    
ALTER TABLE ONLY public.malzeme
    ADD CONSTRAINT fk_tedarik_id FOREIGN KEY (tedarik_id) REFERENCES public.tedarik(tedarik_id);
    
    
ALTER TABLE ONLY public.kurye ALTER COLUMN "kisi_id" SET DEFAULT nextval('public."kurye_kisi_id_seq"'::regclass);

ALTER TABLE ONLY public.personel ALTER COLUMN "kisi_id" SET DEFAULT nextval('public."personel_kisi_id_seq"'::regclass);

ALTER TABLE ONLY public.musteri ALTER COLUMN "kisi_id" SET DEFAULT nextval('public."musteri_kisi_id_seq"'::regclass);

ALTER TABLE ONLY public.musteri_temsilcisi ALTER COLUMN "kisi_id" SET DEFAULT nextval('public."musteri_temsilcisi_kisi_id_seq"'::regclass);

ALTER TABLE ONLY public.siparis ALTER COLUMN siparis_id SET DEFAULT nextval('public.siparis_siparis_id_seq'::regclass);

ALTER TABLE ONLY public."yemek_siparis" ALTER COLUMN siparis_id SET DEFAULT nextval('public."yemek_siparis_siparis_id_seq"'::regclass);

ALTER TABLE ONLY public."yemek_siparis" ALTER COLUMN yemek_id SET DEFAULT nextval('public."yemek_siparis_yemek_id_seq"'::regclass);

ALTER TABLE ONLY public.fatura ALTER COLUMN fatura_id SET DEFAULT nextval('public.fatura_fatura_id_seq'::regclass);

ALTER TABLE ONLY public.kisi ALTER COLUMN kisi_id SET DEFAULT nextval('public."kisi_kisi_id_seq"'::regclass);

ALTER TABLE ONLY public.lokanta ALTER COLUMN lokanta_id SET DEFAULT nextval('public.lokanta_lokanta_id_seq'::regclass);

ALTER TABLE ONLY public.tedarik ALTER COLUMN tedarik_id SET DEFAULT nextval('public.tedarik_tedarik_id_seq'::regclass);

ALTER TABLE ONLY public.malzeme ALTER COLUMN malzeme_id SET DEFAULT nextval('public.malzeme_malzeme_id_seq'::regclass);

ALTER TABLE ONLY public.malzeme ALTER COLUMN tedarik_id SET DEFAULT nextval('public.malzeme_tedarik_id_seq'::regclass);

ALTER TABLE ONLY public.malzeme ALTER COLUMN malzeme_adi SET DEFAULT nextval('public.malzeme_malzeme_adi_seq'::regclass);

ALTER TABLE ONLY public.malzeme ALTER COLUMN malzeme_stok SET DEFAULT nextval('public.malzeme_malzeme_stok_seq'::regclass);

ALTER TABLE ONLY public.malzeme ALTER COLUMN malzeme_fiyat SET DEFAULT nextval('public.malzeme_malzeme_fiyat_seq'::regclass);

ALTER TABLE ONLY public.yemek ALTER COLUMN yemek_id SET DEFAULT nextval('public.yemek_yemek_id_seq'::regclass);

ALTER TABLE ONLY public.yemek_tipi ALTER COLUMN ytipi_id SET DEFAULT nextval('public.yemek_tipi_ytipi_id_seq'::regclass);

ALTER TABLE ONLY public.malzeme_tipi ALTER COLUMN malzeme_tipi_id SET DEFAULT nextval('public.malzeme_tipi_malzeme_tipi_id_seq'::regclass);

ALTER TABLE ONLY public.tbl_silinen_yemek ALTER COLUMN kayit SET DEFAULT nextval('public.tbl_silinen_yemek_kayit_seq'::regclass);

ALTER TABLE ONLY public.tbl_son_urun ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."tbl_son_urun_kayitNo_seq"'::regclass);

SELECT pg_catalog.setval('public."kurye_kisi_id_seq"', 2, TRUE);

SELECT pg_catalog.setval('public."kisi_kisi_id_seq"', 4, TRUE);

SELECT pg_catalog.setval('public."yemek_siparis_siparis_id_seq"', 1, FALSE);

SELECT pg_catalog.setval('public."yemek_siparis_yemek_id_seq"', 1, FALSE);

SELECT pg_catalog.setval('public.fatura_fatura_id_seq', 7, TRUE);

SELECT pg_catalog.setval('public.lokanta_lokanta_id_seq', 17, TRUE);

SELECT pg_catalog.setval('public.malzeme_tipi_malzeme_tipi_id_seq', 1, FALSE);

SELECT pg_catalog.setval('public.malzeme_malzeme_adi_seq', 1, FALSE);

SELECT pg_catalog.setval('public.malzeme_malzeme_fiyat_seq', 1, FALSE);

SELECT pg_catalog.setval('public.malzeme_malzeme_id_seq', 1, FALSE);

SELECT pg_catalog.setval('public.malzeme_malzeme_stok_seq', 1, FALSE);

SELECT pg_catalog.setval('public.malzeme_tedarik_id_seq', 1, FALSE);

SELECT pg_catalog.setval('public."musteri_kisi_id_seq"', 2, TRUE);

SELECT pg_catalog.setval('public."musteri_temsilcisi_kisi_id_seq"', 1, FALSE);

SELECT pg_catalog.setval('public."personel_kisi_id_seq"', 8, TRUE);

SELECT pg_catalog.setval('public.tbl_silinen_yemek_kayit_seq', 5, TRUE);

SELECT pg_catalog.setval('public.siparis_siparis_id_seq', 9, TRUE);

SELECT pg_catalog.setval('public.tedarik_tedarik_id_seq', 1, FALSE);

SELECT pg_catalog.setval('public."tbl_son_urun_kayitNo_seq"', 9, TRUE);

SELECT pg_catalog.setval('public.yemek_tipi_ytipi_id_seq', 1, FALSE);

SELECT pg_catalog.setval('public.yemek_yemek_id_seq', 13, TRUE);

-- CREATE INDEX "fki_fk_kisi_id" -------------------------------
CREATE INDEX "fki_fk_kisi_id" ON "public"."kurye" USING btree( "kisi_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_musteri_id" ----------------------------
CREATE INDEX "fki_fk_musteri_id" ON "public"."kurye" USING btree( "musteri_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_siparis_id" ----------------------------
CREATE INDEX "fki_fk_siparis_id" ON "public"."kurye" USING btree( "siparis_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_temsilci_id" ---------------------------
CREATE INDEX "fki_fk_temsilci_id" ON "public"."kurye" USING btree( "temsilci_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_yemek_id" ------------------------------
CREATE INDEX "fki_fk_yemek_id" ON "public"."kurye" USING btree( "yemek_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_fatura_id" -----------------------------
CREATE INDEX "fki_fk_fatura_id" ON "public"."siparis" USING btree( "fatura_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_Kisi_id" -------------------------------
CREATE INDEX "fki_fk_Kisi_id" ON "public"."musteri" USING btree( "kisi_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_lokanta_id" ----------------------------
CREATE INDEX "fki_fk_lokanta_id" ON "public"."yemek" USING btree( "lokanta_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_personel_id" ---------------------------
CREATE INDEX "fki_fk_personel_id" ON "public"."yemek" USING btree( "personel_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_malzeme_id" ----------------------------
CREATE INDEX "fki_fk_malzeme_id" ON "public"."malzeme_yemek" USING btree( "malzeme_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_siparis_İd" ----------------------------
CREATE INDEX "fki_fk_siparis_İd" ON "public"."yemek_siparis" USING btree( "siparis_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_tedarik_id" ----------------------------
CREATE INDEX "fki_fk_tedarik_id" ON "public"."malzeme" USING btree( "tedarik_id" ASC NULLS LAST );
-- -------------------------------------------------------------

-- CREATE INDEX "fki_fk_Yemek_id" ------------------------------
CREATE INDEX "fki_fk_Yemek_id" ON "public"."yemek_siparis" USING btree( "yemek_id" ASC NULLS LAST );
-- -------------------------------------------------------------


















    
    






