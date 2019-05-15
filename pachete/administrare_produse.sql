create or replace package administrare_produse is
  function adauga_produs(p_categorie produse.categorie%type, p_denumire produse.denumire%type, p_model produse.model_produs%type, p_pret produse.pret%type, p_culoare produse.culoare%type , p_xs stocuri_magazin.stoc_xs%type,  p_s stocuri_magazin.stoc_s%type, p_m stocuri_magazin.stoc_m%type, p_l stocuri_magazin.stoc_l%type, p_xl stocuri_magazin.stoc_xl%type) return varchar2;
  function sterge_produs(p_id_produs produse.id%type) return varchar2;
  function cauta_produs(p_id  produse.id%type) return varchar2;
  function discount_produs(p_id_produs produse.id%type, p_valoare_discount number) return varchar2;
  function discount_produs_categorie(p_categorie produse.categorie%type, p_valoare_discount number) return varchar2;
  function disponibilitate_produs(p_id_produs produse.id%type, p_id_magazin stocuri_magazin.id_magazin%type) return varchar2 ;
   
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
  
  function adauga_produs(p_categorie produse.categorie%type, p_denumire produse.denumire%type, p_model produse.model_produs%type, p_pret produse.pret%type, p_culoare produse.culoare%type , p_xs stocuri_magazin.stoc_xs%type,  p_s stocuri_magazin.stoc_s%type, p_m stocuri_magazin.stoc_m%type, p_l stocuri_magazin.stoc_l%type, p_xl stocuri_magazin.stoc_xl%type) return varchar2 is
   
  v_lastId produse.id%type := 0;
	v_lastIdStocuri stocuri_magazin.id%type :=0;
  v_nr_magazine int;
  v_id_magazin int;
  begin
    
    if(p_pret <= 0)
      then
        raise pret_incorect;
      else
          select max(id) into v_lastId from produse;
		  select max(id) into v_lastIdStocuri from stocuri_magazin;
          if(v_lastId != 0)
          then
            insert into produse values(v_lastId + 1, p_categorie, p_denumire, p_model, p_culoare, p_pret);
            v_nr_magazine:=DBMS_RANDOM.VALUE(0,100);
            for v_c in 1..v_nr_magazine loop
             v_id_magazin:=DBMS_RANDOM.VALUE(0,100);
			      insert into stocuri_magazin values( v_lastIdStocuri + 1, v_id_magazin, v_lastId + 1, p_xs, p_s, p_m, p_l, p_xl);
            v_lastIdStocuri:=v_lastIdStocuri+1;
            end loop;
		  else
            insert into produse values(1, p_categorie, p_denumire, p_model, p_culoare, p_pret); 
			insert into stocuri_magazin values( v_lastIdStocuri + 1, 1, 1, p_xs, p_s, p_m, p_l, p_xl);

		 end if; 
          return 'Success!';
    end if;
    
    exception
     when pret_incorect then
      return 'Valoarea pretului este incorecta. Introduceti o valoare pozitiva pentru pretul produsului';
  end;


  function sterge_produs(p_id_produs produse.id%type) return varchar2 is
    v_verificareProdus number;
  begin
    select count(id) into v_verificareProdus from produse where id = p_id_produs;
    if(v_verificareProdus = 0)
    then
      raise produs_inexistent;
    else
      delete from produse where id = p_id_produs;
      return 'Success!';
    end if;
    
    exception
      when produs_inexistent then
        return 'Produsul pe care doriti sa-l stergeti nu exista';
  end;


  function cauta_produs(p_id  produse.id%type) return varchar2 is
  res varchar2(32000) := ' ';
  v_verificareProdus int;
  begin
	select count(id) into v_verificareProdus from produse where id=p_id;
	if(v_verificareProdus = 0) then
		raise produs_inexistent;
	else
		for v_index in (select * from produse where id=p_id)
		loop
		  
		  res := res  || v_index.id || ' ' || v_index.categorie || ' ' || v_index.denumire || ' ' || v_index.model_produs || ' ' || v_index.culoare || ' ' || v_index.pret || ' ';
		end loop;
		return res;
	end if;
	
	exception
      when produs_inexistent then
        return 'Produsul cautat nu exista';
		
  end;
  
  
    function disponibilitate_produs(p_id  produse.id%type , p_id_magazin stocuri_magazin.id_magazin%type) return varchar2 is
  res varchar2(32000) := ' ';
  v_verificareProdus int;
  begin
	select count(id) into v_verificareProdus from stocuri_magazin where id_produs=p_id and id_magazin=p_id_magazin;
	if(v_verificareProdus = 0) then
		raise produs_inexistent;
	else
		for v_index in (select * from stocuri_magazin where id_produs=p_id and id_magazin=p_id_magazin)
		loop
		  
		  res := res  ||'XS:'|| v_index.stoc_xs || ' ' ||'S:'|| v_index.stoc_s || ' ' ||'M:'|| v_index.stoc_m || ' ' ||'L:'|| v_index.stoc_l || ' ' ||'XL:'||v_index.stoc_xl || ' ';
		end loop;
		return res;
	end if;
	
	exception
      when produs_inexistent then
        return 'Produsul nu exista in acest magazin!';
		
  end;
  
 
  
  
  
    function discount_produs(p_id_produs produse.id%type, p_valoare_discount number) return varchar2 is
    v_verificareProdus number;
  begin
    if(p_valoare_discount <= 0 or p_valoare_discount >=100)
    then
      raise valoare_discount_incorecta;
    else
      select count(id) into v_verificareProdus from produse where id= p_id_produs;
      if(v_verificareProdus = 0)
      then
        raise produs_inexistent;
      else
        update produse set pret = pret - p_valoare_discount * pret / 100 where id = p_id_produs;
        return 'Success!';
      end if;
    end if;
    
    exception
      when produs_inexistent then
        return 'Produsul caruia doriti sa ii aplicati discountul nu exista';
      when valoare_discount_incorecta then
        return 'Valorea de discount pe care doriti sa o aplicati produsului este incorecta';
  end;
  
  
  function discount_produs_categorie(p_categorie produse.categorie%type, p_valoare_discount number) return varchar2 is
    v_verificareProdus number;
  begin
    if(p_valoare_discount <= 0 or p_valoare_discount >=100)
    then
      raise valoare_discount_incorecta;
    else
      select count(id) into v_verificareProdus from produse where categorie= p_categorie;
      if(v_verificareProdus = 0)
      then
        raise produs_inexistent;
      else
        update produse set pret = pret - p_valoare_discount * pret / 100 where categorie= p_categorie;
        return 'Success!';
      end if;
    end if;
    
    exception
      when produs_inexistent then
        return 'Produsul caruia doriti sa ii aplicati discountul nu exista';
      when valoare_discount_incorecta then
        return 'Valorea de discount pe care doriti sa o aplicati produsului este incorecta';
  end;
  
 
end administrare_produse;
/

