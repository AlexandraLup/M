CREATE OR REPLACE TRIGGER stergere_produs
AFTER DELETE ON produse FOR EACH ROW
BEGIN 
delete from stocuri_magazin where id_produs=:OLD.id;
END;
/
CREATE OR REPLACE TRIGGER adauga_angajat
AFTER INSERT ON angajati FOR EACH ROW
BEGIN 
update magazine set nr_angajati=nr_angajati+1 where id=:NEW.id_magazin;
END;
/
CREATE OR REPLACE TRIGGER sterge_angajat
AFTER DELETE ON angajati FOR EACH ROW
BEGIN 
update magazine set nr_angajati=nr_angajati-1 where id=:OLD.id_magazin;
END;
/
CREATE OR REPLACE TRIGGER update_angajat
AFTER UPDATE ON angajati FOR EACH ROW
BEGIN 
update magazine set nr_angajati=nr_angajati-1 where id=:OLD.id_magazin;
update magazine set nr_angajati=nr_angajati+1 where id=:NEW.id_magazin;
END;