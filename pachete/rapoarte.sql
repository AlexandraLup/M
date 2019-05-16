

create or replace package rapoarte as
	function raport_cheltuieli( p_descriere in cheltuieli.descriere%type, p_data_inceput in evidente.data%type, p_data_sfarsit in evidente.data%type) return varchar2;
   	function raport_venituri( p_data_inceput in evidente.data%type, p_data_sfarsit in evidente.data%type) return varchar2;
    function raport_contracte_expirate(p_id_magazin magazine.id%type, p_data_cautare contracte.data_sfarsit%type) return varchar2;
end;
/
create or replace package body rapoarte as

	descriere_inexistenta exception;
	PRAGMA EXCEPTION_INIT(descriere_inexistenta, -20001);
	
	data_inexistenta exception;
	PRAGMA EXCEPTION_INIT(data_inexistenta, -20002);



	function raport_cheltuieli( p_descriere in cheltuieli.descriere%type, p_data_inceput in evidente.data%type, p_data_sfarsit in evidente.data%type) return varchar2 as
    
	cursor report_c is select a.nume, a.prenume ,c.valoare, c.descriere, e.data from cheltuieli c join evidente e 
	on e.id=c.id_evidenta join angajati a on a.id=e.ID_ANGAJAT where c.descriere=p_descriere
	and e.data BETWEEN p_data_inceput and p_data_sfarsit;
	
    v_exception_c number := 0;
	v_exception_d number := 0;
	
	v_fisier UTL_FILE.FILE_TYPE;
	
  begin
	v_fisier:=UTL_FILE.FOPEN('EXPORT','raportCheltuieli.csv','W');
  
    select count(*) into v_exception_c from (select id from cheltuieli where descriere = p_descriere);
    select count(*) into v_exception_d from evidente where data BETWEEN p_data_inceput and p_data_sfarsit;
	
    if(v_exception_c = 0) then
      raise descriere_inexistenta;
    elsif (v_exception_d = 0) then 
		raise data_inexistenta;
	else
	   
	    FOR v_std_linie IN report_c LOOP     
			UTL_FILE.PUTF(v_fisier, v_std_linie.nume || ',' || v_std_linie.prenume || ',' || v_std_linie.valoare|| ',' || v_std_linie.descriere ||','|| v_std_linie.data|| '\n');
		END LOOP;
	
		UTL_FILE.FCLOSE(v_fisier);
		return 'Success';
	
    end if;
	
	
    exception
      when descriere_inexistenta then
        return 'Descriere incorecta!';
	when data_inexistenta then
        return 'Nu exista rapoarte in perioada aleasa';
      when others then
        return 'Unknown exception';
  end;
  
  
  
  
  
	function raport_venituri( p_data_inceput in evidente.data%type, p_data_sfarsit in evidente.data%type) return varchar2 as
    
	cursor report_c is select a.nume, a.prenume ,v.valoare, v.descriere, e.data from venituri v join evidente e 
	on e.id=v.id_evidenta join angajati a on a.id=e.ID_ANGAJAT where e.data BETWEEN p_data_inceput and p_data_sfarsit;
	
	v_exception_d number := 0;
	
	v_fisier UTL_FILE.FILE_TYPE;
	
  begin
	v_fisier:=UTL_FILE.FOPEN('EXPORT','raportVenituri.csv','W');
  
    select count(*) into v_exception_d from evidente where data BETWEEN p_data_inceput and p_data_sfarsit;
	
    if (v_exception_d = 0) then 
		raise data_inexistenta;
	else
	   
	    FOR v_std_linie IN report_c LOOP     
			UTL_FILE.PUTF(v_fisier, v_std_linie.nume || ',' || v_std_linie.prenume || ',' || v_std_linie.valoare|| ',' || v_std_linie.descriere ||','|| v_std_linie.data|| '\n');
		END LOOP;
	
		UTL_FILE.FCLOSE(v_fisier);
		return 'Success';
	
    end if;
	
	
    exception
      when descriere_inexistenta then
        return 'Descriere incorecta!';
	when data_inexistenta then
        return 'Nu exista rapoarte in perioada aleasa';
      when others then
        return 'Unknown exception';
  end;
  
  
  
  function raport_contracte_expirate(p_id_magazin magazine.id%type, p_data_cautare contracte.data_sfarsit%type) return varchar2 as
    
	cursor report_contracte is  select a.id, a.nume, a.prenume ,c.data_inceput, c.data_sfarsit from contracte c join angajati a on a.id=c.id_angajat where c.data_sfarsit<=p_data_cautare;
  
	
	v_exception_d number := 0;
	
	v_fisier UTL_FILE.FILE_TYPE;
	
  begin
	v_fisier:=UTL_FILE.FOPEN('EXPORT','raportContracteExpirate.csv','W');
  
    select count(*) into v_exception_d from contracte where data_sfarsit<=p_data_cautare;
	
    if (v_exception_d = 0) then 
		raise data_inexistenta;
	else
	   
	    FOR v_std_linie IN report_contracte LOOP     
			UTL_FILE.PUTF(v_fisier, v_std_linie.id || ',' || v_std_linie.nume || ',' || v_std_linie.data_inceput|| ',' || v_std_linie.data_sfarsit || '\n');
		END LOOP;
	
		UTL_FILE.FCLOSE(v_fisier);
		return 'Success';
	
    end if;
	
	
    exception
	when data_inexistenta then
        return 'Nu exista contracte expirate pana la data aleasa';
      when others then
        return 'Unknown exception';
    end;
  
end rapoarte;
  
  
  