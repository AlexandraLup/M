create or replace package administrare_produse is
  function adauga_produs(p_categorie produse.categorie%type, p_denumire produse.denumire%type, p_model produse.model_produs%type, p_pret produse.pret%type, p_culoare produse.culoare%type) return varchar2;
end administrare_produse;
/
create or replace package body administrare_produse is
  categorie_inexistenta exception;
  pragma exception_init(categorie_inexistenta, -20001);
  stoc_incorect exception;
  PRAGMA EXCEPTION_INIT(stoc_incorect, -20002);
  pret_incorect exception;
  PRAGMA EXCEPTION_INIT(pret_incorect, -20003);
  produs_inexistent exception;
  PRAGMA EXCEPTION_INIT(produs_inexistent, -20003);
  valoare_discount_incorecta exception;
  PRAGMA EXCEPTION_INIT(valoare_discount_incorecta, -20004);
  valoare_stoc_incorecta exception;
  pragma exception_init(valoare_stoc_incorecta, -20005);
  
  function adauga_produs(p_categorie produse.categorie%type, p_denumire produse.denumire%type, p_model produse.model_produs%type, p_pret produse.pret%type, p_culoare produse.culoare%type) return varchar2 is
    v_lastId produse.id%type := 0;
  begin
    
    if(p_pret <= 0)
      then
        raise pret_incorect;
      else
          select max(id) into v_lastId from produse;
          if(v_lastId != 0)
          then
            insert into produse values(v_lastId + 1, p_categorie, p_denumire, p_model, p_culoare, p_pret); 
          else
            insert into produse values(1, p_categorie, p_denumire, p_model, p_culoare, p_pret); 
          end if; 
          return 'Success!';
    end if;
    
    exception
     when pret_incorect then
      return 'Valoarea pretului este incorecta. Introduceti o valoare pozitiva pentru pretul produsului';
  end;
  
 
end administrare_produse;
/
