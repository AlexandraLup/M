-- package destinat mnagementului angajatilor
create or replace package operatii_angajati as
  function add_angajat(p_id_angajat in angajati.id%TYPE, p_nume_angajat angajati.nume%TYPE, p_prenume_angajat angajati.prenume%TYPE, p_functie angajati.functie%TYPE, p_adresa_magazin angajati.id_magazin%TYPE,p_salariu angajati.salariu%TYPE) return varchar2;
   function delete_angajat(p_id_angajat in angajati.id%TYPE) return varchar2;
   function update_angajat(p_id_angajat in angajati.id%TYPE, p_nume angajati.nume%TYPE, p_prenume angajati.prenume%TYPE ,  p_salariu angajati.salariu%TYPE, p_functie ANGAJATI.FUNCTIE%TYPE,p_magazin ANGAJATI.ID_MAGAZIN%TYPE) return varchar2;
  function interogare_angajat(p_id_angajat in angajati.id%TYPE) return varchar2;
  
 end;
/


create or replace package body operatii_angajati as

  id_persoana_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_persoana_inexistent, -20003);
  id_angajat_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_angajat_inexistent, -20004);
  id_angajat_existent exception;
  PRAGMA EXCEPTION_INIT(id_angajat_existent, -20005);
  nume_inexistent exception;
  PRAGMA EXCEPTION_INIT(nume_inexistent, -20006);
  prenume_inexistent exception;
  PRAGMA EXCEPTION_INIT(prenume_inexistent, -20007);
  

  function add_angajat(p_id_angajat in angajati.id%TYPE, p_nume_angajat angajati.nume%TYPE, p_prenume_angajat angajati.prenume%TYPE, p_functie angajati.functie%TYPE, p_adresa_magazin angajati.id_magazin%TYPE, p_salariu angajati.salariu%TYPE) return varchar2 as
    v_done_a number;
    v_done_p number;
    v_done varchar2(15);
    v_exception_a number;
    v_data date;
    
  begin
    v_data:=SYSDATE;
    
    select count(*) into v_exception_a from (select id from angajati where id = p_id_angajat);
    if(v_exception_a > 0) then
      raise id_angajat_existent;
    else 
    insert into angajati (id, id_magazin, nume, prenume, salariu, functie,DATA_ANGAJARE) values (p_id_angajat,p_adresa_magazin, p_nume_angajat, p_prenume_angajat, p_salariu,p_functie, v_data);
    select count (*) into v_done_a from (select * from angajati where id = p_id_angajat);
    if(v_done_a = 1) then
      v_done := 'Succes!';
    elsif(v_done_a != 1) then
      v_done := 'Eroare!';
    end if;
    return v_done;
    end if;
    exception
      when id_angajat_existent then
        dbms_output.put_line('Id-ul angajatului exista deja in baza de date!');
  end;


    function delete_angajat(p_id_angajat angajati.id%TYPE) return varchar2 as
    v_done_a number;
    v_done varchar2(15);
    v_exception_a number := 0;
  begin
    select count(*) into v_exception_a from (select id from angajati where id = p_id_angajat);
  
    if(v_exception_a = 0) then
      raise id_angajat_inexistent;
    else
    
    delete from angajati where id = p_id_angajat;
    
    return 'Succes!';
    end if;
    exception
      when id_angajat_inexistent then
        return 'Id-ul angajatului nu exista in baza de date!';
  end;

  function update_angajat(p_id_angajat in angajati.id%TYPE, p_nume angajati.nume%TYPE, p_prenume angajati.prenume%TYPE, p_salariu angajati.salariu%TYPE, p_functie ANGAJATI.FUNCTIE%TYPE,p_magazin ANGAJATI.ID_MAGAZIN%TYPE) return varchar2 as
    v_done_p number;
    v_done varchar2(15);
    v_exception_a number := 0;
    v_exception_p number := 0;
  begin
    select count(*) into v_exception_a from (select id from angajati where id = p_id_angajat);
    if (v_exception_a = 0) then
      raise id_persoana_inexistent;
    else
    update angajati set nume = p_nume, prenume = p_prenume, salariu=p_salariu, functie=p_functie, id_magazin=p_magazin where id = p_id_angajat;
    select count (*) into v_done_p from (select * from angajati where id= p_id_angajat and nume = p_nume and prenume = p_prenume);
    if(v_done_p = 1) then
      v_done := 'Succes!';
    elsif(v_done_p != 1) then
      v_done := 'Eroare!';
    end if;
    return v_done;
    end if;
    exception
      when id_persoana_inexistent then
        dbms_output.put_line('Id-ul persoanei nu exista in baza de date!');
      
  end;


