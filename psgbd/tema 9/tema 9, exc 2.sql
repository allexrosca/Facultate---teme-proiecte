set serveroutput on;
create or replace procedure afisare(p_id number) as
   stmt_str VARCHAR2(200);
   cur_hdl  INTEGER;
   rows_processed BINARY_INTEGER;
   v_nume varchar(30);
   v_puturos number(2);
   v_nr_intrebari number(5);
   v_nr_intrebari_relevante number(5);
   v_nr_reporturi number(5);
   v_reporturi_gresite number(5);
begin
  cur_hdl := dbms_sql.open_cursor;
  stmt_str := 'select * from u'||p_id;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  dbms_sql.define_column(cur_hdl, 1, v_nume, 30); 
  dbms_sql.define_column(cur_hdl, 2, v_puturos);
  dbms_sql.define_column(cur_hdl, 3, v_nr_intrebari);
  dbms_sql.define_column(cur_hdl, 4, v_nr_intrebari_relevante);
  dbms_sql.define_column(cur_hdl, 5, v_nr_reporturi);
  dbms_sql.define_column(cur_hdl, 6, v_reporturi_gresite);  
  rows_processed := dbms_sql.execute(cur_hdl);

  LOOP 
    IF dbms_sql.fetch_rows(cur_hdl) > 0 then 
      dbms_sql.column_value(cur_hdl, 1, v_nume); 
      dbms_sql.column_value(cur_hdl, 2, v_puturos);
      dbms_sql.column_value(cur_hdl, 3, v_nr_intrebari);
      dbms_sql.column_value(cur_hdl, 4, v_nr_intrebari_relevante);
      dbms_sql.column_value(cur_hdl, 5, v_nr_reporturi); 
      dbms_sql.column_value(cur_hdl, 6, v_reporturi_gresite);  
        ELSE EXIT; 
    END IF; 
  END LOOP; 

  dbms_output.put_line(v_nume||' '||v_puturos||' '||v_nr_intrebari||' '||v_nr_intrebari_relevante||' '||v_nr_reporturi||' '||v_reporturi_gresite);
  dbms_sql.close_cursor(cur_hdl);
end;
/
begin
afisare(157);
end;