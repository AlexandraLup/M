-- package destinat mnagementului angajatilor
create or replace package administrare_contracte as
  function add_contract(p_id_angajat in contracte.id%TYPE, p_data_inceput contracte.data_inceput%TYPE, p_data_sfarsit contracte.data_sfarsit%TYPE) return varchar2;
  function delete_contract(p_id_contract in contracte.id%TYPE) return varchar2;

 end;
/

create or replace package body administrare_contracte is

  angajat_inexistent exception;
  PRAGMA EXCEPTION_INIT(angajat_inexistent, -20001);

  id_contract_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_contract_inexistent, -20002);
  
  function add_contract(p_id_angajat in contracte.id%TYPE, p_data_inceput contracte.data_inceput%TYPE, p_data_sfarsit contracte.data_sfarsit%TYPE) return varchar2 is
  v_lastId contracte.id%type := 0;
  v_angajat int;
  
  begin
   select count(id) into  v_angajat from angajati where id=p_id_angajat;
   
   if(v_angajat = 0) then
      raise angajat_inexistent;
    else 
        select max(id) into v_lastId from contracte;
        if(v_lastId != 0) then
              insert into contracte values (v_lastId+1, p_id_angajat,p_data_inceput,p_data_sfarsit);
        else
              insert into contracte values (1, p_id_angajat,p_data_inceput,p_data_sfarsit);
        end if;
        return 'Success';
    end if;
    
    exception
    when angajat_inexistent then
    return 'Angajatul nu a fost introdus in baza de date inainte de a face contractul';
   
  end;



    function delete_contract(p_id_contract in contracte.id%TYPE) return varchar2 as
    v_done varchar2(10);
    v_done_c number;
    v_exception_c number := 0;
  begin
  
    select count(*) into v_exception_c from (select id from contracte where id=p_id_contract);
  
    if(v_exception_c = 0) then
      raise id_contract_inexistent;
    else
      delete from contracte where id = p_id_contract;
  
    select count(*) into v_done_c from (select * from contracte where id = p_id_contract);
    if(v_done_c = 0 ) then
      v_done := 'Succes!';
    elsif(v_done_c != 0) then
      v_done := 'Eroare!';
    end if;
    return v_done;
    end if;
    exception
      when id_contract_inexistent then
        return 'Id-ul contractului nu exista in baza de date!';
      
  end;
  
end administrare_contracte 
