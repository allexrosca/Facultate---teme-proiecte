
declare
  stmt_str VARCHAR2(200);
  cur_hdl  INTEGER;
  rows_processed BINARY_INTEGER;
  cursor speranta is
    select operatie from speranta;
    v_linie speranta%ROWTYPE;
begin
  open speranta;
  loop
    fetch speranta into v_linie;
    exit when speranta%NOTFOUND;
    stmt_str := v_linie.operatie;
    --dbms_output.put_line(v_linie.operatie);
    cur_hdl := dbms_sql.open_cursor;
    dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
    rows_processed := dbms_sql.execute(cur_hdl);
    dbms_sql.close_cursor(cur_hdl);
  end loop;
  close speranta;

end;
