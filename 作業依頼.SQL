SELECT DISTINCT MAIN_PRO.workorder_id
  FROM dbo.Projects AS MAIN_PRO
 WHERE EXISTS(SELECT 1
                FROM dbo.Projects AS ZERO_PRO
               WHERE ZERO_PRO.workorder_id = MAIN_PRO.workorder_id
                 AND ZERO_PRO.step_nbr = 0
                 AND ZERO_PRO.step_status = 'C')
   AND NOT EXISTS(SELECT 1
                    FROM dbo.Projects AS NOT_PRO
                   WHERE NOT_PRO.workorder_id = MAIN_PRO.workorder_id
                     AND NOT_PRO.step_nbr <> 0
                     AND NOT_PRO.step_status = 'C')


SELECT workorder_id
  FROM dbo.Projects
 WHERE step_status = 'C'
 GROUP BY workorder_id
     , step_status
HAVING MAX(step_nbr) = 0
