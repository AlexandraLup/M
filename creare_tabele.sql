
DROP TABLE angajati CASCADE CONSTRAINTS
/
DROP TABLE clienti CASCADE CONSTRAINTS
/
DROP TABLE facturi CASCADE CONSTRAINTS
/
DROP TABLE produse CASCADE CONSTRAINTS
/
DROP TABLE lista_produse CASCADE CONSTRAINTS
/
DROP TABLE stocuri_magazin CASCADE CONSTRAINTS
/
DROP TABLE magazine CASCADE CONSTRAINTS
/
DROP TABLE evidente CASCADE CONSTRAINTS
/
DROP TABLE contracte CASCADE CONSTRAINTS
/
DROP TABLE cheltuieli CASCADE CONSTRAINTS
/
DROP TABLE venituri CASCADE CONSTRAINTS
/
CREATE TABLE magazine (
  id INT NOT NULL PRIMARY KEY,
  adresa VARCHAR2(100) NOT NULL,
  telefon  VARCHAR2(11) NOT NULL,
  nr_angajati INT
)
/

CREATE TABLE angajati (
  id INT NOT NULL PRIMARY KEY,
  id_magazin INT NOT NULL,
  nume VARCHAR2(15) NOT NULL,
  prenume VARCHAR2(30) NOT NULL,
  salariu NUMBER(10,2),
  functie VARCHAR2(20),
  data_angajare DATE,
 CONSTRAINT fk_angajati_id_magazin FOREIGN KEY (id_magazin) REFERENCES magazine(id)
)
/

CREATE TABLE clienti (
  id INT NOT NULL PRIMARY KEY,
  nume VARCHAR2(15) NOT NULL,
  prenume VARCHAR2(30) NOT NULL,
  data_inregistrare DATE
)
/
create table produse(
  id INT PRIMARY KEY,
  categorie  VARCHAR2(30),
  denumire  VARCHAR2(100),
  model_produs VARCHAR2(30),
  culoare VARCHAR2(30),
  pret NUMBER(10,2)
);
/
create table stocuri_magazin(
id INT PRIMARY KEY,
id_magazin INT NOT NULL,
id_produs INT NOT NULL,
stoc_XS INT,
stoc_S INT,
stoc_M INT,
stoc_L INT,
stoc_XL INT,
CONSTRAINT fk_stocuri_magazin_id_magazin FOREIGN KEY (id_magazin) REFERENCES magazine(id),
CONSTRAINT fk_stocuri_magazin_id_produs FOREIGN KEY (id_produs) REFERENCES produse(id)
);
/

create table facturi(
  id INT PRIMARY KEY,
  id_angajat INT NOT NULL,
  id_client INT NOT NULL,
  data_factura DATE,
  valoare NUMBER(10,2),
  CONSTRAINT fk_facturi_id_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id) on delete cascade,
  CONSTRAINT fk_facturi_id_client FOREIGN KEY (id_client) REFERENCES clienti(id) on delete cascade
)
/

create table lista_produse(
  id INT PRIMARY KEY,
  id_produs INT NOT NULL,
  id_factura INT NOT NULL,
  CONSTRAINT fk_lista_produse_id_produs FOREIGN KEY (id_produs) REFERENCES produse(id),
  CONSTRAINT fk_lista_produse_id_factura FOREIGN KEY (id_factura) REFERENCES facturi(id)
)
/

CREATE TABLE evidente (
  id INT NOT NULL PRIMARY KEY,
  id_angajat INT,
  data  DATE,
  CONSTRAINT fk_evidente_id_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id)
)
/
CREATE TABLE contracte (
  id INT NOT NULL PRIMARY KEY,
  id_angajat INT,
  data_inceput  DATE,
  data_sfarsit  DATE,
  CONSTRAINT fk_contracte_id_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id) on delete cascade
)
/
CREATE TABLE cheltuieli (
  id INT NOT NULL PRIMARY KEY,
  id_evidenta INT,
  valoare NUMBER(10,2),
  descriere VARCHAR2(30),
  CONSTRAINT fk_cheluieli_id_evidenta FOREIGN KEY (id_evidenta) REFERENCES evidente(id)
)
/
CREATE TABLE venituri (
  id INT NOT NULL PRIMARY KEY,
  id_evidenta INT NOT NULL,
  valoare NUMBER(10,2),
  descriere VARCHAR2(30),
  CONSTRAINT fk_venituri_id_evidenta FOREIGN KEY (id_evidenta) REFERENCES evidente(id)
)
/
