set serveroutput on;
CREATE OR REPLACE DIRECTORY esecuri AS 'E:\fuckultate\PSGBD\esecuri';

create or replace procedure scrie as
  fisier UTL_FILE.FILE_TYPE;
  cursor text is
    SELECT TEXT FROM USER_SOURCE;
  v_linie_text text%ROWTYPE;
begin
  fisier := UTL_FILE.FOPEN('ESECURI', 'vise.sql' , 'W');
  IF UTL_FILE.IS_OPEN(fisier)
    THEN
      DBMS_OUTPUT.PUT_LINE ('');
    ELSE
      dbms_output.put_line ('Eroare la deschiderea fisierului');
  END IF;
  open text;
  loop
    fetch text into v_linie_text;
    exit when text%NOTFOUND;
    if lower(substr(v_linie_text.text,1,9)) like 'procedure' or lower(substr(v_linie_text.text,1,9)) like '%function%' or lower(substr(v_linie_text.text,1,9)) like '%trigger%'
      then
        UTL_FILE.PUT_LINE(fisier,' ');
        UTL_FILE.PUT_LINE(fisier,'/');
        UTL_FILE.PUT_LINE(fisier,'CREATE OR REPLACE '||v_linie_text.text);
      else
        UTL_FILE.PUT_LINE(fisier,v_linie_text.text);
    end if;    
  end loop;
  close text;
    UTL_FILE.PUT_LINE(fisier,'/');
  UTL_FILE.PUT_LINE(fisier,'');
  UTL_FILE.PUT_LINE(fisier,'');
  UTL_FILE.FCLOSE(fisier);
end;
/
create or replace procedure scrie_tabele as
  fisier UTL_FILE.FILE_TYPE;
  cursor tabele is
    SELECT DBMS_METADATA.GET_DDL('TABLE',table_name) as "text" FROM USER_TABLES;
  v_linie tabele%ROWTYPE;
begin
  fisier := UTL_FILE.FOPEN('ESECURI', 'vise.sql' , 'A');
  open tabele;
    loop
      fetch tabele into v_linie;
      exit when tabele%NOTFOUND;
      if substr(v_linie."text",1) like '%"STUDENT".%'
        then
          UTL_FILE.PUT_LINE(fisier,'/');
          UTL_FILE.PUT_LINE(fisier,replace(v_linie."text",'"STUDENT".',''));
        else  
          UTL_FILE.PUT_LINE(fisier,v_linie."text");
      end if;
    end loop;
  close tabele;
  UTL_FILE.PUT_LINE(fisier,'');
  UTL_FILE.PUT_LINE(fisier,'');
UTL_FILE.FCLOSE(fisier);
end;


/
create or replace procedure scrie_view as
  fisier UTL_FILE.FILE_TYPE;
  cursor viewuri is
    SELECT DBMS_METADATA.GET_DDL('VIEW',view_name) as "text" FROM USER_views;
  v_viewuri viewuri%ROWTYPE;
begin
  fisier := UTL_FILE.FOPEN('ESECURI', 'vise.sql' , 'A');
  open viewuri;
    loop
      fetch viewuri into v_viewuri;
      exit when viewuri%NOTFOUND;
      if substr(v_viewuri."text",1) like '%"STUDENT".%'
        then
          UTL_FILE.PUT_LINE(fisier,'/');
          UTL_FILE.PUT_LINE(fisier,replace(v_viewuri."text",'"STUDENT".',''));
        else  
          UTL_FILE.PUT_LINE(fisier,v_viewuri."text");
      end if;
    end loop;
  close viewuri;
UTL_FILE.FCLOSE(fisier);
end;
/
declare
begin
  scrie;
  scrie_tabele;
  scrie_view;
end;
/
