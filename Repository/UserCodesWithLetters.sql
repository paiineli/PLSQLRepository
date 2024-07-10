-- PL/SQL query for extracts information about healthcare service providers registered in a system which have user codes as letters.
-- Author: Lucas Paineli

SELECT Y.PROVIDER, Y.USERNAME, Y.EMPLOYEE, Y.OBSERVATION
  FROM (SELECT X.PROVIDER, X.USERNAME, X.EMPLOYEE, X.OBSERVATION
          FROM (SELECT DISTINCT REGEXP_REPLACE(A.MEMBER_CODE,
                                               '[^A-Za-z]') AS PROVIDER,
                                B.USER_NAME AS USERNAME,
                                UPPER(B.FIRST_NAME || ' ' || B.LAST_NAME) AS EMPLOYEE,
                                D.MEMBER_TITLE AS OBSERVATION
                  FROM STAFF_ROLES@TRIAL A,
                       EMPLOYEES@TRIAL             B,
                       EMPLOYEES@TRIAL             C,
                       BD_USER@TRIAL              D
                 WHERE A.MEMBER_CODE = B.SHORT_CODE
                   AND B.CHANGE_NR = C.CHANGE_NR
                   AND B.USER_NAME = D.USER_NAME
                   AND D.ACCOUNT_STATUS IN ('OPEN', 'EXPIRED')
                   AND B.USER_NAME NOT IN
                       ('USER1',
                        'USER2',
                        'USER3',
                        'USER4')
                 GROUP BY A.MEMBER_CODE,
                          B.USER_NAME,
                          B.FIRST_NAME,
                          B.LAST_NAME,
                          D.MEMBER_TITLE) X) Y
 WHERE Y.PROVIDER IS NOT NULL
 ORDER BY Y.PROVIDER ASC
