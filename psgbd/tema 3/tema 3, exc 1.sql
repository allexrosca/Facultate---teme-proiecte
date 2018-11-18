set serveroutput on;

drop table zodiac;
create table zodiac(data_inceput VARCHAR2(30), data_sfarsit DATE, denumire_zodie VARCHAR2(20));
insert into zodiac values('21-MAR-97','19-APR-97','berbec');
insert into zodiac values('20-APR-97','20-MAY-97','taur');
insert into zodiac values('21-MAY-97','20-JUN-97','gemeni');
insert into zodiac values('21-JUN-97','22-JUL-97','rac');
insert into zodiac values('23-JUL-97','22-AUG-97','leu');
insert into zodiac values('23-AUG-97','22-SEP-97','fecioara');
insert into zodiac values('23-SEP-97','22-OCT-97','balanta');
insert into zodiac values('23-OCT-97','21-NOV-97','scorpion');
insert into zodiac values('22-NOV-97','21-DEC-97','sagetator');
insert into zodiac values('22-DEC-97','31-DEC-97','capricorn');
insert into zodiac values('01-JAN-97','19-JAN-97','capricorn');
insert into zodiac values('20-JAN-97','18-FEB-97','varsator');
insert into zodiac values('19-FEB-97','20-MAR-97','pesti');
DECLARE
  CURSOR lista_zodie IS SELECT * FROM zodiac;
  CURSOR lista_nume IS SELECT * from utilizatori;
BEGIN
    FOR v_index1 IN lista_zodie 
      LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE(v_index1.denumire_zodie);
        DBMS_OUTPUT.PUT_LINE('----');
        FOR v_index2 IN lista_nume
          LOOP
            IF((v_index2.data_nastere >= v_index1.data_inceput) AND  (v_index2.data_nastere <= v_index1.data_sfarsit))
              THEN
                DBMS_OUTPUT.PUT_LINE(v_index2.nume);
              END IF;
          END LOOP;
      END LOOP;  
END;
--test
--select denumire_zodie,count(nume) from utilizatori u join zodiac z on u.data_nastere between z.data_inceput AND z.data_sfarsit group by denumire_zodie;