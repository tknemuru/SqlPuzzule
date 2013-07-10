CREATE TABLE Pensions
( [sin] CHAR(10) NOT NULL,
  pen_year INTEGER NOT NULL,
  month_cnt INTEGER DEFAULT 0 NOT NULL
       CHECK(month_cnt BETWEEN 0 AND 12),
  earnings DECIMAL(8,2) DEFAULT 0.00 NOT NULL
);



CREATE VIEW PensionStartYear([sin], start_year) AS
SELECT MAIN_PEN.[sin]
     , MAX(MAIN_PEN.pen_year) + 1
  FROM Pensions AS MAIN_PEN
 WHERE MAIN_PEN.month_cnt = 0
   AND ISNULL((SELECT SUM(CHK_MAIN_PEN.earnings)
                 FROM Pensions AS CHK_MAIN_PEN
                WHERE CHK_MAIN_PEN.[sin] = MAIN_PEN.[sin]
                  AND CHK_MAIN_PEN.pen_year = MAIN_PEN.pen_year + 2
                GROUP CHK_MAIN_PEN.[sin]), 0) < 60
 GROUP BY [sin]
 UNION ALL
SELECT MAIN_PEN.[sin]
     , MIN(MAIN_PEN.pen_year)
  FROM Pensions AS MAIN_PEN
 WHERE MAIN_PEN.month_cnt = 0
   AND ISNULL((SELECT SUM(CHK_MAIN_PEN.earnings)
                 FROM Pensions AS CHK_MAIN_PEN
                WHERE CHK_MAIN_PEN.[sin] = MAIN_PEN.[sin]
                  AND CHK_MAIN_PEN.pen_year = MAIN_PEN.pen_year + 2
                GROUP CHK_MAIN_PEN.[sin]), 0) < 60




SELECT MAIN_PEN.[sin]
     , SUM(MAIN_PEN.month_cnt)
     , SUM(MAIN_PEN.earnings)
  FROM Pensions AS MAIN_PEN
 WHERE MAIN_PEN.pen_year = MAX(SELECT MAX_CHK_PEN.pen_year
                              FROM Pensions AS MAX_CHK_PEN
                              LEFT JOIN PensionStartYear MAX_CHK_PSY
                                ON MAX_CHK_PSY.[sin] = MAX_CHK_PEN.[sin]
                             WHERE MAX_CHK_PEN.[sin] = MAIN_PEN.[sin]
                               AND MAX_CHK_PEN.pen_year >= MAX_CHK_PSY.pen_year)
   AND (SELECT ISNULL(SUM(SIXTY_CHK_PEN.month_cnt), 0)
          FROM Pensions AS SIXTY_CHK_PEN
         WHERE SIXTY_CHK_PEN.[sin] = MAIN_PEN.[sin]
           AND SIXTY_CHK_PEN.pen_year = MAIN_PEN.pen_year + 1) < 60







-- 回答
CREATE VIEW PensionStartYear([sin], start_year) AS
SELECT MAIN_PEN.[sin]
     , MAX(MAIN_PEN.pen_year) + 1
  FROM Pensions AS MAIN_PEN
 WHERE MAIN_PEN.earnings = 0
 GROUP BY MAIN_PEN.[sin]
 UNION ALL
SELECT MAIN_PEN.[sin]
     , MIN(MAIN_PEN.pen_year)
  FROM Pensions AS MAIN_PEN
 WHERE NOT EXISTS(SELECT 1
                    FROM Pensions AS ZERO_CHK_PEN
                   WHERE ZERO_CHK_PEN.[sin] = MAIN_PEN.[sin]
                     AND ZERO_CHK_PEN.earnings = 0)
 GROUP BY MAIN_PEN.[sin]

SELECT MAIN_PEN.[sin]
     , SUM(MAIN_PEN.month_cnt) AS month_sum
     , SUM(MAIN_PEN.earnings) AS earnings_sum
     , CASE WHEN SUM(MAIN_PEN.month_cnt) >= 60
            THEN '○'
            ELSE '×'
        END AS is_given
  FROM Pensions AS MAIN_PEN
 WHERE MAIN_PEN.pen_year >= (SELECT MAX_CHK_PSY.start_year
                               FROM PensionStartYear AS MAX_CHK_PSY
                              WHERE MAX_CHK_PSY.[sin] = MAIN_PEN.[sin])
   AND (SELECT ISNULL(SUM(SIXTY_CHK_PEN.month_cnt), 0)
          FROM Pensions AS SIXTY_CHK_PEN
         WHERE SIXTY_CHK_PEN.[sin] = MAIN_PEN.[sin]
           AND SIXTY_CHK_PEN.pen_year >= MAIN_PEN.pen_year + 1) < 60
 GROUP BY MAIN_PEN.[sin]
 ORDER BY MAIN_PEN.[sin]