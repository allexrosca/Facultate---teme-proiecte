set serveroutput on;

DECLARE 
  CURSOR update_intrebari IS
  SELECT * FROM QUESTIONS FOR UPDATE OF REPORT_RESOLVED NOWAIT;
  CURSOR intrebari IS 
  select name from users u join questions q on u.id=q.user_id where report_resolved=2 group by u.id,name;
  v_nume users.name%TYPE;
  v_count NUMBER(3);
BEGIN
  FOR v_linie IN update_intrebari
    LOOP
      IF ((v_linie.REPORTED >= 5) AND (v_linie.UPDATED_AT >= to_date('15-JAN-17','DD-MON-RR')))
        THEN 
          UPDATE QUESTIONS SET REPORT_RESOLVED=2 WHERE CURRENT OF update_intrebari;
      END IF;
    END LOOP;
  FOR v_index IN intrebari
    LOOP
      v_nume := v_index.name;
      select count(report_resolved) into v_count from questions q join users u on u.id=q.user_id where report_resolved=2 and name like '%'||v_nume||'%' group by u.id,name;
      DBMS_OUTPUT.PUT_line('Nume: '||v_nume||' --- '||'Nr. Intrebari acceptate: '||v_count);
    END LOOP;
END;
