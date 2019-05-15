-- package destinat mnagementului angajatilor
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
  begin
  
    select count(*) into v_exception_c from (select id from venituri where id=p_id_venit);
  
    if(v_exception_c = 0) then
      raise id_venit_inexistent;
    else
      for v_info in (select v.id, v.id_evidenta, v.valoare, e.data, a.nume, a.prenume from venituri v join evidente e on e.id=v.id_evidenta join angajati a on a.id=e.id_angajat where v.id=p_id_venit)loop
      res := res || v_info.id ||' ' || v_info.id_evidenta||' '||v_info.valoare||' ' || v_info.data||' '||v_info.nume||' ' ||v_info.prenume||' ';
      end loop;
      return res;
    end if;
    exception
      when id_venit_inexistent then
      return 'Id-ul venitului nu exista in baza de date!';
      
  end; 

   function cauta_cheltuieli(p_id_cheltuieli in cheltuieli.id%TYPE) return varchar2 as
  res varchar2(300) := ' ';
  v_exception_c number := 0;
  begin
  
    select count(*) into v_exception_c from (select id from cheltuieli where id=p_id_cheltuieli);
  
    if(v_exception_c = 0) then
      raise id_cheltuieli_inexistent;
    else
      for v_info in (select v.id, v.id_evidenta, v.valoare, v.descriere, e.data, a.nume, a.prenume from cheltuieli v join evidente e on e.id=v.id_evidenta join angajati a on a.id=e.id_angajat where v.id=p_id_cheltuieli)loop
      res := res || v_info.id ||' ' || v_info.id_evidenta||' '||v_info.valoare||' '||v_info.descriere||' '||v_info.data||' '||v_info.nume||' ' ||v_info.prenume||' ';
      end loop;
      return res;
    end if;
    exception
      when id_cheltuieli_inexistent then
      return 'Id-ul cheltuielii nu exista in baza de date!';
      
  end; 

  
end administrare_vc ;
