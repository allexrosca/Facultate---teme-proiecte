set serveroutput on;


drop table joc_oop;
/
drop type extra;
/
drop type joc;
/

create or replace type joc as object
(
  nume VARCHAR2(30),
  gen VARCHAR2(30),
  varsta_minima NUMBER(3),
  data_lansarii DATE,
  producator VARCHAR2(30),
  pret_lei NUMBER(5),
  pret_euro NUMBER(5),
  member procedure afisare_informatii_pt_dev, --aceasta clasa nu poate fi suprascrisa deoarece nu are NOT FINAL in fata--
  not final member procedure afisare_informatii_minime,
  member function caut(p_nume VARCHAR2) return number, 
  member function caut(p_pret_lei NUMBER) return number, 
  MAP member function vechime return number,
  CONSTRUCTOR FUNCTION joc(nume varchar2, gen varchar2,data_lansarii date, producator varchar2, pret_lei number)
    RETURN SELF AS RESULT
) not final;
/

create or replace type body joc as 

  member function caut(p_nume VARCHAR2) return number as
  begin
    if(nume = p_nume)
      then
        return 1;
    else return 0;
    end if;
  end caut;
  
  member function caut(p_pret_lei NUMBER) return number as
  begin
    if(pret_lei = p_pret_lei)
      then
        return 1;
    else return 0;
    end if;
  end caut;
  
  member procedure afisare_informatii_pt_dev is
  begin
    dbms_output.put_line('Nume joc: '||nume||'   '||'Producator: '||producator||'   '||'Pret (euro): '||pret_euro);
  end afisare_informatii_pt_dev;
  
  member procedure afisare_informatii_minime is
  begin
    dbms_output.put_line('Numele jocului: '||nume||' | '||'Varsta minima: '||varsta_minima||' | '||'Genul jocului: '||upper(gen)||' | '||'Pretul (lei): '||pret_lei);
  end afisare_informatii_minime;
    
  map member function vechime return number as
    v_vechime number(10);
    begin
      v_vechime:=sysdate - data_lansarii;
      return v_vechime;
  end vechime;

  CONSTRUCTOR FUNCTION joc(nume varchar2, gen varchar2,data_lansarii date, producator varchar2, pret_lei number)
      RETURN SELF AS RESULT
    AS
      gen_inexistent EXCEPTION;
      PRAGMA EXCEPTION_INIT(gen_inexistent, -20001);
      v_count number(2) := 0;
    begin
      self.nume:=nume;
      self.gen:=gen;
      if(gen = 'horror')
        then
          self.varsta_minima:=18;
          v_count:=1;
        else if(gen = 'scifi')
          then
            self.varsta_minima:=5;
            v_count:=1;
          else if(gen = 'actiune')
            then
              self.varsta_minima:=15;
              v_count:=1;
            else if(gen = 'rpg')
              then
                self.varsta_minima:=10;
                v_count:=1;
              else if(gen = 'mmo')
                then
                  self.varsta_minima:=8;
                  v_count:=1;
              end if;
              end if;
            end if;
        end if;
      end if;
      if(v_count=0)
      then
        raise gen_inexistent;
      end if;
      self.data_lansarii:=data_lansarii;
      self.producator:=producator;
      self.pret_lei:=pret_lei;
      self.pret_euro:=pret_lei / 4.54;
      return;
      EXCEPTION
      when gen_inexistent then
        raise_application_error (-20001, 'Eroare! Nu exista genul de joc "'||gen||'". Alegeti unul dintre genurile: horror, actiune, scifi, rpg, mmo.');
    end;
end;
/

create or replace type extra under joc
(
  engine varchar2(30),
  platforma varchar2(100),
  overriding member procedure afisare_informatii_pt_dev
);
/

create or replace type body extra as
  overriding member procedure afisare_informatii_pt_dev is
  begin
    dbms_output.put_line('Nume joc: '||nume||'   '||'Producator: '||producator||'   '||'Pret (euro): '||pret_euro||'   '||'Engine: '||engine||'   '||'Platforma: '||platforma);
  end afisare_informatii_pt_dev;
end;
/
CREATE TABLE joc_oop (id_joc NUMBER(5), game JOC);
/
declare
  v_joc1 JOC;
  v_joc2 JOC;
  v_joc3 EXTRA;
begin
  v_joc1:=joc('Assassins Creed','actiune',TO_DATE('11/04/1994', 'dd/mm/yyyy'),'ubisoft',150);
  v_joc2:=joc('Dying Light','horror',TO_DATE('21/02/1995', 'dd/mm/yyyy'),'cineva',200);
  v_joc3:=extra('Ryse Son of Rome','rpg',15,TO_DATE('10/12/2008', 'dd/mm/yyyy'),'altcineva',454,100,'Unreal Engine 4','Windows');
  v_joc1.afisare_informatii_minime;
  dbms_output.put_line('');
  v_joc2.afisare_informatii_pt_dev;
  dbms_output.put_line('');
  dbms_output.put_line('varsta minima '||v_joc2.varsta_minima||' | '||v_joc2.pret_euro||' euro'||' | '||v_joc2.vechime||' zile');
  dbms_output.put_line('');
  insert into joc_oop values ('2', v_joc1);
  insert into joc_oop values ('3', v_joc2);
    if(v_joc1 > v_joc2)
    then
      dbms_output.put_line('Jocul "'||v_joc2.nume||'" este mai nou ca jocul "'||v_joc1.nume||'".  '||'('||v_joc2.data_lansarii||' | '||v_joc1.data_lansarii||')');
    else if(v_joc2 > v_joc1)
      then
        dbms_output.put_line('Jocul "'||v_joc1.nume||'" este mai nou ca jocul "'||v_joc2.nume||'".'||'('||v_joc1.data_lansarii||' | '||v_joc2.data_lansarii||')');
          else dbms_output.put_line('Jocul "'||v_joc1.nume||'" si jocul "'||v_joc2.nume||' au aparut in aceeasi data.'||'('||v_joc1.data_lansarii||' | '||v_joc2.data_lansarii||')');
      end if;
  end if;
  dbms_output.put_line('');
  v_joc3.afisare_informatii_pt_dev;
  dbms_output.put_line(v_joc2.caut('Dying Light'));
  dbms_output.put_line(v_joc1.caut(100));
end;
/
--select * from joc_oop order by game;