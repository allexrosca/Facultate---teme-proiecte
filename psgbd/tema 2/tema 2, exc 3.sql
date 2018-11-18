set serveroutput on;
DECLARE
  c_utilizator1 CONSTANT NUMBER := 864;
  c_utilizator2 CONSTANT NUMBER := 865;
  v_nr_intrebari_puse1 NUMBER := 1; --1 vine de la utilizatorul numarul 1--
  v_nr_intrebari_puse2 NUMBER := 1; --2 vine de la utilizatorul numarul 2--
  v_nr_intrebari_raspunse1 NUMBER :=1;
  v_nr_intrebari_raspunse2 NUMBER :=1;
BEGIN
  select count(id) into v_nr_intrebari_puse1 from questions where user_id=c_utilizator1;
  select count(id) into v_nr_intrebari_puse2 from questions where user_id=c_utilizator2;
  select count(solved) into v_nr_intrebari_raspunse1 from answers where user_id=c_utilizator1 and solved=1;
  select count(solved) into v_nr_intrebari_raspunse2 from answers where user_id=c_utilizator2 and solved=1;
  IF(v_nr_intrebari_puse1 > v_nr_intrebari_puse2)
    THEN DBMS_OUTPUT.PUT_LINE('Studentul cu id-ul '||c_utilizator1||' a pus mai multe intrebari decat utilizatorul cu id-ul '||c_utilizator2);
  ELSE
    IF(v_nr_intrebari_puse1 < v_nr_intrebari_puse2)
      THEN DBMS_OUTPUT.PUT_LINE('Studentul cu id-ul '||c_utilizator2||' a pus mai multe intrebari decat utilizatorul cu id-ul '||c_utilizator1);
    ELSE
      IF(v_nr_intrebari_raspunse1 > v_nr_intrebari_raspunse2)
        THEN DBMS_OUTPUT.PUT_LINE('Ambii studenti au postat acelasi numar de intrebari dar utilizatorul cu id-ul '||c_utilizator1||' a raspuns la mai multe intrebari fata de utilizatorul cu id-ul '||c_utilizator2);
      ELSE
        IF(v_nr_intrebari_raspunse1 < v_nr_intrebari_raspunse2)
          THEN DBMS_OUTPUT.PUT_LINE('Ambii studenti au postat acelasi numar de intrebari dar utilizatorul cu id-ul '||c_utilizator2||' a raspuns la mai multe intrebari fata de utilizatorul cu id-ul '||c_utilizator1);
        ELSE
          DBMS_OUTPUT.PUT_LINE('Ambii studenti au postat acelasi numar de intrebari si au raspuns la acelasi numar de intrebari');
        END IF;
      END IF;
    END IF;
  END IF;
        
END;