set serveroutput on;
create or replace package intrebari as
  function puturos (p_id number) return number;
  function relevanta(p_id number) return number;
  function relevanta(p_username users.username%TYPE) return number;
end intrebari;
/
create or replace package body intrebari as

  function esteUtilizatorul(p_nume users.username%TYPE) 
  return number as
    v_nume varchar2(255) :=0;
  begin
    select name into v_nume from users where p_nume=username;
    if(v_nume = '0') 
      then
        return 0;
    else return 1;
    end if;
  end esteUtilizatorul;

  function puturos (p_id number)
  return number as
    v_intrebari_rezolvate integer;
    v_intrebari_totale integer;
    v_flag users.id%TYPE :=1;
  begin
    select count(question_id) into v_intrebari_rezolvate from answers where solved='1' and user_id=p_id;
    select count(question_id) into v_intrebari_totale from answers where user_id=p_id;
    if (v_intrebari_rezolvate < v_intrebari_totale/2)
      then 
        v_flag:=0;
    end if;
    return v_flag;
  end puturos;
  
  
  function relevanta(p_id number) 
  return number as
    v_intrebata integer;
    v_nr_rasp_corecte integer :=0;
    v_flag number :=1;
    cursor rasp_corecte is
      select * from answers where solved='1' and question_id=p_id;
    v_linie rasp_corecte%ROWTYPE;
  begin
    select count(question_id) into v_intrebata from answers where question_id=p_id;
    open rasp_corecte;
    loop
      fetch rasp_corecte into v_linie;
      exit when rasp_corecte%NOTFOUND;
      if (puturos(v_linie.user_id) = 1) 
        then 
          v_nr_rasp_corecte:=v_nr_rasp_corecte + 1;
      end if;
    end loop;
    close rasp_corecte;
    if ((v_intrebata<20) OR (v_nr_rasp_corecte<(3/10*v_intrebata)) OR (v_nr_rasp_corecte>(9/10*v_intrebata)))
      then 
        v_flag:=0;
    else 
      v_flag:=v_intrebata;
    end if;
    return v_flag;
  end relevanta;
  
  
   function relevanta(p_username users.username%TYPE) 
    return number as
    p_id number;
    v_intrebata integer;
    v_nr_rasp_corecte integer :=0;
    v_flag number :=1;
    v_max number :=0;
    cursor rasp_corecte is
      select * from answers where solved=1 and question_id=p_id;
    cursor intrebari_studenti is
      select q.id from users u join questions q on u.id=q.user_id where u.username=p_username; 
    v_linie rasp_corecte%ROWTYPE;
    v_linie2 intrebari_studenti%ROWTYPE;
  begin
    if(esteUtilizatorul(p_username)= '0')
      then
        return 0;
    end if;
    open intrebari_studenti;
      loop
        fetch intrebari_studenti into v_linie2;
        exit when intrebari_studenti%NOTFOUND;
        p_id:=v_linie2.id;
        select count(question_id) into v_intrebata from answers where question_id=p_id;
        open rasp_corecte;
          loop
            fetch rasp_corecte into v_linie;
            exit when rasp_corecte%NOTFOUND;
            if (puturos(v_linie.user_id) = 1) 
              then 
                v_nr_rasp_corecte:=v_nr_rasp_corecte + 1;
            end if;
          end loop;
        close rasp_corecte;
        if ((v_intrebata<20) OR (v_nr_rasp_corecte<(3/10*v_intrebata)) OR (v_nr_rasp_corecte>(9/10*v_intrebata)))
          then 
            v_flag:=0;
        else 
          v_flag:=v_intrebata;
        end if;
        if (v_max < v_flag) 
          then 
            v_max := v_flag;
        end if;
      end loop;
    close intrebari_studenti;
    return v_max;
  end relevanta;
  
  
end intrebari;