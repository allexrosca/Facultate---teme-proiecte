set serveroutput on;

DECLARE
  TYPE vector IS VARRAY(5) Of PLS_INTEGER;
  TYPE matrice_l IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  TYPE matrice_c IS TABLE OF matrice_l INDEX BY PLS_INTEGER;  
  v_matrice1 matrice_c;
  v_matrice2 matrice_c;
  v_matrice3 matrice_c;
  v_randomi integer;
  v_randomj integer;
  v_randomk integer;
  v_vector1 vector;
  v_vector2 vector;
  v_vector3 vector;

BEGIN

  v_randomi :=dbms_random.value(2,5);
  v_randomj :=dbms_random.value(2,5);
  v_randomk :=dbms_random.value(2,5);
  
  for i in 1..v_randomi
    loop
      for j in 1..v_randomj
        loop
          v_matrice1(i)(j) := dbms_random.value(0,30);
        end loop;
    end loop;

  v_vector2:=vector(0,0,0,0,0);
  for i in 1..v_randomi
    loop
      for j in 1..v_randomj
        loop
          if(length(to_char(v_matrice1(i)(j))) > v_vector2(j)) 
            then
              v_vector2(j) := length(to_char(v_matrice1(i)(j)));
          end if;
        end loop;
    end loop;

  for j in 1..v_randomj
    loop
      for k in 1..v_randomk
        loop
          v_matrice2(j)(k) := dbms_random.value(0,30);
        end loop;
    end loop;
  
  v_vector3:=vector(0,0,0,0,0);
  for j in 1..v_randomj
    loop
      for k in 1..v_randomk
        loop
          if(length(to_char(v_matrice2(j)(k))) > v_vector3(k)) 
            then
              v_vector3(k) := length(to_char(v_matrice2(j)(k)));
          end if;
        end loop;
    end loop;  
  
  for i in 1..v_randomi
    loop
      for k in 1..v_randomk
        loop
          v_matrice3(i)(k) := 0 ;
        end loop;
    end loop;
  
  for i in 1..v_randomi
    loop
      for k in 1..v_randomk
        loop
          for j in 1..v_randomj
            loop
              v_matrice3(i)(k) := v_matrice3(i)(k) + v_matrice1(i)(j) * v_matrice2(j)(k);
            end loop;
        end loop;
    end loop;

  v_vector1:=vector(0,0,0,0,0);
  for i in 1..v_randomi
    loop
      for k in 1..v_randomk
        loop
          if(length(to_char(v_matrice3(i)(k))) > v_vector1(k)) 
            then
              v_vector1(k) := length(to_char(v_matrice3(i)(k)));
          end if;
        end loop;
    end loop;
  

  dbms_output.put_line('');    
  dbms_output.put_line('');
  dbms_output.put_line('-----------------------------------------------');
  dbms_output.put_line('Numarul de linii a primei matrice: '||v_randomi);
  dbms_output.put_line('Numarul de coloane a primei matrice: '||v_randomj);
  dbms_output.put('Prima matrice: ');
  
  for i in 1..v_randomi
    loop
       dbms_output.put_line('');
      for j in 1..v_randomj
        loop
          dbms_output.put(lpad(v_matrice1(i)(j),v_vector2(j))||' ');
        end loop;
    end loop; 
  dbms_output.put_line('');    
  
  dbms_output.put_line('');
  dbms_output.put_line('-----------------------------------------------');
  dbms_output.put_line('Numarul de linii a celei de a doua matrice: '||v_randomj);
  dbms_output.put_line('Numarul de coloane a celei de a doua matrice: '||v_randomk);
  dbms_output.put('A doua matrice: ');   

  for j in 1..v_randomj
    loop
       dbms_output.put_line('');
      for k in 1..v_randomk
        loop
          dbms_output.put(lpad(v_matrice2(j)(k),v_vector3(k))||' ');
        end loop;
    end loop;  
  dbms_output.put_line('');    
  
  dbms_output.put_line('');
  dbms_output.put_line('-----------------------------------------------');
  dbms_output.put_line('Numarul de liniia celei de a treia matrice: : '||v_randomi);
  dbms_output.put_line('Numarul de coloane a celei de a treia matrice: '||v_randomk);  
  dbms_output.put('Rezultatul inmultirii primei matrici cu cea dea doua: ');    
    
  for i in 1..v_randomi
    loop
      dbms_output.put_line(''); 
      for k in 1..v_randomk
        loop
          dbms_output.put(lpad(v_matrice3(i)(k),v_vector1(k),' ')||' ');
        end loop;
    end loop;
  dbms_output.put_line('');

END;