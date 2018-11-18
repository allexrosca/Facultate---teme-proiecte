set serveroutput on;

declare
  TYPE utilizator IS RECORD (nume varchar2(255), prenume varchar2(255));
  v_utilizator1 utilizator;
  v_utilizator2 utilizator;
  v_utilizator3 utilizator;
  
  TYPE utilizatori2 IS TABLE OF utilizator INDEX BY PLS_INTEGER;
  v_utilizatori utilizatori2;
  
  procedure calcul(p_utilizatori in utilizatori2) as
    v_username varchar2(255):='0';
    cursor intr is select q.id from questions q join users u on q.user_id=u.id where u.username like '%'||v_username||'%';
    v_linie intr%ROWTYPE;
    v_count integer :=0;
    begin
      for i in p_utilizatori.first..p_utilizatori.last
        loop
          v_username := p_utilizatori(i).prenume||'.'||p_utilizatori(i).nume;
          dbms_output.put_line('------------------------------');
          dbms_output.put_line('Username: '||v_username);
          v_count:=0;
          open intr;
            loop
              fetch intr into v_linie;
              exit when intr%NOTFOUND;
              if(intrebari.relevanta(v_linie.id) > 0)
                then
                  v_count:=v_count + 1;
              end if;
            end loop;
            dbms_output.put_line('Numar intrebari cu relevanta > 0 :  '||v_count);
            dbms_output.put_line('------------------------------');
            dbms_output.put_line('');
          close intr;
        end loop;
      
      
    end calcul;
    
begin
  v_utilizator1.prenume := 'alexandru';
  v_utilizator1.nume := 'rosca';
  v_utilizator2.prenume := 'ilie';
  v_utilizator2.nume := 'grosu';
  v_utilizator3.prenume := 'marius';
  v_utilizator3.nume := 'toma';
  v_utilizatori(1):=v_utilizator1;
  v_utilizatori(2):=v_utilizator2;
  v_utilizatori(3):=v_utilizator3;
  calcul(v_utilizatori);
end;