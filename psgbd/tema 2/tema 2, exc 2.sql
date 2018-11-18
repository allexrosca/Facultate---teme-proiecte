set serveroutput on;
<<global>>
DECLARE 
  v_id NUMBER := 10;
  v_nume VARCHAR(20) := 'Popescu';
BEGIN
  DBMS_OUTPUT.PUT_LINE('v_nume are valoarea = ' || v_nume); --va afisa Popescu--
  DBMS_OUTPUT.PUT_LINE('v_id are valoarea = ' || v_id); --va afisa 10--
  DECLARE
    v_id NUMBER := 20;
    v_nume VARCHAR(20) := 'Andrei';
  BEGIN
    DBMS_OUTPUT.PUT_LINE('v_nume are valoarea = ' || v_nume); --va afisa Andrei--
    DBMS_OUTPUT.PUT_LINE('v_id are valoarea = ' || v_id); --va afisa 20--
    DECLARE
      v_id NUMBER:= 5;
      v_nume VARCHAR(20) := 'Marian';
    BEGIN
      DBMS_OUTPUT.PUT_LINE('v_nume are valoarea = ' || global.v_nume); --va afisa Popescu--
      DBMS_OUTPUT.PUT_LINE('v_id are valoarea = ' || global.v_id);  --va afisa 10--
    END;
  END;
END;
    