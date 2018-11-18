set serveroutput on;

create or replace trigger burse
after insert or update of valoare or delete on note 
declare
  cursor spersamearga is
    (select nr_matricol from note) minus (select nr_matricol from note where valoare<=4);
  v_linie spersamearga%ROWTYPE;
  type an1 is table of number index by varchar2(5);
  v_an1 an1;
  type an2 is table of number index by varchar2(5);
  v_an2 an2;
  type an3 is table of number index by varchar2(5);
  v_an3 an3;
  type bursieri1 is table of number index by varchar2(5);
  v_bursieri1 bursieri1;
  type bursieri2 is table of number index by varchar2(5);
  v_bursieri2 bursieri2;
  type bursieri3 is table of number index by varchar2(5);
  v_bursieri3 bursieri3;
  v_anul number;
  v_medie number;
  v_asd number;
  v_haiodata number;
  v_max1 number;
  v_max1_val number;
  v_max2 number;
  v_max2_val number;
  v_max3 number;
  v_max3_val number;
  v_c1 number :=0;
  v_c2 number :=0;
  v_c3 number :=0;
begin

  open spersamearga;
    loop
      fetch spersamearga into v_linie;
      exit when spersamearga%NOTFOUND;
      
      v_haiodata := v_linie.nr_matricol;
      select an into v_anul from studenti where v_linie.nr_matricol=nr_matricol;
      if(v_anul=1)
        then
          select avg(valoare) into v_medie from note where nr_matricol=v_linie.nr_matricol;
          v_an1(v_haiodata):= v_medie;
        else if(v_anul=2)
          then
            select avg(valoare) into v_medie from note where nr_matricol=v_linie.nr_matricol;
            v_an2(v_haiodata):= v_medie;
          else if(v_anul=3)
            then
              select avg(valoare) into v_medie from note where nr_matricol=v_linie.nr_matricol;
              v_an3(v_haiodata):= v_medie;
          end if;
        end if;
      end if;
      
    end loop;
  close spersamearga;
  
  v_an1('0'):=0;
  v_asd:=v_an1.first;
  v_max1:=v_asd;
  loop
    --dbms_output.put_line(v_asd||' '||v_an1(v_asd));
    if(v_an1(v_max1)<v_an1(v_asd))
      then
        v_max1:=v_asd;
    end if;
    exit when v_asd=v_an1.last;
    v_asd:=v_an1.next(v_asd);
  end loop;
  v_max1_val:=v_an1(v_max1);

  v_asd:=v_an2.first;
  v_max2:=v_asd;
  v_max2_val:=0;
  loop
    --dbms_output.put_line(v_asd||' '||v_an2(v_asd));
    if(v_an2(v_max2)<v_an2(v_asd))
      then
        v_max2:=v_asd;
    end if;
    exit when v_asd=v_an2.last;
    v_asd:=v_an2.next(v_asd);
  end loop;
  v_max2_val:=v_an2(v_max2);
 
    --dbms_output.put_line(' ');
      
  v_asd:=v_an3.first;
  v_max3:=v_asd;
  loop
    --dbms_output.put_line(v_asd||' '||v_an3(v_asd));
    if(v_an3(v_max3)<v_an3(v_asd))
      then
        v_max3:=v_asd;
    end if;
    exit when v_asd=v_an3.last;
    v_asd:=v_an3.next(v_asd);
  end loop;
  v_max3_val:=v_an3(v_max3); 

   --dbms_output.put_line(' ');
   
  v_asd:=v_an1.first;
  loop
    if(v_max1_val!=0) and (v_an1(v_asd)=v_max1_val)
      then
        v_bursieri1(v_asd):=v_max1_val;
        v_c1:=v_c1+1;
    end if;
    exit when v_asd=v_an1.last;
    v_asd:=v_an1.next(v_asd);
  end loop;

  v_asd:=v_an2.first;
  loop
    if(v_max2_val!=0) and (v_an2(v_asd)=v_max2_val)
      then
        v_bursieri2(v_asd):=v_max2_val;
        v_c2:=v_c2+1;
    end if;
    exit when v_asd=v_an2.last;
    v_asd:=v_an2.next(v_asd);
  end loop;
  
    v_asd:=v_an3.first;
  loop
    if(v_max3_val!=0) and (v_an3(v_asd)=v_max3_val)
      then
        v_bursieri3(v_asd):=v_max3_val;
        v_c3:=v_c3+1;
    end if;
    exit when v_asd=v_an3.last;
    v_asd:=v_an3.next(v_asd);
  end loop;
