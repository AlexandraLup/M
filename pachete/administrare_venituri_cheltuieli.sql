create or replace package administrare_vc as
  function add_venit(p_id_angajat in evidente.id_angajat%type,p_valoare in venituri.valoare%type, p_descriere in venituri.descriere%type ) return varchar2;
  function delete_venit(p_id_venit in venituri.id%TYPE) return varchar2;
  function cauta_venit(p_id_venit in venituri.id%TYPE) return varchar2;
  function add_cheltuieli(p_id_angajat in evidente.id_angajat%type,p_valoare in cheltuieli.valoare%type, p_descriere in cheltuieli.descriere%type ) return varchar2;
  function delete_cheltuieli(p_id_cheltuieli in cheltuieli.id%TYPE) return varchar2;
  function cauta_cheltuieli(p_id_cheltuieli in cheltuieli.id%TYPE) return varchar2;
 end;
/

create or replace package body administrare_vc is

  id_venit_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_venit_inexistent, -20001);
  
  angajat_inexistent exception;
  PRAGMA EXCEPTION_INIT(angajat_inexistent, -20002);
  
   id_cheltuieli_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_cheltuieli_inexistent, -20003);
  
  
  function add_venit( p_id_angajat in evidente.id_angajat%type, p_valoare in venituri.valoare%type, p_descriere in venituri.descriere%type ) return varchar2 as
  v_lastId venituri.id%type := 0;
  v_lastIdEvidente evidente.id%type := 0;
  v_angajat angajati.id%type;
  
  begin
  
  select count(id) into  v_angajat from angajati where id=p_id_angajat;
   
   if(v_angajat = 0) then
      raise angajat_inexistent;
    else 
        select count(id) into v_lastId from venituri;
        select count(id) into v_lastIdEvidente from evidente;
        
        insert into evidente values (v_lastIdEvidente+1, p_id_angajat, sysdate);
        insert into venituri values (v_lastId+1, v_lastIdEvidente+1,p_valoare,p_descriere);
       
        return 'Success';
        
    end if;
    
    exception
    when angajat_inexistent then
    return 'Angajat inexistent';
   
    
    
  end;



  function delete_venit(p_id_venit in venituri.id%TYPE) return varchar2 as
    v_done varchar2(10);
    v_done_c number;
    v_exception_c number := 0;
  begin
  
    select count(*) into v_exception_c from (select id from venituri where id=p_id_venit);
  
    if(v_exception_c = 0) then
      raise id_venit_inexistent;
    else
      delete from venituri where id = p_id_venit;
      
      select count(*) into v_done_c from (select * from venituri where id = p_id_venit);
        if(v_done_c = 0 ) then
          v_done := 'Succes!';
        elsif(v_done_c != 0) then
          v_done := 'Eroare!';
        end if;
      return v_done;
    end if;
    exception
      when id_venit_inexistent then
      return 'Id-ul venitului nu exista in baza de date!';
      
  end;
  
  
  
   function add_cheltuieli( p_id_angajat in evidente.id_angajat%type, p_valoare in cheltuieli.valoare%type, p_descriere in cheltuieli.descriere%type ) return varchar2 as
  v_lastId cheltuieli.id%type := 0;
  v_lastIdEvidente evidente.id%type := 0;
  v_angajat angajati.id%type;
  
  begin
  
  select count(id) into  v_angajat from angajati where id=p_id_angajat;
   
   if(v_angajat = 0) then
      raise angajat_inexistent;
    else 
        select count(id) into v_lastId from cheltuieli;
        select count(id) into v_lastIdEvidente from evidente;
        
        insert into evidente values (v_lastIdEvidente+1, p_id_angajat, sysdate);
        insert into cheltuieli values (v_lastId+1, v_lastIdEvidente+1,p_valoare,p_descriere);
       
        return 'Success';
        
    end if;
    
    exception
    when angajat_inexistent then
    return 'Angajat inexistent';
   
    
    
  end;



  function delete_cheltuieli(p_id_cheltuieli in cheltuieli.id%TYPE) return varchar2 as
    v_done varchar2(10);
    v_done_c number;
    v_exception_c number := 0;
  begin
  
    select count(*) into v_exception_c from (select id from cheltuieli where id=p_id_cheltuieli);
  
    if(v_exception_c = 0) then
      raise id_cheltuieli_inexistent;
    else
      delete from cheltuieli where id = p_id_cheltuieli;
      
      select count(*) into v_done_c from (select * from cheltuieli where id = p_id_cheltuieli);
        if(v_done_c = 0 ) then
          v_done := 'Succes!';
        elsif(v_done_c != 0) then
          v_done := 'Eroare!';
        end if;
      return v_done;
    end if;
    exception
      when id_cheltuieli_inexistent then
      return 'Id-ul cheltuielii nu exista in baza de date!';
      
  end;
  
 function cauta_venit(p_id_venit in venituri.id%TYPE) return varchar2 as
  res varchar2(300) := ' ';
  v_exception_c number := 0;
  v_id_evidenta evidente.id%type;
  v_valoare venituri.valoare%type;
  v_data evidente.data%type;
  v_nume angajati.nume%type;
  v_prenume angajati.prenume%type;
  begin
  
    select count(*) into v_exception_c from (select id from venituri where id=p_id_venit);
  
    if(v_exception_c = 0) then
      raise id_venit_inexistent;
    else
      select id_evidenta into v_id_evidenta from venituri where id=p_id_venit;
      select valoare into v_valoare from venituri where id=p_id_venit;
     select e.data into v_data from venituri v join evidente e on e.id=v.id_evidenta where v.id=p_id_venit;
     select a.nume into v_nume from angajati a join evidente e on a.id=e.id_angajat join venituri v on v.id_evidenta=e.id where v.id=p_id_venit;
     select a.prenume into v_prenume from angajati a join evidente e on a.id=e.id_angajat join venituri v on v.id_evidenta=e.id where v.id=p_id_venit;
      res := res || p_id_venit ||' ' || v_id_evidenta||' '||v_valoare||' ' || v_data||' '||v_nume||' ' ||v_prenume||' ';
      
      return res;
    end if;
    exception
      when id_venit_inexistent then
      return 'Id-ul venitului nu exista in baza de date!';
      
  end; 

   function cauta_cheltuieli(p_id_cheltuieli in cheltuieli.id%TYPE) return varchar2 as
  res varchar2(300) := ' ';
  v_exception_c number := 0;
   v_id_evidenta evidente.id%type;
  v_valoare venituri.valoare%type;
  v_data evidente.data%type;
  v_nume angajati.nume%type;
  v_prenume angajati.prenume%type;
  v_descriere cheltuieli.descriere%type;
  begin
  
    select count(*) into v_exception_c from (select id from cheltuieli where id=p_id_cheltuieli);
  
    if(v_exception_c = 0) then
      raise id_cheltuieli_inexistent;
    else
      select id_evidenta into v_id_evidenta from cheltuieli where id=p_id_cheltuieli;
      select descriere into v_descriere from cheltuieli where id=p_id_cheltuieli;
      select valoare into v_valoare from cheltuieli where id=p_id_cheltuieli;
     select e.data into v_data from cheltuieli v join evidente e on e.id=v.id_evidenta where v.id=p_id_cheltuieli;
     select a.nume into v_nume from angajati a join evidente e on a.id=e.id_angajat join cheltuieli v on v.id_evidenta=e.id where v.id=p_id_cheltuieli;
     select a.prenume into v_prenume from angajati a join evidente e on a.id=e.id_angajat join cheltuieli v on v.id_evidenta=e.id where v.id=p_id_cheltuieli;
      res := res || p_id_cheltuieli ||' ' || v_id_evidenta||' '||v_descriere||' ' ||v_valoare||' ' || v_data||' '||v_nume||' ' ||v_prenume||' ';
     
      return res;
    end if;
    exception
      when id_cheltuieli_inexistent then
      return 'Id-ul cheltuielii nu exista in baza de date!';
      
  end; 

  
end administrare_vc ;
