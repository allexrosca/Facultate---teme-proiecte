set serveroutput on;
declare
  v_max_relevanta number :=0;
  v_max_id number :=0;
  v_nume users.name%TYPE :=0;
  v_rol users.user_role%type :=0;
  cursor id_intrebare is
    select id from questions where id>=120 and id <=140;
  v_linie id_intrebare%ROWTYPE;
begin
  open id_intrebare;
  loop
    fetch id_intrebare into v_linie;
    exit when id_intrebare%NOTFOUND;
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('Id Intrebare:'||v_linie.id||'   '||'Relevanta:'||intrebari.relevanta(v_linie.id));
    select user_role into v_rol from users u join questions q on u.id=q.user_id where q.id=v_linie.id;
    if (v_max_relevanta < intrebari.relevanta(v_linie.id)) AND (v_rol != 'admin')
      then 
        v_max_relevanta := intrebari.relevanta(v_linie.id);
        v_max_id := v_linie.id;
    end if;
  end loop;
  close id_intrebare;
  select name into v_nume from users u join questions q on u.id=q.user_id where q.id=v_max_id;
  dbms_output.put_line('----------------------------');
  dbms_output.put_line(v_nume||' a introdus intrebarea cu cea mai mare relevanta: '||v_max_relevanta);
end;
