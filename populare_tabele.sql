SET SERVEROUTPUT ON;
DECLARE
 TYPE varr IS VARRAY(1000) OF VARCHAR2(60);
	lista_strazi varr:=varr('Libertatii','Mihai Eminescu','Ion Creanga','Primaverii','Tudor Vladimirescu','Strapungere Silvestru','Fericirii','Zorilor','Trandafirilor','Garii','Stefan cel Mare', 'Victoriei','Pacii','Morii','Cuza Voda','Tineretului','Crinului','Gradinitei','Traian','Izvorului','Muncii','Lalelelor','Rozelor','Viitorului','Sportului','Mihail Sadoveanu','Mihail Kogalniceanu','Narciselor','Morii','Eroilor','Pacii','Decebal','Stejarului','Republicii','Victoriei','Sararie','Bulevard Carol I','Pacurari','Bulevardul Primaverii','Basarabi','Calarasi','Ciric','Ignat');
	lista_brand varr:=varr('Acne Studios', 'Adidas', 'Adidas Original', 'ADISH','ADER Error', 'Akid', 'A Kind Of Guise','Albam', 'Alexander McQueen','Alexander Wang', 'Alpha Industries', 'AMBUSH', 'AMI','Abercombrie and Fitch','Adolescent Clothing','A star is born', 'AllSaints','Amelia Rose','American English','Amuse Society','Amy Lynn','Anatomicals','Anaya with love','And CO','Anmol','Ann Summers','Another Reason','Ardell','Armani Exchange','Ashiana','Ashley Graham','Asics','Asos','b.Young','Barbour','Barneys','Bershka','BillaBong','Blend','Blank NYC','Blink','BOSS','Brave Soul','Brixton','Bronx','Call it String','Calvin Klein','Carhartt WIP','Carvela','Champion','Cheap Monday','Chi Chi','Chorus','Ciate','City Chic','Clset','Club L','COLLUSION','Columbia','Converse','Criminal Damage','Crooked Tongues','Current Air','D-Antidote','Daisy Street','DesignB','Dickies','Diesel','DKNY','Dolce Vita','Dr Denim','Donnay','Dogeared','EastPak','Elegant Touch','ELK','Ellesse','Elliatt','Emory Park','Emporio Armani','Esprit','Essentiel Antwerp','Evidnt','Evil Twin','Eyeko','Faith','Fashion forms','Fashion Union','Fashionkilla','Fila','Fiorelli','Fizz','Finders','Floozie','Flounce London','Foreo','Forever New','Forever Unique','Fred Perry','French Connection','Free People','Free Society','Freya','G Star','Gestuz','ghd','Ghospell','Ghost','Gilly Hicks','Girls On Film','Glomorous','Girls In Mind','Guess','Gossard','H by Hudson','H.One','Happy Jackson','Hazel','Head over Heels','HIIT','Hobie','Helly Hansen','Hollister','Honey Punch','Hope and Ivy','House of Disaster','House of Holland','House of Marley','Hudson','Hugo','Hugo Boss','Hunkemoller','Hunter','Hype','Iceberg','In wear','In Your Dreams','Ivory Rose','Ivy Park','Ivyrevel','J Brand','J Crew','Jack Wills','Jaded London','Jakke','Jayley','JDY','Juice','Jessica Wright','Jonathan Aston','K-Swiss','Kappa','KeepCup','Kendall+Kylie','Kings of Indigo','Kurt Keiger','Lacoste','Lasula','Lazy Days','Lavand','Lazy Oaf','Lee','Levis','Limit','Liquorish','Little Mistress','London Rebel','Liquor N Poker','Lost Ink','Lottie','Loungeable','Love','Love Moschino','Love Triangle','Luxie','Love Rocks','Maison Scotch','Mango','Matt and Nat','Max and Co','Maya','Marc Jacobs','Mi-PAC','Michael Kors','Milk It','MinkPink','Miss Sixty','Miss KG','Missguided','Miss Selfridge','Monki','Moon River','Moss Copenhagen','Motel','NA-KD','Neon Rose','New Balance','New Era','Native Youth','New Look','New Girl Order','Nike','Nobodys Child','Noisy May','Nylon','Oasis','Obey','Office','Oh My Love','One Teaspoon','Only','Oysho','Paladone','Park Lane','Parka London','Paul and Joe','Paul Smith','Pengield','People Tree','Pilgrim','Pieces','Pepe Jeans','Pieces','Pilgrim','Polo Ralph Lauren', 'PullandBear','Puma','Reclaimed Vintage','Resume','Reebok','River Island','Roxy','RVCA','Selected Femme','Seekers','Stradivarius','Superdry','Stylenanda','Superga','Ted Baker','TFNC','Ted Baker','The North Face','The Ragged Priest','Tommy Hilfiger','Tommy Jeans','Timberland','Forever 21','Urban Bliss','Uncivilised','UrbanCode','Vans','Vila','Vero moda','Warehouse','Wednesdays Girl','Wrangler','Y.A.S');
	lista_culori varr:=varr('albastru','alb','negru','galben','roz','rosu','portocaliu','roz neon','verde','verde neon','turcoaz','kaki','burgund','Crem','Alb murdar','Gri','Lavanda','Mov','Maro');
	lista_model varr:=varr('in dungi','cu imprimeu floral','polo','basic','cu decolteu in v','cu guler rotund','cu buline','imprimeu leopard','cu maneci lungi','cu maneci 3/4','cu maneci scurte','veste','oversized','in carouri','cropped');
	lista_categorii_topuri varr:=varr('tricou','bluza','hanorac cu gluga','hanorac fara gluga','camasa','vesta','geaca','jacheta','sacou','top');
	lista_categorii_bottom varr:=varr('pantaloni costum','colanti','jeans','pantalogi jogging','pantaloni imitatie piele','pantaloni scurti','fusta midi','fusta maxi','fusta mini','rochie mini','rochie maxi','rochie midi');

	lista_nume varr := varr('Ababei','Acasandrei','Adascalitei','Afanasie','Agafitei','Agape','Aioanei','Alexandrescu','Alexandru','Alexe','Alexii','Amarghioalei','Ambroci','Andonesei','Andrei','Andrian','Andrici','Andronic','Andros','Anghelina','Anita','Antochi','Antonie','Apetrei','Apostol','Arhip','Arhire','Arteni','Arvinte','Asaftei','Asofiei','Aungurenci','Avadanei','Avram','Babei','Baciu','Baetu','Balan','Balica','Banu','Barbieru','Barzu','Bazgan','Bejan','Bejenaru','Belcescu','Belciuganu','Benchea','Bilan','Birsanu','Bivol','Bizu','Boca','Bodnar','Boistean','Borcan','Bordeianu','Botezatu','Bradea','Braescu','Budaca','Bulai','Bulbuc-aioanei','Burlacu','Burloiu','Bursuc','Butacu','Bute','Buza','Calancea','Calinescu','Capusneanu','Caraiman','Carbune','Carp','Catana','Catiru','Catonoiu','Cazacu','Cazamir','Cebere','Cehan','Cernescu','Chelaru','Chelmu','Chelmus','Chibici','Chicos','Chilaboc','Chile','Chiriac','Chirila','Chistol','Chitic','Chmilevski','Cimpoesu','Ciobanu','Ciobotaru','Ciocoiu','Ciofu','Ciornei','Citea','Ciucanu','Clatinici','Clim','Cobuz','Coca','Cojocariu','Cojocaru','Condurache','Corciu','Corduneanu','Corfu','Corneanu','Corodescu','Coseru','Cosnita','Costan','Covatariu','Cozma','Cozmiuc','Craciunas','Crainiceanu','Creanga','Cretu','Cristea','Crucerescu','Cumpata','Curca','Cusmuliuc','Damian','Damoc','Daneliuc','Daniel','Danila','Darie','Dascalescu','Dascalu','Diaconu','Dima','Dimache','Dinu','Dobos','Dochitei','Dochitoiu','Dodan','Dogaru','Domnaru','Dorneanu','Dragan','Dragoman','Dragomir','Dragomirescu','Duceac','Dudau','Durnea','Edu','Eduard','Eusebiu','Fedeles','Ferestraoaru','Filibiu','Filimon','Filip','Florescu','Folvaiter','Frumosu','Frunza','Galatanu','Gavrilita','Gavriliuc','Gavrilovici','Gherase','Gherca','Ghergu','Gherman','Ghibirdic','Giosanu','Gitlan','Giurgila','Glodeanu','Goldan','Gorgan','Grama','Grigore','Grigoriu','Grosu','Grozavu','Gurau','Haba','Harabula','Hardon','Harpa','Herdes','Herscovici','Hociung','Hodoreanu','Hostiuc','Huma','Hutanu','Huzum','Iacob','Iacobuta','Iancu','Ichim','Iftimesei','Ilie','Insuratelu','Ionesei','Ionesi','Ionita','Iordache','Iordache-tiroiu','Iordan','Iosub','Iovu','Irimia','Ivascu','Jecu','Jitariuc','Jitca','Joldescu','Juravle','Larion','Lates','Latu','Lazar','Leleu','Leon','Leonte','Leuciuc','Leustean','Luca','Lucaci','Lucasi','Luncasu','Lungeanu','Lungu','Lupascu','Lupu','Macariu','Macoveschi','Maftei','Maganu','Mangalagiu','Manolache','Manole','Marcu','Marinov','Martinas','Marton','Mataca','Matcovici','Matei','Maties','Matrana','Maxim','Mazareanu','Mazilu','Mazur','Melniciuc-puica','Micu','Mihaela','Mihai','Mihaila','Mihailescu','Mihalachi','Mihalcea','Mihociu','Milut','Minea','Minghel','Minuti','Miron','Mitan','Moisa','Moniry-abyaneh','Morarescu','Morosanu','Moscu','Motrescu','Motroi','Munteanu','Murarasu','Musca','Mutescu','Nastaca','Nechita','Neghina','Negrus','Negruser','Negrutu','Nemtoc','Netedu','Nica','Nicu','Oana','Olanuta','Olarasu','Olariu','Olaru','Onu','Opariuc','Oprea','Ostafe','Otrocol','Palihovici','Pantiru','Pantiruc','Paparuz','Pascaru','Patachi','Patras','Patriche','Perciun','Perju','Petcu','Pila','Pintilie','Piriu','Platon','Plugariu','Podaru','Poenariu','Pojar','Popa','Popescu','Popovici','Poputoaia','Postolache','Predoaia','Prisecaru','Procop','Prodan','Puiu','Purice','Rachieru','Razvan','Reut','Riscanu','Riza','Robu','Roman','Romanescu','Romaniuc','Rosca','Rusu','Samson','Sandu','Sandulache','Sava','Savescu','Schifirnet','Scortanu','Scurtu','Sfarghiu','Silitra','Simiganoschi','Simion','Simionescu','Simionesei','Simon','Sitaru','Sleghel','Sofian','Soficu','Sparhat','Spiridon','Stan','Stavarache','Stefan','Stefanita','Stingaciu','Stiufliuc','Stoian','Stoica','Stoleru','Stolniceanu','Stolnicu','Strainu','Strimtu','Suhani','Tabusca','Talif','Tanasa','Teclici','Teodorescu','Tesu','Tifrea','Timofte','Tincu','Tirpescu','Toader','Tofan','Toma','Toncu','Trifan','Tudosa','Tudose','Tuduri','Tuiu','Turcu','Ulinici','Unghianu','Ungureanu','Ursache','Ursachi','Urse','Ursu','Varlan','Varteniuc','Varvaroi','Vasilache','Vasiliu','Ventaniuc','Vicol','Vidru','Vinatoru','Vlad','Voaides','Vrabie','Vulpescu','Zamosteanu','Zazuleac');
	lista_prenume varr := varr( 'Adina','Alexandra','Alina','Ana','Anca','Anda','Andra','Andreea','Andreia','Antonia','Bianca','Camelia','Claudia','Codrina','Cristina','Daniela','Daria','Delia','Denisa','Diana','Ecaterina','Elena','Eleonora','Elisa','Ema','Emanuela','Emma','Gabriela','Georgiana','Ileana','Ilona','Ioana','Iolanda','Irina','Iulia','Iuliana','Larisa','Laura','Loredana','Madalina','Malina','Manuela','Maria','Mihaela','Mirela','Monica','Oana','Paula','Petruta','Raluca','Sabina','Sanziana','Simina','Simona','Stefana','Stefania','Tamara','Teodora','Theodora','Vasilica','Xena', 'Adrian','Alex','Alexandru','Alin','Andreas','Andrei','Aurelian','Beniamin','Bogdan','Camil','Catalin','Cezar','Ciprian','Claudiu','Codrin','Constantin','Corneliu','Cosmin','Costel','Cristian','Damian','Dan','Daniel','Danut','Darius','Denise','Dimitrie','Dorian','Dorin','Dragos','Dumitru','Eduard','Elvis','Emil','Ervin','Eugen','Eusebiu','Fabian','Filip','Florian','Florin','Gabriel','George','Gheorghe','Giani','Giulio','Iaroslav','Ilie','Ioan','Ion','Ionel','Ionut','Iosif','Irinel','Iulian','Iustin','Laurentiu','Liviu','Lucian','Marian','Marius','Matei','Mihai','Mihail','Nicolae','Nicu','Nicusor','Octavian','Ovidiu','Paul','Petru','Petrut','Radu','Rares','Razvan','Richard','Robert','Roland','Rolland','Romanescu','Sabin','Samuel','Sebastian','Sergiu','Silviu','Stefan','Teodor','Teofil','Theodor','Tudor','Vadim','Valentin','Valeriu','Vasile','Victor','Vlad','Vladimir','Vladut');
	lista_functii varr := varr('Manager','Contabil', 'Vanzator', 'Agent-paza', 'Casier', 'Sef-raion', 'Sef-magazin','Asistent-sef-magazin','Sef-depozit','Asistent-sef-depozit','Sef-tura', 'Asistent-vanzari','Gestionar-magazin' );
	
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
	v_iterator number;

	--pentru tabela angajati si clienti
	v_nume VARCHAR2(30);
	v_prenume varchar2(30);
	v_functie varchar2(40);

	v_my_number_prenume number;
	v_my_number_nume number;
	v_my_number_functie number;

	v_verific_id_pers number;
	v_id_pers number := 1;
	v_id_clienti number := 1;

	v_data_angajare date;
	v_data_inregistrare date;


	v_salariu number;

	v_nr_angajati1 INT;
	v_nr_angajati2 INT;
	v_id_magazin1 INT;

	--pentru tabela evidente
	CURSOR lista_contabili IS SELECT id FROM angajati where functie='Contabil';
	v_id_evidenta INT;
	v_data_contabil DATE;

	---pentru tabela contracte
	CURSOR lista_manageri IS SELECT id FROM angajati where functie='Manager';
	v_id_contract INT;
	v_data_inceput DATE;
	v_data_sfarsit DATE;

	--pentru tabela cheltuieli
	v_nr_inregistrari INT;
	v_id_cheltuieli INT;
	v_valoare_cheltuieli NUMBER(10,2);
	v_descriere_cheltuieli VARCHAR2(30);
	lista_cheltuieli varr:=varr('salarii','chirie','impozite','taxe','materiale','intretinere');

	--pentru tabela venituri
	v_nr_inregistrari2 INT;
	v_id_venituri INT;
	v_valoare_venituri NUMBER(10,2);
	v_descriere_venituri VARCHAR2(30);
	
	--pentru tabela facturi
	cursor lista_angajati_vanzatori is select id, functie from angajati where functie='Vanzator';
	v_facturi_client INT;
	v_data_factura DATE;
	v_valoare_factura NUMBER(10,2);
	v_NrFacturi INT;
	v_count1 INT;
	v_count2 INT;

	--pentru tabela lista_produse
	V_RANDOM INT;
	v_id_produsF INT;
	v_countFacturi INT;
	v_verific INT := 0;
	
