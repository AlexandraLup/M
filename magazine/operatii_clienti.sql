-- package destinat managementului clientilor
create or replace package operatii_clienti as
  function add_client(p_id_client in clienti.id%TYPE, p_nume in clienti.nume%TYPE, p_prenume in clienti.prenume%TYPE) return varchar2;
   function delete_client(p_id_client in clienti.id%TYPE) return varchar2;
   function update_client(p_id_client in clienti.id%TYPE, p_nume in clienti.nume%TYPE, p_prenume in clienti.prenume%TYPE) return varchar2;
   function interogare_client(p_id_client in clienti.id%TYPE) return varchar2;
   function cautare_nume(p_nume in clienti.nume%TYPE) return varchar2;
   function cautare_nume_prenume(p_nume in clienti.nume%TYPE, p_prenume in clienti.prenume%TYPE) return varchar2;

  
   end;
/



create or replace package body operatii_clienti as
  
  id_client_existent exception;
  PRAGMA EXCEPTION_INIT(id_client_existent, -20001);
  id_client_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_client_inexistent, -20002);
  id_persoana_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_persoana_inexistent, -20003);
  id_angajat_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_angajat_inexistent, -20004);
  nume_inexistent exception;
  PRAGMA EXCEPTION_INIT(nume_inexistent, -20005);
  prenume_inexistent exception;
  PRAGMA EXCEPTION_INIT(prenume_inexistent, -20006);
  
  function add_client(p_id_client in clienti.id%TYPE, p_nume in clienti.nume%TYPE, p_prenume in clienti.prenume%TYPE) return varchar2 is
    v_date date;
    v_done_c number;
    v_done_p number;
    v_done varchar2(10);
    v_exception_c number;
  begin
    v_date := sysdate;
    select count(*) into v_exception_c from (select id from clienti where id = p_id_client);
    if(v_exception_c > 0) then
      raise id_client_existent;
    else 
      insert into clienti values (p_id_client,p_nume, p_prenume, v_date);
    
    
    select count (*) into v_done_c from (select * from clienti where id = p_id_client);
   
    if(v_done_c = 1) then
      v_done := 'Succes!';
    elsif(v_done_c != 1 ) then
      v_done := 'Eroare';
    end if;
    return v_done;
    end if;
    exception
      when id_client_existent then
        return 'Id-ul clientului exista deja in baza de date!';
  end;



    function delete_client(p_id_client in clienti.id%TYPE) return varchar2 as
    v_done varchar2(10);
    v_done_c number;
    v_exception_c number := 0;
  begin
  
    select count(*) into v_exception_c from (select id from clienti where id=p_id_client );
  
    if(v_exception_c = 0) then
      raise id_client_inexistent;
    else
    delete from clienti where id = p_id_client ;
  
    select count(*) into v_done_c from (select * from clienti where id = p_id_client );
    if(v_done_c = 0 ) then
      v_done := 'Succes!';
    elsif(v_done_c != 0) then
      v_done := 'Eroare!';
    end if;
    return v_done;
    end if;
    exception
      when id_persoana_inexistent then
        return 'Id-ul clientului nu exista in baza de date!';
      when others then
        return 'Unknown exception!';
  end;




 function update_client(p_id_client in clienti.id%TYPE, p_nume in clienti.nume%TYPE, p_prenume in clienti.prenume%TYPE) return varchar2 as
    v_done varchar2(10);
    v_done_p number;
    v_exception_c number := 0;
    v_exception_p number := 0;
  begin
    select count(*) into v_exception_c from (select id from clienti where id = p_id_client );
    if (v_exception_c = 0) then
      raise id_client_inexistent;
    else
    update clienti set nume = p_nume, prenume = p_prenume where id= p_id_client ;
    select count (*) into v_done_p from (select * from clienti where id = p_id_client  and nume = p_nume and prenume = p_prenume);
    if(v_done_p = 1) then
      v_done := 'Succes!';
    elsif(v_done_p != 1) then
      v_done := 'Eroare!';
    end if;
    return v_done;
    end if;
    exception
      when id_client_inexistent then
        return 'Id-ul clientului nu exista in baza de date !';
     
  end;


    function interogare_client(p_id_client in clienti.id%TYPE)  return varchar2 as
    v_id_client clienti.id%TYPE;
    v_nume_client clienti.nume%TYPE;
    v_prenume_client clienti.prenume%TYPE;
    v_data_inreg clienti.data_inregistrare%TYPE;
    v_informatii varchar2(300) := ' ';
    v_exception_c number := 0;
  begin
    select count(*) into v_exception_c from (select id from clienti where id = p_id_client);
    
    if(v_exception_c = 0) then
      raise id_client_inexistent;
    else
    v_id_client := p_id_client;
    select * into v_nume_client from (select nume from clienti where id= v_id_client);
    select * into v_prenume_client from (select prenume from clienti where id = v_id_client);
    select *  into v_data_inreg from (select data_inregistrare from clienti where id = v_id_client);
    v_informatii := v_id_client || ' ' || v_nume_client || ' ' || v_prenume_client || ' ' || v_data_inreg;
    return v_informatii;
    end if;
    exception
      when id_client_existent then
        return 'Id-ul clientului nu exista in baza de date!';
      when others then
        return 'Unknown exception';
  end;
  
  function cautare_nume(p_nume in clienti.nume%TYPE) return varchar2 as
    v_nume_client clienti.nume%TYPE;
    v_prenume_client clienti.prenume%TYPE;
    v_informatii varchar2(32000);
    v_exception_c_n number := 0;
  begin
    
    select count(*) into v_exception_c_n from (select nume from clienti where nume = p_nume);
    
    if(v_exception_c_n = 0) then
      raise nume_inexistent;
    else
    for v_index in (select id , nume, prenume from clienti where upper(nume) = upper(p_nume)) loop
      v_informatii := v_index.id|| ' ' || v_index.nume || ' ' || v_index.prenume || ' ';
    end loop;
    return v_informatii;
    end if;
    exception
      when nume_inexistent then
        return 'Numele clientului nu exista in baza de date!';
  end;
  
  function cautare_nume_prenume(p_nume in clienti.nume%TYPE, p_prenume in clienti.prenume%TYPE)  return varchar2 as
    v_nume_client clienti.nume%TYPE;
    v_prenume_client clienti.prenume%TYPE;
    v_informatii varchar2(32000);
    v_exception_c_n number := 0;
    v_exception_c_p number := 0;
  begin
  
    select count(*) into v_exception_c_n from (select nume from clienti where nume = p_nume);
    select count(*) into v_exception_c_p from (select prenume from clienti where prenume = p_prenume);
  
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


end operatii_clienti;





