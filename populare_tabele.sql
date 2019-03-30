SET SERVEROUTPUT ON;
DECLARE
 TYPE varr IS VARRAY(1000) OF VARCHAR2(60);
 lista_strazi varr:=
varr('Libertatii','Mihai Eminescu','Ion Creanga','Primaverii','Tudor Vladimirescu','Strapungere Silvestru','Fericirii','Zorilor','Trandafirilor',
'Garii','Stefan cel Mare', 'Victoriei','Pacii','Morii','Cuza Voda','Tineretului','Crinului','Gradinitei','Traian','Izvorului','Muncii','Lalelelor','Rozelor',
'Viitorului','Sportului','Mihail Sadoveanu','Mihail Kogalniceanu','Narciselor','Morii','Eroilor','Pacii','Decebal','Stejarului','Republicii','Victoriei',
'Sararie','Bulevard Carol I','Pacurari','Bulevardul Primaverii','Basarabi','Calarasi','Ciric','Ignat');
lista_brand varr:=
varr('Acne Studios', 'Adidas', 'Adidas Original', 'ADISH',
'ADER Error', 'Akid', 'A Kind Of Guise','Albam', 'Alexander McQueen',
'Alexander Wang', 'Alpha Industries', 'AMBUSH', 'AMI','Abercombrie and Fitch',
'Adolescent Clothing','A star is born', 'AllSaints','Amelia Rose',
 'American English','Amuse Society','Amy Lynn','Anatomicals','Anaya with love',
'And CO','Anmol','Ann Summers','Another Reason','Ardell','Armani Exchange',
'Ashiana','Ashley Graham','Asics','Asos','b.Young','Barbour','Barneys',
'Bershka','BillaBong','Blend','Blank NYC','Blink','BOSS','Brave Soul',
'Brixton','Bronx','Call it String','Calvin Klein','Carhartt WIP','Carvela',
'Champion','Cheap Monday','Chi Chi','Chorus','Ciate','City Chic','Clset',
'Club L','COLLUSION','Columbia','Converse','Criminal Damage','Crooked Tongues',
'Current Air','D-Antidote','Daisy Street','DesignB','Dickies','Diesel','DKNY',
'Dolce Vita','Dr Denim','Donnay','Dogeared','EastPak','Elegant Touch','ELK',
'Ellesse','Elliatt','Emory Park','Emporio Armani','Esprit','Essentiel Antwerp',
'Evidnt','Evil Twin','Eyeko','Faith','Fashion forms','Fashion Union',
'Fashionkilla','Fila','Fiorelli','Fizz','Finders','Floozie','Flounce London',
'Foreo','Forever New','Forever Unique','Fred Perry','French Connection','Free People',
'Free Society','Freya','G Star','Gestuz','ghd','Ghospell','Ghost','Gilly Hicks',
'Girls On Film','Glomorous','Girls In Mind','Guess','Gossard','H by Hudson',
'H.One','Happy Jackson','Hazel','Head over Heels','HIIT','Hobie','Helly Hansen',
'Hollister','Honey Punch','Hope and Ivy','House of Disaster','House of Holland',
'House of Marley','Hudson','Hugo','Hugo Boss','Hunkemoller','Hunter','Hype',
'Iceberg','In wear','In Your Dreams','Ivory Rose','Ivy Park','Ivyrevel',
'J Brand','J Crew','Jack Wills','Jaded London','Jakke','Jayley','JDY','Juice',
'Jessica Wright','Jonathan Aston','K-Swiss','Kappa','KeepCup','Kendall+Kylie',
'Kings of Indigo','Kurt Keiger','Lacoste','Lasula','Lazy Days','Lavand',
'Lazy Oaf','Lee','Levis','Limit','Liquorish','Little Mistress',
'London Rebel','Liquor N Poker','Lost Ink','Lottie','Loungeable','Love','Love Moschino',
'Love Triangle','Luxie','Love Rocks','Maison Scotch','Mango','Matt and Nat','Max and Co',
'Maya','Marc Jacobs','Mi-PAC','Michael Kors','Milk It','MinkPink','Miss Sixty',
'Miss KG','Missguided','Miss Selfridge','Monki','Moon River','Moss Copenhagen',
'Motel','NA-KD','Neon Rose','New Balance','New Era','Native Youth',
'New Look','New Girl Order','Nike','Nobodys Child','Noisy May','Nylon',
'Oasis','Obey','Office','Oh My Love','One Teaspoon','Only','Oysho','Paladone','Park Lane',
'Parka London','Paul and Joe','Paul Smith','Pengield','People Tree','Pilgrim','Pieces','Pepe Jeans',
'Pieces','Pilgrim','Polo Ralph Lauren', 'PullandBear','Puma','Reclaimed Vintage','Resume',
'Reebok','River Island','Roxy','RVCA','Selected Femme','Seekers','Stradivarius','Superdry','Stylenanda','Superga',
'Ted Baker','TFNC','Ted Baker','The North Face','The Ragged Priest','Tommy Hilfiger','Tommy Jeans',
'Timberland','Forever 21','Urban Bliss','Uncivilised','UrbanCode','Vans','Vila','Vero moda','Warehouse',
'Wednesdays Girl','Wrangler','Y.A.S');
lista_culori varr:=
varr('albastru','alb','negru','galben','roz','rosu','portocaliu','roz neon','verde','verde neon','turcoaz',
'kaki','burgund','Crem','Alb murdar','Gri','Lavanda','Mov','Maro');
lista_model varr:=
varr('in dungi','cu imprimeu floral','polo','basic','cu decolteu in v','cu guler rotund','cu buline','imprimeu leopard','cu maneci lungi',
'cu maneci 3/4','cu maneci scurte','veste','oversized','in carouri','cropped');
lista_categorii_topuri varr:=
varr('tricou','bluza','hanorac cu gluga','hanorac fara gluga','camasa','vesta','geaca','jacheta','sacou','top');
lista_categorii_bottom varr:=
varr('pantaloni costum','colanti','jeans','pantalogi jogging','pantaloni imitatie piele','pantaloni scurti','fusta midi','fusta maxi'
,'fusta mini','rochie mini','rochie maxi','rochie midi');
v_strada VARCHAR2(60);
v_adresa VARCHAR2(100);
v_numar_strada INT;
v_telefon VARCHAR2(11);
v_nr_angajati INT;
v_categorie VARCHAR2(30);
v_model VARCHAR2(30);
v_denumire VARCHAR2(100);
v_culoare VARCHAR2(30);
v_id_magazin INT;
v_pret NUMBER(10,2);
v_count INT;
v_xs INT;
v_s INT;
v_m INT;
v_l INT;
v_xl INT;
v_id_produs INT;
BEGIN
FOR v_i in 1..100 LOOP
   v_strada:=lista_strazi(TRUNC(DBMS_RANDOM.VALUE(0,lista_strazi.count))+1);
   v_numar_strada:=ROUND(DBMS_RANDOM.VALUE(1,1000))+1;
   v_adresa:='Str. '||v_strada||' nr. '||v_numar_strada;
   v_telefon:='07'||ROUND(DBMS_RANDOM.VALUE(100,999))||ROUND(DBMS_RANDOM.VALUE(100,999))||ROUND(DBMS_RANDOM.VALUE(10,99));
   v_nr_angajati:=ROUND(DBMS_RANDOM.VALUE(1000,3000));
   INSERT INTO magazine VALUES(v_i,v_adresa,v_telefon,v_nr_angajati);
