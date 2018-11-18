
create or replace procedure creaza_tabel(p_id number) as
   stmt_str VARCHAR2(200);
   cur_hdl  INTEGER;
   rows_processed BINARY_INTEGER;
begin
  stmt_str := 'create table u'|| p_id ||'(nume varchar(30), puturos number(2), nr_intrebari number(10), nr_intrebari_relevante number(10), nr_reporturi number(10), reporturi_gresite number(10))';
  cur_hdl := dbms_sql.open_cursor;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  rows_processed := dbms_sql.execute(cur_hdl);
  dbms_sql.close_cursor(cur_hdl);
end;
/
create or replace procedure primii10 as
   cursor useri is
    select user_id from (select user_id from reports r join users u on r.user_id=u.id where user_role not like 'admin' group by user_id order by count(r.id) desc) where rownum < 11;
  v_linie useri%ROWTYPE;
begin
  open useri;
    loop
      fetch useri into v_linie;
      exit when useri%NOTFOUND;
      creaza_tabel(v_linie.user_id);
    end loop;
  close useri;
end;
/
create or replace procedure drop_tabel(p_id number) as
stmt_str VARCHAR2(200);
   cur_hdl  INTEGER;
   rows_processed BINARY_INTEGER;
begin
  stmt_str := 'drop table u'|| p_id;
  cur_hdl := dbms_sql.open_cursor;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  rows_processed := dbms_sql.execute(cur_hdl);
  dbms_sql.close_cursor(cur_hdl);
end;
/
create or replace procedure drop_tabele as
   cursor useri is
    select user_id from (select user_id from reports r join users u on r.user_id=u.id where user_role not like 'admin' group by user_id order by count(r.id) desc) where rownum < 11;
  v_linie useri%ROWTYPE;
begin
  open useri;
    loop
      fetch useri into v_linie;
      exit when useri%NOTFOUND;
      drop_tabel(v_linie.user_id);
    end loop;
  close useri;
end;
/
create or replace procedure populare(p_id number) as
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
  select name into v_nume from users where id=p_id;
  v_puturos:=intrebari.puturos(p_id);
  select count(q.id) into v_nr_intrebari from questions q join users u on q.user_id=u.id where u.id=p_id;
  select count(q.id) into v_nr_intrebari_relevante from questions q join users u on q.user_id=u.id where u.id=p_id and relevanta(q.id)>0;
  select count(r.id) into v_nr_reporturi from reports r join users u on r.user_id=u.id where u.id=p_id;
  select count(r.id) into v_reporturi_gresite from reports r join users u on r.user_id=u.id join questions q on r.question_id=q.id where u.id=p_id and (report_resolved=1 or (report_resolved=0 and reported<5));
  stmt_str := 'insert into u'|| p_id ||' values(:dnume, :dputuros, :dnr_intrebari, :dnr_intrebari_relevante, :dnr_reporturi, :dreporturi_gresite)';
  cur_hdl := dbms_sql.open_cursor;
  dbms_sql.parse(cur_hdl, stmt_str,dbms_sql.native);
  dbms_sql.bind_variable(cur_hdl, ':dnume', v_nume);
  dbms_sql.bind_variable(cur_hdl, ':dputuros', v_puturos);
  dbms_sql.bind_variable(cur_hdl, ':dnr_intrebari', v_nr_intrebari);
  dbms_sql.bind_variable(cur_hdl, ':dnr_intrebari_relevante', v_nr_intrebari_relevante);
  dbms_sql.bind_variable(cur_hdl, ':dnr_reporturi', v_nr_reporturi);
  dbms_sql.bind_variable(cur_hdl, ':dreporturi_gresite', v_reporturi_gresite);
  rows_processed := dbms_sql.execute(cur_hdl);
  dbms_sql.close_cursor(cur_hdl);
end;
/
create or replace procedure populare_all as
   cursor useri is
    select user_id from (select user_id from reports r join users u on r.user_id=u.id where user_role not like 'admin' group by user_id order by count(r.id) desc) where rownum < 11;
  v_linie useri%ROWTYPE;
begin
  open useri;
    loop
      fetch useri into v_linie;
      exit when useri%NOTFOUND;
      populare(v_linie.user_id);
    end loop;
  close useri;
end;
/
declare
begin
drop_tabele;
primii10;
populare_all;
end;
