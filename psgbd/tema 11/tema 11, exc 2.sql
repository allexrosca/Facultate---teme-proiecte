drop table speranta;
create table speranta(timestamp date, operatie varchar2(500));
/
create or replace trigger sperantahelp
after insert or update or delete on note 
FOR EACH ROW
begin
CASE
    WHEN INSERTING THEN
      insert into speranta values(sysdate,'insert into note values('||:NEW.NR_MATRICOL||','||:NEW.ID_CURS||','||:NEW.VALOARE||','''||:NEW.DATA_NOTARE||''')');
    WHEN UPDATING THEN
      insert into speranta values(sysdate,'update note set nr_matricol='||:NEW.NR_MATRICOL||', id_curs='||:NEW.ID_CURS||', valoare='||:NEW.VALOARE||', data_notare='''||:NEW.DATA_NOTARE||''' where nr_matricol='||:OLD.nr_matricol||' and id_curs='||:OLD.id_curs||' and valoare='||:OLD.valoare||' and data_notare='''||:OLD.data_notare||'''');
    when deleting then
      insert into speranta values(sysdate,'delete from note where nr_matricol='||:OLD.nr_matricol||'and id_curs='||:OLD.id_curs||' and valoare='||:OLD.valoare||' and data_notare='''||:OLD.data_notare||''''); 
  END CASE;
end;
/
