drop table utilizatori;
create table utilizatori(ID integer primary key not null, nume VARCHAR2(255), prenume VARCHAR2(255), data_nastere DATE, telefon VARCHAR2(10) unique, email VARCHAR2(255) unique);
declare
  v_n1 USERS.NAME%TYPE;
  v_n2 USERS.NAME%TYPE;
  v_n3 USERS.NAME%TYPE;
  v_nume USERS.NAME%TYPE;
  v_prenume1 USERS.NAME%TYPE;
  v_prenume2 USERS.NAME%TYPE;
  v_numar2 NUMBER(1);
  v_numar3 NUMBER(1);
  v_numar4 NUMBER(1);
  v_numar5 NUMBER(1);
  v_numar6 NUMBER(1);
  v_numar7 NUMBER(1);
  v_numar8 NUMBER(1);
  v_numar9 NUMBER(1);
  v_numar10 NUMBER(11);
  v_data DATE;
  v_rand NUMBER(2);
begin
  FOR IDS IN 1..100 
  LOOP
  select name into v_n1 from (select name from users order by dbms_random.random) where rownum<2;
  select name into v_n2 from (select name from users order by dbms_random.random) where rownum<2;
  select name into v_n3 from (select name from users order by dbms_random.random) where rownum<2;
  v_numar2:=dbms_random.value(1,9);
  v_numar3:=dbms_random.value(1,9);
  v_numar4:=dbms_random.value(1,9);
  v_numar5:=dbms_random.value(1,9);
  v_numar6:=dbms_random.value(1,9);
  v_numar7:=dbms_random.value(1,9);
  v_numar8:=dbms_random.value(1,9);
  v_numar9:=dbms_random.value(1,9);
  v_numar10:=v_numar2||v_numar3||v_numar4||v_numar5||v_numar6||v_numar7||v_numar8||v_numar9;
  v_nume:=NVL(SUBSTR(v_n1, INSTR(v_n1, ' ')+1), v_n1);
  v_prenume1:=NVL(SUBSTR(v_n2, 0, INSTR(v_n2, ' ')-1), v_n2);
  v_prenume2:=NVL(SUBSTR(v_n3, 0, INSTR(v_n3, ' ')-1), v_n3);
  IF (substr(v_prenume1,length(v_prenume1),1)='a') 
    THEN 
      IF (substr(v_prenume2,length(v_prenume2),1)!='a' OR substr(v_prenume2,length(v_prenume2),1)!='Mircea') OR (substr(v_prenume2,length(v_prenume2),1)!='Mihnea')
        THEN 
          LOOP
          select name into v_n3 from (select name from users order by dbms_random.random) where rownum<2;
          EXIT WHEN substr(NVL(SUBSTR(v_n3, 0,INSTR(v_n3, ' ')-1), v_n3),length(NVL(SUBSTR(v_n3, 0, INSTR(v_n3, ' ')-1), v_n3)),1)='a' AND v_prenume1!=v_prenume2;
          END LOOP;
      END IF;
  ELSE
    IF (substr(v_prenume1,length(v_prenume1),1)!='a') OR (substr(v_prenume2,length(v_prenume2),1)!='Mircea') OR (substr(v_prenume2,length(v_prenume2),1)!='Mihnea')
      THEN
        IF (substr(v_prenume2,length(v_prenume2),1)='a') OR (substr(v_prenume2,length(v_prenume2),1)='Denise')
          THEN
            LOOP
            select name into v_n3 from (select name from users order by dbms_random.random) where rownum<2;
            EXIT WHEN substr(NVL(SUBSTR(v_n3, 0,INSTR(v_n3, ' ')-1), v_n3),length(NVL(SUBSTR(v_n3, 0, INSTR(v_n3, ' ')-1), v_n3)),1)!='a' AND v_prenume1!=v_prenume2;
            END LOOP;
          END IF;
      END IF;
  END IF;
  v_prenume2:=NVL(SUBSTR(v_n3, 0, INSTR(v_n3, ' ')-1), v_n3);
  v_data:=TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '1997-01-01','J'),TO_CHAR(DATE '1997-12-31','J'))),'J');
  v_rand:= dbms_random.value(1,10);
  IF v_rand>3
    THEN insert into utilizatori values (IDS,v_nume,v_prenume1||' '||v_prenume2,v_data,'07'||v_numar10,lower(v_prenume1)||'.'||lower(v_prenume2)||substr(v_data,0,2)||'@info.uaic.ro');
  ELSE insert into utilizatori values (IDS,v_nume,v_prenume2,v_data,'07'||v_numar10,lower(v_prenume1)||'.'||lower(v_prenume2)||substr(v_data,0,2)||'@info.uaic.ro');
  END IF;
  if mod(IDS,100)=0 then commit;
  end if;
  end loop;
end;