/*
  v_asd:=v_bursieri2.first;
  loop
    dbms_output.put_line(v_asd||' '||v_bursieri2(v_asd));
    exit when v_asd=v_bursieri2.last;
    v_asd:=v_bursieri2.next(v_asd);
  end loop;
*/
--dbms_output.put_line(v_c1||' '||v_c2||' '||v_c3);

  if(v_c1>0 and v_c2>0 and v_c3>0)
    then
      v_asd:=v_bursieri1.first;
      loop
        update studenti
          set bursa = (1000/3)/v_c1
          where nr_matricol=v_asd;    
        exit when v_asd=v_an1.last;
        v_asd:=v_an1.next(v_asd);
      end loop;

      v_asd:=v_bursieri2.first;
      loop
        update studenti
          set bursa = (1000/3)/v_c2
          where nr_matricol=v_asd;    
        exit when v_asd=v_an2.last;
        v_asd:=v_an2.next(v_asd);
      end loop;
      
      v_asd:=v_bursieri3.first;
      loop
        update studenti
          set bursa = (1000/3)/v_c3
          where nr_matricol=v_asd;    
        exit when v_asd=v_an3.last;
        v_asd:=v_an3.next(v_asd);
      end loop;
  end if;
  
   if(v_c1<=0 and v_c2>0 and v_c3>0)
    then
      v_asd:=v_bursieri2.first;
      loop
        update studenti
          set bursa = (1000/2)/v_c2
          where nr_matricol=v_asd;    
        exit when v_asd=v_an2.last;
        v_asd:=v_an2.next(v_asd);
      end loop;
      
      v_asd:=v_bursieri3.first;
      loop
        update studenti
          set bursa = (1000/2)/v_c3
          where nr_matricol=v_asd;    
        exit when v_asd=v_an3.last;
        v_asd:=v_an3.next(v_asd);
      end loop;
  end if;
  
    if(v_c1>0 and v_c2<=0 and v_c3>0)
    then
      v_asd:=v_bursieri1.first;
      loop
        update studenti
          set bursa = (1000/2)/v_c1
          where nr_matricol=v_asd;    
        exit when v_asd=v_an1.last;
        v_asd:=v_an1.next(v_asd);
      end loop;
      
      v_asd:=v_bursieri3.first;
      loop
        update studenti
          set bursa = (1000/2)/v_c3
          where nr_matricol=v_asd;    
        exit when v_asd=v_an3.last;
        v_asd:=v_an3.next(v_asd);
      end loop;
  end if;

  if(v_c1>0 and v_c2>0 and v_c3<=0)
    then
      v_asd:=v_bursieri1.first;
      loop
        update studenti
          set bursa = (1000/2)/v_c1
          where nr_matricol=v_asd;    
        exit when v_asd=v_an1.last;
        v_asd:=v_an1.next(v_asd);
      end loop;

      v_asd:=v_bursieri2.first;
      loop
        update studenti
          set bursa = (1000/2)/v_c2
          where nr_matricol=v_asd;    
        exit when v_asd=v_an2.last;
        v_asd:=v_an2.next(v_asd);
      end loop;
  end if;
  
    if(v_c1>0 and v_c2<=0 and v_c3<=0)
    then
      v_asd:=v_bursieri1.first;
      loop
        update studenti
          set bursa = 1000/v_c1
          where nr_matricol=v_asd;    
        exit when v_asd=v_an1.last;
        v_asd:=v_an1.next(v_asd);
      end loop;
    end if;
    
    if(v_c1<=0 and v_c2>0 and v_c3<=0)
    then
      v_asd:=v_bursieri2.first;
      loop
        update studenti
          set bursa = 1000/v_c2
          where nr_matricol=v_asd;    
        exit when v_asd=v_an2.last;
        v_asd:=v_an2.next(v_asd);
      end loop;
      end if;

  if(v_c1<=0 and v_c2<=0 and v_c3>0)
    then
      v_asd:=v_bursieri3.first;
      loop
        update studenti
          set bursa = 1000/v_c3
          where nr_matricol=v_asd;    
        exit when v_asd=v_an3.last;
        v_asd:=v_an3.next(v_asd);
      end loop;
  end if;  
end;