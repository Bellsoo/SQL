-- Fonction GET_NB_WORKERS
CREATE OR REPLACE FUNCTION GET_NB_WORKERS(FACTORY_ID NUMBER) RETURN NUMBER IS
  worker_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO worker_count
  FROM WORKERS_FACTORY_1
  WHERE id = FACTORY_ID;

  RETURN worker_count;
END;
/

-- Fonction GET_NB_BIG_ROBOTS
CREATE OR REPLACE FUNCTION GET_NB_BIG_ROBOTS RETURN NUMBER IS
  robot_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO robot_count
  FROM ROBOTS_HAS_SPARE_PARTS
  GROUP BY robot_id
  HAVING COUNT(spare_part_id) > 3;

  RETURN robot_count;
END;
/

-- Fonction GET_BEST_SUPPLIER
CREATE OR REPLACE FUNCTION GET_BEST_SUPPLIER RETURN VARCHAR2 IS
  supplier_name VARCHAR2(100);
BEGIN
  SELECT name
  INTO supplier_name
  FROM BEST_SUPPLIERS
  WHERE ROWNUM = 1;

  RETURN supplier_name;
END;
/

-- Procédure SEED_DATA_WORKERS
CREATE OR REPLACE PROCEDURE SEED_DATA_WORKERS(NB_WORKERS NUMBER, FACTORY_ID NUMBER) AS
BEGIN
  FOR i IN 1..NB_WORKERS LOOP
    INSERT INTO WORKERS_FACTORY_1 (first_name, last_name, start_date)
    VALUES ('worker_f_' || i, 'worker_l_' || i, TRUNC(DBMS_RANDOM.VALUE(TO_DATE('2065-01-01', 'YYYY-MM-DD'), TO_DATE('2070-01-01', 'YYYY-MM-DD'))));
  END LOOP;
END;
/

-- Procédure ADD_NEW_ROBOT
CREATE OR REPLACE PROCEDURE ADD_NEW_ROBOT(MODEL_NAME VARCHAR2) AS
BEGIN
  INSERT INTO ROBOTS (model)
  VALUES (MODEL_NAME);
END;
/