END LOOP;
FOR v_j in 1..300000 LOOP
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN
         v_categorie:=lista_categorii_topuri(TRUNC(DBMS_RANDOM.VALUE(0,lista_categorii_topuri.count))+1);
         v_model:=lista_model(TRUNC(DBMS_RANDOM.VALUE(0,lista_model.count))+1);
      ELSE
         v_categorie:=lista_categorii_bottom(TRUNC(DBMS_RANDOM.VALUE(0,lista_categorii_bottom.count))+1);
         v_culoare:=lista_culori(TRUNC(DBMS_RANDOM.VALUE(0,lista_culori.count))+1);
         v_model:=NULL;
      END IF;
        v_culoare:=lista_culori(TRUNC(DBMS_RANDOM.VALUE(0,lista_culori.count))+1);
        v_denumire:=v_categorie||' '||lista_brand(TRUNC(DBMS_RANDOM.VALUE(0,lista_brand.count))+1);
        v_pret:=TRUNC(DBMS_RANDOM.VALUE(10,1000),2);
        INSERT INTO produse VALUES (v_j,v_categorie,v_denumire,v_model,v_culoare,v_pret);
END LOOP;
v_count:=1;
FOR v_i in 1..100 LOOP
 FOR v_j in 1..2000 LOOP
  v_xs:=ROUND(DBMS_RANDOM.VALUE(1,1000))+1;
    v_s:=ROUND(DBMS_RANDOM.VALUE(1,1000))+1;
      v_m:=ROUND(DBMS_RANDOM.VALUE(1,1000))+1;
        v_l:=ROUND(DBMS_RANDOM.VALUE(1,1000))+1;
          v_xl:=ROUND(DBMS_RANDOM.VALUE(1,1000))+1;
          v_id_produs:=ROUND(DBMS_RANDOM.VALUE(1,300000));
          INSERT INTO stocuri_magazin VALUES(v_count,v_i,v_id_produs,v_xs,v_s,v_m,v_l,v_xl);
          v_count:=v_count+1;
 END LOOP;
END LOOP;
END;