BEGIN

  --MAGAZINE
  FOR v_i in 1..100 LOOP
    --adresa
     v_strada:=lista_strazi(TRUNC(DBMS_RANDOM.VALUE(0,lista_strazi.count))+1);
     v_numar_strada:=ROUND(DBMS_RANDOM.VALUE(1,1000))+1;
     v_adresa:='Str. '||v_strada||' nr. '||v_numar_strada;
  
     --telefon
     v_telefon:='07'||ROUND(DBMS_RANDOM.VALUE(100,999))||ROUND(DBMS_RANDOM.VALUE(100,999))||ROUND(DBMS_RANDOM.VALUE(10,99));
  
     --numar angajati
     v_nr_angajati:=ROUND(DBMS_RANDOM.VALUE(1000,3000));
     INSERT INTO magazine VALUES(v_i,v_adresa,v_telefon,v_nr_angajati);
  END LOOP;

  --PRODUSE
  FOR v_j in 1..300000 LOOP
      ---categorie+model
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN
         v_categorie:=lista_categorii_topuri(TRUNC(DBMS_RANDOM.VALUE(0,lista_categorii_topuri.count))+1);
         v_model:=lista_model(TRUNC(DBMS_RANDOM.VALUE(0,lista_model.count))+1);
      ELSE
         v_categorie:=lista_categorii_bottom(TRUNC(DBMS_RANDOM.VALUE(0,lista_categorii_bottom.count))+1);
         v_model:=NULL;
      END IF;

      ---culoare
        v_culoare:=lista_culori(TRUNC(DBMS_RANDOM.VALUE(0,lista_culori.count))+1);

        ---denumire
        v_denumire:=v_categorie||' '||lista_brand(TRUNC(DBMS_RANDOM.VALUE(0,lista_brand.count))+1);
        ---pret
        v_pret:=TRUNC(DBMS_RANDOM.VALUE(10,1000),2);
        INSERT INTO produse VALUES (v_j,v_categorie,v_denumire,v_model,v_culoare,v_pret);
  END LOOP;


   --STOCURI MAGAZIN
  v_count:=1;
  FOR v_i in 1..100 LOOP
    FOR v_j in 1..2000 LOOP
      --marimi
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


  --ANGAJATI
  for v_iterator_magazine in 1..100 loop
      select nr_angajati, id into v_nr_angajati2, v_id_magazin1 from magazine where id=v_iterator_magazine;
      for v_iterator in 1..v_nr_angajati2  loop
        --nume
         v_my_number_nume := TRUNC(DBMS_RANDOM.VALUE( 1, lista_nume.count));
         v_nume := lista_nume(v_my_number_nume);

         --prenume
         v_my_number_prenume := TRUNC(DBMS_RANDOM.VALUE( 1, lista_prenume.count));
         v_prenume := lista_prenume(v_my_number_prenume);

         --id
         select count(*) into v_verific_id_pers from (select * from angajati WHERE id = v_id_pers);
         while (v_verific_id_pers > 0) loop
              v_id_pers := v_id_pers + 1;
              select count(*) into v_verific_id_pers from (select * from angajati WHERE id = v_id_pers);
         end loop;


         --functie
         v_my_number_functie := TRUNC(DBMS_RANDOM.VALUE( 1, lista_functii.count));
         v_functie := lista_functii(v_my_number_functie);

         --salariu
         if(v_functie = 'Manager' or v_functie = 'Contabil') then
            v_salariu := FLOOR(DBMS_RANDOM.VALUE(50,99)) || FLOOR(DBMS_RANDOM.VALUE(0,9)) || FLOOR(DBMS_RANDOM.VALUE(0,9)) ;
         else
            v_salariu := FLOOR(DBMS_RANDOM.VALUE(10,49)) || FLOOR(DBMS_RANDOM.VALUE(0,9)) || FLOOR(DBMS_RANDOM.VALUE(0,9)) ;
         end if;

         --data_angajare
         v_data_angajare := (sysdate-TRUNC(DBMS_RANDOM.VALUE(0,1000)));

         insert into angajati (id, id_magazin, nume, prenume,salariu, functie,data_angajare) values ( v_id_pers, v_id_magazin1, v_nume, v_prenume,v_salariu, v_functie, v_data_angajare);

      end loop;
  end loop;



   --CLIENTI
   for v_iterator in 1..300000 loop
      --nume
       v_my_number_nume := TRUNC(DBMS_RANDOM.VALUE( 1, lista_nume.count));
       v_nume := lista_nume(v_my_number_nume);

       --prenume
       v_my_number_prenume := TRUNC(DBMS_RANDOM.VALUE( 1, lista_prenume.count));
       v_prenume := lista_prenume(v_my_number_prenume);

       --id
       select count(*) into v_verific_id_pers from (select * from clienti WHERE id = v_id_clienti);
       while (v_verific_id_pers > 0) loop
            v_id_clienti := v_id_clienti + 1;
            select count(*) into v_verific_id_pers from (select * from clienti WHERE id = v_id_clienti);
       end loop;


       --data_inregistrare
       v_data_inregistrare := (sysdate-TRUNC(DBMS_RANDOM.VALUE(0,500)));


       insert into clienti (id, nume, prenume, data_inregistrare) values ( v_id_clienti, v_nume, v_prenume, v_data_inregistrare);
   end loop;


  --EVIDENTE
  v_id_evidenta:=1;
   FOR v_id_contabil in lista_contabili LOOP
      FOR v_i in 1..10 LOOP
        --data random
        v_data_contabil:=SYSDATE + (365 * 2 * DBMS_RANDOM.VALUE(0,1) - 365);
        INSERT INTO evidente VALUES(v_id_evidenta,v_id_contabil.id,v_data_contabil);
        --id_evidenta
        v_id_evidenta:=v_id_evidenta+1;
      END LOOP;
    END LOOP;

  --CONTRACTE
  v_id_contract:=1;
  FOR v_id_manager in lista_manageri LOOP
    FOR v_i in 1..10 LOOP
        --data random
        v_data_inceput:=SYSDATE + (365 * 2 * DBMS_RANDOM.VALUE(0,1) - 365);
        v_data_sfarsit:=v_data_inceput+(365 * 2 * DBMS_RANDOM.VALUE(1,2));
        INSERT INTO contracte VALUES(v_id_contract,v_id_manager.id,v_data_inceput,v_data_sfarsit);
        --v_id_contract
        v_id_contract:=v_id_contract+1;
    END LOOP;
  END LOOP;
     
     
  --CHELTUIELI
  select count(id) INTO v_nr_inregistrari from evidente;
  v_id_cheltuieli:=1;
  FOR v_i in 1..v_nr_inregistrari LOOP
    FOR v_j in 1..3 LOOP
        v_valoare_cheltuieli:=TRUNC(DBMS_RANDOM.VALUE(1000,100000),2);
        v_descriere_cheltuieli:=lista_cheltuieli(TRUNC(DBMS_RANDOM.VALUE(0,lista_cheltuieli.count))+1);
        INSERT INTO cheltuieli VALUES(v_id_cheltuieli,v_i,v_valoare_cheltuieli,v_descriere_cheltuieli);
        v_id_cheltuieli:=v_id_cheltuieli+1;
    END LOOP;
  END LOOP;
     
     
  --VENITURI
  select count(id) INTO v_nr_inregistrari2 from evidente;
  v_descriere_venituri:='vanzari';
  v_id_venituri:=1;
  FOR v_i in 1..v_nr_inregistrari2 LOOP
    FOR v_j in 1..3 LOOP
        v_valoare_venituri:=TRUNC(DBMS_RANDOM.VALUE(1000,100000),2);
        INSERT INTO venituri VALUES(v_id_venituri,v_i,v_valoare_venituri,v_descriere_venituri);
        v_id_venituri:=v_id_venituri+1;
    END LOOP;
  END LOOP;


  --FACTURI
  --id_angajat
  v_count1 := 1;
  for v_std_linie in lista_angajati_vanzatori loop
    v_NrFacturi := DBMS_RANDOM.VALUE(0,50);
    for v_iterator1 in 1..v_NrFacturi loop
        --id_client
        v_facturi_client := DBMS_RANDOM.VALUE(1,300000);
       
        --data_factura
        v_data_factura := (sysdate-TRUNC(DBMS_RANDOM.VALUE(0,500)));
    
        --valoare
        v_valoare_factura := TRUNC(DBMS_RANDOM.VALUE(10,10000),2);
        
        insert into facturi (id, id_angajat , id_client , data_factura , valoare) values ( v_count1, v_std_linie.id, v_facturi_client, v_data_factura, v_valoare_factura);    
        v_count1 := v_count1+1;
    end loop;
  end loop;
  
  --LISTA PRODUSE
  v_count2 := 1;
  select count(id)/2 into v_countFacturi from facturi;
  for v_iterator in 1..v_countFacturi loop
    v_random := ROUND(DBMS_RANDOM.VALUE(1,10)); --nr produse pe o factura
    for v_iterator1 in 1..v_random loop
        v_id_produsF := ROUND(DBMS_RANDOM.VALUE(1,300000));
        insert into lista_produse (id, id_factura, id_produs) values (v_count2, v_iterator, v_id_produsF);
        v_count2 := v_count2+1;
    end loop;
  end loop;
  
	  DBMS_OUTPUT.PUT_LINE('Inserare tabele: succes!');
END;