function interogare_angajat(p_id_angajat in angajati.id%TYPE)  return varchar2 as
    v_id_angajat angajati.id%TYPE;
    v_nume_angajat angajati.nume%TYPE;
    v_prenume_angajat angajati.prenume%TYPE;
    v_salariu_angajat angajati.salariu%TYPE;
    v_magazin_angajat angajati.id_magazin%TYPE;
    v_functie_angajat angajati.functie%TYPE;
    v_dangajare_angajat ANGAJATI.DATA_ANGAJARE%TYPE;
    v_informatii varchar2(300) := ' ';
    v_exception_p number := 0;
    v_exception_a number := 0;
  begin
  
    select count(*)  into v_exception_p from (select id from angajati where id = p_id_angajat);
    
    if(v_exception_p = 0) then
      raise id_persoana_inexistent;
    else
    v_id_angajat := p_id_angajat;
    select * into v_nume_angajat from (select nume from angajati where id = v_id_angajat);
    select * into v_prenume_angajat from (select prenume from angajati where id = v_id_angajat);
    select * into v_salariu_angajat from (select salariu from angajati where id = v_id_angajat);
    select * into v_magazin_angajat from (select id_magazin from angajati where id = v_id_angajat);
    select * into v_functie_angajat from (select functie from angajati where id = v_id_angajat);
    select * into v_dangajare_angajat from (select data_angajare from angajati where id = v_id_angajat);
    v_informatii := v_id_angajat || ' ' || v_nume_angajat || ' ' || v_prenume_angajat||' ' || v_salariu_angajat||' '||v_functie_angajat||' '|| v_dangajare_angajat;
    return v_informatii;
    end if;
    exception
      when id_persoana_inexistent then
        return 'Id-ul persoanei nu exista in baza de date!';
 end;
  
  
function cautare_nume(p_nume in angajati.nume%TYPE) return varchar2 as
    v_nume_client angajati.nume%TYPE;
    v_prenume_client angajati.prenume%TYPE;
    v_informatii varchar2(32000);
    v_exception_c_n number := 0;
  begin
    
    select count(*) into v_exception_c_n from (select nume from angajati where nume = p_nume);
    
    if(v_exception_c_n = 0) then
      raise nume_inexistent;
    else
    for v_index in (select id , nume, prenume from angajati where upper(nume) = upper(p_nume)) loop
      v_informatii := v_index.id|| ' ' || v_index.nume || ' ' || v_index.prenume || ' ';
    end loop;
    return v_informatii;
    end if;
    exception
      when nume_inexistent then
        return 'Numele clientului nu exista in baza de date!';
  end;
  
  function cautare_nume_prenume(p_nume in angajati.nume%TYPE, p_prenume in angajati.prenume%TYPE)  return varchar2 as
    v_nume_client clienti.nume%TYPE;
    v_prenume_client clienti.prenume%TYPE;
    v_informatii varchar2(32000);
    v_exception_c_n number := 0;
    v_exception_c_p number := 0;
  begin
  
    select count(*) into v_exception_c_n from (select nume from angajati where nume = p_nume);
    select count(*) into v_exception_c_p from (select prenume from angajati where prenume = p_prenume);
  
    if(v_exception_c_n = 0) then
      raise nume_inexistent;
    elsif(v_exception_c_p = 0) then
      raise prenume_inexistent;
    else
      for v_index in (select id, nume, prenume from clienti where upper(nume) = upper(p_nume) and upper(prenume) = upper(p_prenume)) loop
        v_informatii := v_index.id || ' ' || v_index.nume || ' ' || v_index.prenume;
      end loop;
      return v_informatii;
    end if;
    exception
      when nume_inexistent then
        return 'Numele clientului nu exista in baza de date!';
      when prenume_inexistent then
        return 'Prenumele clientului nu exista in baza de date!';
  end;
  
end operatii_angajati;