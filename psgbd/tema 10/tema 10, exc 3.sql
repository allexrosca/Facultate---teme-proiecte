create or replace procedure dropeaza(p_type varchar2) as
  cursor stergere is
    SELECT object_name FROM USER_OBJECTS WHERE OBJECT_TYPE IN (p_type);
  v_linie stergere%ROWTYPE;
  stmt_str VARCHAR2(200);
  cur_hdl  INTEGER;
  rows_processed BINARY_INTEGER;
begin
  open stergere;
    loop
      fetch stergere into v_linie;
      exit when stergere%NOTFOUND;
      if(v_linie.object_name like 'DROPEAZA')
        then
          null;
        else
          stmt_str := 'drop '||p_type||' '||v_linie.object_name;
          cur_hdl := dbms_sql.open_cursor;
          dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
          rows_processed := dbms_sql.execute(cur_hdl);
          dbms_sql.close_cursor(cur_hdl);
      end if;
    end loop;
  close stergere;
end;
/
declare
  stmt_str VARCHAR2(200);
  cur_hdl  INTEGER;
  rows_processed BINARY_INTEGER;
  cursor sterge_constrangeri is
    select table_name, constraint_name from user_constraints where constraint_type = 'R';
  v_linie sterge_constrangeri%ROWTYPE;
begin
  open sterge_constrangeri;
    loop
      fetch sterge_constrangeri into v_linie;
      exit when sterge_constrangeri%NOTFOUND;
        stmt_str := 'alter table '||v_linie.table_name ||' drop constraint '||v_linie.constraint_name;
        cur_hdl := dbms_sql.open_cursor;
        dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
        rows_processed := dbms_sql.execute(cur_hdl);
        dbms_sql.close_cursor(cur_hdl);
    end loop;
  close sterge_constrangeri;
      
  dropeaza('TABLE');
  dropeaza('FUNCTION');
  dropeaza('PROCEDURE');
  dropeaza('VIEW');
  dropeaza('TRIGGER');
  dropeaza('PACKAGE BODY');
  dropeaza('PACKAGE');


end;
/
drop procedure dropeaza;