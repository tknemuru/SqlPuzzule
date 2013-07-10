-- 回答
UPDATE TGT_BGS
   SET TGT_BGS.badge_status = 'A'
  FROM Badges AS TGT_BGS
 WHERE EXISTS(SELECT 1
                FROM Badges AS CHK_BGS
               WHERE CHK_BGS.badge_nbr = TGT_BGS.badge_nbr
                 AND CHK_BGS.issued_date = (SELECT MAX(issued_date)
                                              FROM Badges AS MAX_BGS
                                             WHERE MAX_BGS.emp_id = CHK_BGS.emp_id
                                             -- ↓一応つけとく
                                             GROUP BY MAX_BGS.emp_id)
                 AND NOT EXISTS(SELECT 1
                                  FROM Badges AS A_BGS
                                 WHERE A_BGS.emp_id = CHK_BGS.emp_id
                                   AND A_BGS.badge_status = 'A')
             )