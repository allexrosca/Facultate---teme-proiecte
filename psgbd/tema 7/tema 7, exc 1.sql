drop table intrebari_netriviale;
create table intrebari_netriviale(ID	NUMBER(10,0),CHAPTER_ID	NUMBER(10,0),USER_ID	NUMBER(10,0),QUESTION	CLOB,ANSWER	CLOB,ASKED NUMBER(10,0),SOLVED	NUMBER(10,0),REPORTED	NUMBER(10,0),REPORT_RESOLVED	NUMBER(10,0),CREATED_AT	TIMESTAMP(6),UPDATED_AT	TIMESTAMP(6));
/
create or replace package problema1 as
  procedure inserare(p_id questions.id%TYPE);
  procedure inserare1000;
  relevanta_nula EXCEPTION;
  PRAGMA EXCEPTION_INIT(relevanta_nula, -20001);
end problema1; 
/
create or replace package body problema1 as

procedure inserare(p_id questions.id%TYPE) as
  begin
    if(relevanta(p_id) = 0)
      then
        raise relevanta_nula;
    end if;
    insert into intrebari_netriviale select * from questions where id=p_id;
   
  EXCEPTION
    when relevanta_nula then
      raise_application_error(-20001,'Intrebarea cu id-ul '||p_id||' are relevanta 0.');
  end inserare;
  
  procedure inserare1000 as
    v_count number(10) :=0;
    v_intrebare_random integer;
    TYPE intrebari IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
    v_intrebari intrebari;
  begin
    for i in 1..7000
      loop
        v_intrebari(i):=0;
    end loop;
    
    loop
      <<aici>>
      v_intrebare_random:=dbms_random.value(17,6416);
      begin
        if(v_intrebari(v_intrebare_random) = 0)
          then
            problema1.inserare(v_intrebare_random);
            v_intrebari(v_intrebare_random):=v_intrebari(v_intrebare_random)+1;
            v_count:=v_count+1;
        end if;
        exception
          when relevanta_nula then
            goto aici;
      end;
      exit when mod(v_count,1000) = 0;
    end loop;
  end inserare1000;

end problema1;
/

begin
problema1.inserare1000;
end;
/

--select id from intrebari_netriviale group by id having count(id)>1;