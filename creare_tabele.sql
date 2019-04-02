
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
DROP TABLE angajati_magazin CASCADE CONSTRAINTS
/
DROP TABLE evidente CASCADE CONSTRAINTS
/
DROP TABLE contracte CASCADE CONSTRAINTS
/
DROP TABLE cheltuieli CASCADE CONSTRAINTS
/
DROP TABLE venituri CASCADE CONSTRAINTS
/
DROP TABLE contabili CASCADE CONSTRAINTS
/
DROP TABLE manageri CASCADE CONSTRAINTS
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
  nume VARCHAR2(15) NOT NULL,
  prenume VARCHAR2(30) NOT NULL,
  salariu NUMBER(10,2),
  functie VARCHAR2(20),
  data_angajare DATE
)
/
CREATE TABLE angajati_magazin(
  id INT PRIMARY KEY,
  id_magazin INT NOT NULL,
  id_angajat INT NOT NULL,
  CONSTRAINT fk_angajati_magazin_id_magazin FOREIGN KEY (id_magazin) REFERENCES magazine(id),
  CONSTRAINT fk_angajati_magazin_id_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id)
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
  data_factura DATE,
  valoare NUMBER(10,2)
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
  data  DATE
)
/
CREATE TABLE contracte (
  id INT NOT NULL PRIMARY KEY,
  data_inceput  DATE,
  data_sfarsit  DATE
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
CREATE TABLE contabili(
  id INT NOT NULL PRIMARY KEY,
  id_angajat INT,
  id_evidenta INT,
  CONSTRAINT fk_contabili_id_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id),
  CONSTRAINT fk_contabili_id_evidenta FOREIGN KEY (id_evidenta) REFERENCES evidente(id)
)
/
CREATE TABLE manageri(
  id INT NOT NULL PRIMARY KEY,
  id_angajat INT,
  id_contract INT,
  CONSTRAINT fk_managerii_id_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id),
  CONSTRAINT fk_manageri_id_contract FOREIGN KEY (id_contract) REFERENCES contracte(id)
)
/
DROP TABLE facturi_angajati CASCADE CONSTRAINTS
/
CREATE TABLE facturi_angajati(
  id INT PRIMARY KEY,
  id_factura INT NOT null,
  id_angajat INT NOT null,
  CONSTRAINT fk_facturi_angajati_id_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id),
  CONSTRAINT fk_facturi_angajati_id_factura FOREIGN KEY (id_factura) REFERENCES facturi(id)
)
/
DROP TABLE facturi_clienti CASCADE CONSTRAINTS
/
CREATE TABLE facturi_clienti(
  id INT PRIMARY KEY,
  id_factura INT NOT null ,
  id_client INT NOT null,
  CONSTRAINT fk_facturi_clienti_id_client FOREIGN KEY (id_client) REFERENCES clienti(id),
  CONSTRAINT fk_facturi_clienti_id_factura FOREIGN KEY (id_factura) REFERENCES facturi(id)
)
/
