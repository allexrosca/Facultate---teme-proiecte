set serveroutput on;

declare
  cursor tabele is
    select table_name from user_tables;
  v_tabele tabele%ROWTYPE;
  cursor functii is
    SELECT object_name FROM USER_OBJECTS WHERE OBJECT_TYPE IN ('FUNCTION');
  v_functii functii%ROWTYPE;
  cursor proceduri is
    SELECT object_name FROM USER_OBJECTS WHERE OBJECT_TYPE IN ('PROCEDURE');
  v_proceduri proceduri%ROWTYPE;
  cursor viewuri is
    select view_name from user_views;
  v_viewuri viewuri%ROWTYPE;
  cursor triggers is
    select trigger_name from user_triggers;
  v_triggers triggers%ROWTYPE;
begin
  dbms_output.put_line('==================================================');
  dbms_output.put_line('                  ~~~TABELE~~~');
  dbms_output.put_line('==================================================');
  dbms_output.put_line(' {');
  open tabele;
    loop
      fetch tabele into v_tabele;
      exit when tabele%NOTFOUND;
      dbms_output.put_line('    '||v_tabele.TABLE_NAME);
    end loop;
  close tabele;
  dbms_output.put_line(' };');
  dbms_output.put_line('==================================================');
  
  dbms_output.put_line('');
  dbms_output.put_line('');
      
  dbms_output.put_line('');
  dbms_output.put_line('==================================================');
  dbms_output.put_line('                  ~~~FUNCTII~~~');
  dbms_output.put_line('==================================================');
  dbms_output.put_line(' {');
  open functii;
    loop
      fetch functii into v_functii;
      exit when functii%NOTFOUND;
      dbms_output.put_line('    '||v_functii.object_name);    
      end loop;
  close functii;
  dbms_output.put_line(' };');
  dbms_output.put_line('==================================================');
  
  dbms_output.put_line('');
  dbms_output.put_line('');
      
  dbms_output.put_line('');
  dbms_output.put_line('==================================================');
  dbms_output.put_line('                  ~~~PROCEDURI~~~');
  dbms_output.put_line('==================================================');
  dbms_output.put_line(' {');
  open proceduri;
    loop
      fetch proceduri into v_proceduri;
      exit when proceduri%NOTFOUND;
      dbms_output.put_line('    '||v_proceduri.object_name);    
      end loop;
  close proceduri;
  dbms_output.put_line(' };');
  dbms_output.put_line('==================================================');

  dbms_output.put_line('');
  dbms_output.put_line('');
      
  dbms_output.put_line('');
  dbms_output.put_line('==================================================');
  dbms_output.put_line('                   ~~~VIEWS~~~');
  dbms_output.put_line('==================================================');
  dbms_output.put_line(' {');
  open viewuri;
    loop
      fetch viewuri into v_viewuri;
      exit when viewuri%NOTFOUND;
      dbms_output.put_line('    '||v_viewuri.view_name);    
      end loop;
  close viewuri;
  dbms_output.put_line(' };');
  dbms_output.put_line('==================================================');

  dbms_output.put_line('');
  dbms_output.put_line('');
      
  dbms_output.put_line('');
  dbms_output.put_line('==================================================');
  dbms_output.put_line('                 ~~~TRIGGERS~~~');
  dbms_output.put_line('==================================================');
  dbms_output.put_line(' {');
  open triggers;
    loop
      fetch triggers into v_triggers;
      exit when triggers%NOTFOUND;
      dbms_output.put_line('    '||v_triggers.trigger_name);    
      end loop;
  close triggers;
  dbms_output.put_line(' };');
  dbms_output.put_line('==================================================');
    
end;

