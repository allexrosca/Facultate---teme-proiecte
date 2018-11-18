create or replace procedure tabel_intrebare(p_id number) as
   stmt_str VARCHAR2(200);
   cur_hdl  INTEGER;
   rows_processed BINARY_INTEGER;
begin
  stmt_str := 'create table intrebare_'|| p_id ||'(username varchar(30), raspunsuri number(5), raspunsuri_corecte number(5), data date)';
  cur_hdl := dbms_sql.open_cursor;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  rows_processed := dbms_sql.execute(cur_hdl);
  dbms_sql.close_cursor(cur_hdl);
end;
/
create or replace procedure bucurie as
   cursor intrebari is
    select id from questions where created_at >= to_date('15/01/2017','DD/MM/YYYY') and reported >= 5;
  v_linie intrebari%ROWTYPE;
begin
  open intrebari;
    loop
      fetch intrebari into v_linie;
      exit when intrebari%NOTFOUND;
      tabel_intrebare(v_linie.id);
    end loop;
  close intrebari;
end;
/
create or replace procedure drop_tabel_intrebare(p_id number) as
stmt_str VARCHAR2(200);
   cur_hdl  INTEGER;
   rows_processed BINARY_INTEGER;
begin
  stmt_str := 'drop table intrebare_'|| p_id;
  cur_hdl := dbms_sql.open_cursor;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  rows_processed := dbms_sql.execute(cur_hdl);
  dbms_sql.close_cursor(cur_hdl);
end;
/
create or replace procedure drop_tabele_intrebari as
   cursor intrebari is
    select id from questions where created_at >= to_date('15/01/2017','DD/MM/YYYY') and reported >= 5;
    v_linie intrebari%ROWTYPE;
begin
  open intrebari;
    loop
      fetch intrebari into v_linie;
      exit when intrebari%NOTFOUND;
      drop_tabel_intrebare(v_linie.id);
    end loop;
  close intrebari;
end;
/
create or replace procedure populare_tabel_intrebari(p_id number) as
   stmt_str VARCHAR2(200);
   cur_hdl  INTEGER;
   rows_processed BINARY_INTEGER;
   v_username varchar2(30);
   v_raspunsuri number(5);
   v_raspunsuri_corecte number(5);
   v_data date;
   
begin
  select username into v_username from users u join questions q on q.user_id=u.id where q.id=p_id;
  select asked into v_raspunsuri from questions where id=p_id;
  select solved into v_raspunsuri_corecte from questions where id=p_id;
  select created_at into v_data from questions where id=p_id;
  stmt_str := 'insert into intrebare_'|| p_id ||' values(:dusername, :draspunsuri, :draspunsuri_corecte, :ddata)';
  cur_hdl := dbms_sql.open_cursor;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  dbms_sql.bind_variable(cur_hdl, ':dusername', v_username);
  dbms_sql.bind_variable(cur_hdl, ':draspunsuri', v_raspunsuri);
  dbms_sql.bind_variable(cur_hdl, ':draspunsuri_corecte', v_raspunsuri_corecte);
  dbms_sql.bind_variable(cur_hdl, ':ddata', v_data);
  rows_processed := dbms_sql.execute(cur_hdl);
  dbms_sql.close_cursor(cur_hdl);
end;
/
create or replace procedure populare_all_intrebari as
  cursor intrebari is
  select id from questions where created_at >= to_date('15/01/2017','DD/MM/YYYY') and reported >= 5;
  v_linie intrebari%ROWTYPE;
begin
  open intrebari;
    loop
      fetch intrebari into v_linie;
      exit when intrebari%NOTFOUND;
      populare_tabel_intrebari(v_linie.id);
    end loop;
  close intrebari;
end;
/
begin
drop_tabele_intrebari;
bucurie;
populare_all_intrebari;
end;
/
