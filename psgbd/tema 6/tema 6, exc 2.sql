set serveroutput on;

/*
GRANT CREATE TYPE TO STUDENT; -- aceasta linie se executa din "SYS as SYSDBA"

CREATE OR REPLACE TYPE lista_prenume AS TABLE OF VARCHAR2(10);
/
drop table persoane;
CREATE TABLE persoane (nume varchar2(10), 
       prenume lista_prenume)
       NESTED TABLE prenume STORE AS lista;
/       

INSERT INTO persoane VALUES('Popescu', lista_prenume('Ionut', 'Razvan'));
INSERT INTO persoane VALUES('Ionescu', lista_prenume('Elena', 'Madualina'));
INSERT INTO persoane VALUES('Ionescu', lista_prenume('Elena', 'Madalina'));
INSERT INTO persoane VALUES('Ionescu', lista_prenume('Elena', 'Madalina','Madalina','Madalina','Maduina','Madalina' ));
INSERT INTO persoane VALUES('Ionescu', lista_prenume('Eleuna', 'Muadalina'));
INSERT INTO persoane VALUES('Ionescu', lista_prenume('Elena', 'Madalina'));
INSERT INTO persoane VALUES('Rizea', lista_prenume('Mircea', 'Catalin'));
/
SELECT * FROM persoane;
/
*/
declare
  cursor ind is select * from persoane;
  v_verifica1 integer :=0;
  v_linie ind%ROWTYPE;
  v_count integer :=0;
  v_flag integer :=0;
begin
  open ind;
  loop
    fetch ind into v_linie;
    exit when ind%NOTFOUND;
    v_flag := 0;
      for i in 1..v_linie.prenume.count
        loop
          select count (*) into v_verifica1 from ind where v_linie.prenume(i) like '%u%';
          if (v_verifica1 != 0 )
            then 
              v_count:=v_count+1;
              v_flag:=1;
              exit;
            end if;
        end loop;
      if(v_flag = 1)
        then
          dbms_output.put('Nume: '||v_linie.nume||'     ');
          dbms_output.put('Prenume: ');
          for i in 1..v_linie.prenume.count
            loop
              dbms_output.put(v_linie.prenume(i)||' ');
            end loop;
            dbms_output.put_line('');
      end if;
  end loop;
  close ind;
  dbms_output.put_line('Numarul de persoane care au cel putin un prenume care sa contina litera "u" este: '||v_count);
end;