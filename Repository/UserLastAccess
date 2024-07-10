"""This SQL query extracts information about healthcare service providers registered in a system, including their recent access details and additional account information."""

SELECT X.PROVIDER,
       X.USERNAME,
       X.EMPLOYEE,
       X.OBSERVATION,
       X.LAST_ACCESS
  FROM (SELECT DISTINCT A.MEMBER_CODE AS PROVIDER,
                        B.USER_NAME AS USERNAME,
                        UPPER(B.FIRST_NAME || ' ' || B.LAST_NAME) AS EMPLOYEE,
                        D.MEMBER_TITLE AS OBSERVATION,
                        MAX(TRUNC(E.LOGOFF_TIME)) AS LAST_ACCESS
          FROM STAFF_ROLES@TRIAL A,
               EMPLOYEES@TRIAL    B,
               EMPLOYEES@TRIAL    C,
               BD_USER@TRIAL      D,
               AUDIT_LOG@TRIAL    E
         WHERE A.MEMBER_CODE = B.SHORT_CODE
           AND B.CHANGE_NR = C.CHANGE_NR
           AND B.USER_NAME = D.USER_NAME
           AND B.USER_NAME = E.USER_ID
           AND D.ACCOUNT_STATUS IN ('OPEN', 'EXPIRED')
           AND B.USER_NAME NOT IN ('USER1', 'USER2', 'USER3', 'USER4', 'TRAINING')
         GROUP BY A.MEMBER_CODE,
                  B.USER_NAME,
                  B.FIRST_NAME,
                  B.LAST_NAME,
                  D.MEMBER_TITLE) X
 WHERE X.LAST_ACCESS <= (SYSDATE - 90)
 ORDER BY X.PROVIDER DESC;
