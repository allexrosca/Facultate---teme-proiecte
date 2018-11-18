create or replace procedure clonare(p_tabel_sursa varchar2, p_tabel_destinatie varchar2) as
   stmt_str VARCHAR2(200);
   cur_hdl  INTEGER;
   rows_processed BINARY_INTEGER;
begin
  stmt_str := 'create table '||p_tabel_destinatie||' as select * from '||p_tabel_sursa;
  cur_hdl := dbms_sql.open_cursor;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  rows_processed := dbms_sql.execute(cur_hdl);
  dbms_sql.close_cursor(cur_hdl);
end;
/
begin
clonare('u62','da3');
end;