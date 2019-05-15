create or replace package administrare_facturi is
  function adauga_factura(p_id_factura  facturi.id%type, p_id_angajat facturi.id_angajat%type, p_id_client facturi.id_client%type, p_valoare facturi.valoare%type ) return varchar2;
  function sterge_factura(p_id_factura facturi.id%type) return varchar2;
  function cauta_factura(p_id_factura facturi.id%type) return varchar2;
  function vezi_produse (p_id_factura facturi.id%type) return varchar2;
  function adauga_produs (p_id_factura facturi.id%type, p_id_produs lista_produse.id_produs%type, p_cantitate lista_produse.cantitate%type, p_subtotal lista_produse.subtotal%type, p_marime lista_produse.marime%TYPE) return varchar2;
 end administrare_facturi;
 /
create or replace package body administrare_facturi is
  id_factura_inexistent exception;
  PRAGMA EXCEPTION_INIT(id_factura_inexistent, -20001);
  id_factura_existent exception;
  PRAGMA EXCEPTION_INIT(id_factura_existent, -20002);

  function adauga_factura(p_id_factura  facturi.id%type, p_id_angajat facturi.id_angajat%type, p_id_client facturi.id_client%type, p_valoare facturi.valoare%type ) return varchar2 as
    v_date date;
    v_done_c number;
    v_done_p number;
    v_done varchar2(10);
    v_exception_c number;
    begin
     v_date := sysdate;
     select count(*) into v_exception_c from (select id from facturi where id = p_id_factura);
     if(v_exception_c > 0) then
      raise id_factura_existent;
    else 
      insert into facturi values (p_id_factura,p_id_angajat, p_id_client, v_date,p_valoare);
      select count (*) into v_done_c from (select * from facturi where id = p_id_factura);
   
    if(v_done_c = 1) then
      v_done := 'Succes!';
    elsif(v_done_c != 1 ) then
      v_done := 'Eroare';
    end if;
    return v_done;
    end if;
    exception
      when id_factura_existent then
        return 'Id-ul facturii exista deja in baza de date!';
      
    end;

  function cauta_factura(p_id_factura facturi.id%TYPE) return varchar2 is
    v_exception_c number :=0;
    v_nume_angajat angajati.nume%TYPE;
    v_nume_client clienti.nume%TYPE;
    v_prenume_angajat angajati.prenume%TYPE;
    v_prenume_client clienti.prenume%TYPE;
    v_data_factura date;
    v_valoare facturi.valoare%TYPE;
    v_informatii varchar2(300) := ' ';
    BEGIN
    select count(*) into v_exception_c from (select id from facturi where id = p_id_factura);
    if(v_exception_c = 0) then
      raise id_factura_inexistent;
    else 
     select nume into v_nume_angajat from angajati where id in (select id_angajat from facturi  where id=p_id_factura);
     select prenume into v_prenume_angajat from angajati where id in (select id_angajat from facturi  where id=p_id_factura);
     select nume into v_nume_client from clienti where id in (select id_client from facturi  where id=p_id_factura);
     select prenume into v_prenume_client from clienti where id in (select id_client from facturi  where id=p_id_factura);
     select data_factura into v_data_factura from facturi where id=p_id_factura;
     select valoare into v_valoare from facturi where id=p_id_factura;
     v_informatii:= p_id_factura || ' ' || v_data_factura ||' ' || v_valoare ||' ' || v_nume_angajat || ' ' || v_prenume_angajat || ' ' || v_nume_client || ' ' || v_prenume_client;
     return v_informatii;
    end if;
    exception
      when id_factura_inexistent then
        return 'Id-ul facturii nu exista in baza de date!';
      when others then
        return 'Unknown exception';
    END;

  function sterge_factura(p_id_factura facturi.id%type) return varchar2 as
    v_done varchar2(10);
    v_done_c number;
    v_exception_c number := 0;
  begin
  select count(*) into v_exception_c from (select id from facturi where id=p_id_factura );
    if(v_exception_c = 0) then
      raise id_factura_inexistent;
    else
      delete from facturi where id = p_id_factura ;
      select count(*) into v_done_c from (select * from facturi where id = p_id_factura );
      if(v_done_c = 0 ) then
        v_done := 'Succes!';
      elsif(v_done_c != 0) then
        v_done := 'Eroare!';
      end if;
      return v_done;
    end if;
    exception
      when id_factura_inexistent then
        return 'Id-ul facturii nu exista in baza de date!';
      when others then
        return 'Unknown exception!';
  end;

  function vezi_produse (p_id_factura facturi.id%type) return varchar2 as
  v_exception_c number :=0;
  res varchar2(32000) ;
  begin
    select count(*) into v_exception_c from (select id from facturi where id = p_id_factura);
    if(v_exception_c = 0) then
      raise id_factura_inexistent;
    else 
     for v_index in (select p.id, p.denumire, l.cantitate, l.subtotal, l.marime from facturi f join lista_produse l on f.id=l.id_factura join produse p on l.id_produs=p.id where f.id=p_id_factura) loop
       res := res || v_index.id || ' '|| v_index.cantitate || ' '||v_index.subtotal||' '||v_index.marime||' ';
     end loop;
       return res;
    end if;
	
	exception
      when id_factura_inexistent then
        return 'Id-ul facturii nu exista in baza de date!';
	 when others then
        return 'Unknown exception!';
  end;

  function adauga_produs (p_id_factura facturi.id%type, p_id_produs lista_produse.id_produs%type, p_cantitate lista_produse.cantitate%type, p_subtotal lista_produse.subtotal%type, p_marime lista_produse.marime%TYPE) return varchar2 as 
    v_exception_c number :=0;
    v_id lista_produse.id%TYPE;
    begin
    select count(*) into v_exception_c from (select id from facturi where id = p_id_factura);
    if(v_exception_c = 0) then
      raise id_factura_inexistent;
    else 
      select max(id) into v_id from lista_produse;
      insert into lista_produse(id,id_produs,id_factura,cantitate,subtotal,marime) values (v_id+1, p_id_produs, p_id_factura,p_cantitate,p_subtotal, p_marime);
      return 'Success!';
    end if;
    exception
      when id_factura_inexistent then
        return 'Id-ul facturii nu exista in baza de date!';
      when others then
        return 'Unknown exception!';
    end;

end administrare_facturi;