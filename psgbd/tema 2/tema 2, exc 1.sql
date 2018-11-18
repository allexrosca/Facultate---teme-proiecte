set serveroutput on;
DECLARE
 v_caractere_introduse users.name%TYPE := &v_caractere;
 v_numar_studenti NUMBER := 1;
 v_id users.id%TYPE :=1;
 v_nume_familie users.name%TYPE :=1;
 v_prenume users.name%TYPE := 1;
 v_nr_intrebari_puse NUMBER := 1;
 
BEGIN
  select count(id) into v_numar_studenti from users where lower(name) like '%'||v_caractere_introduse||'%';
  DBMS_OUTPUT.PUT_LINE('Numarul studentilor care au in componenta numelui sirul de caractere '||'"'||v_caractere_introduse||'"'||' este '||v_numar_studenti);
  BEGIN
  select id,initcap(NVL(SUBSTR(username, 0, INSTR(username, '.')-1), username)),upper(NVL(SUBSTR(username, INSTR(username, '.')+1), username)) into v_id,v_prenume,v_nume_familie from (select id,username from users where lower(name) like '%'||v_caractere_introduse||'%' order by dbms_random.random) where rownum<2;
  select count(id) into v_nr_intrebari_puse from questions where questions.user_id=v_id and reported < 5;
  DBMS_OUTPUT.PUT_LINE('Un student ales aleator din lista de mai sus are urmatoarele informatii: ');
  DBMS_OUTPUT.PUT_LINE('ID: '||v_id);
  DBMS_OUTPUT.PUT_LINE('Numele de familie: '||v_nume_familie);
  DBMS_OUTPUT.PUT_LINE('Prenumele: '||v_prenume);
  DBMS_OUTPUT.PUT_LINE('Numarul de intrebari puse: '||v_nr_intrebari_puse);
  END; 
END;