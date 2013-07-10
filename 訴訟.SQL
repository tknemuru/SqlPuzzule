SELECT MAX_LIST.claim_id
     , CLS.patient_name
     , MAX_LIST.claim_status
  FROM (SELECT MAX_LE.claim_id
             , MAX_CSC.claim_status
             , MAX(MAX_CSC.claim_seq) OVER(PARTITION BY MAX_LE.claim_id, MAX_LE.defendant_name) AS [max_claim_seq]
          FROM dbo.LegalEvents AS MAX_LE
          LEFT JOIN dbo.ClaimStatusCodes AS MAX_CSC
            ON MAX_LE.claim_status = MAX_CSC.claim_status) AS MAX_LIST
  LEFT JOIN dbo.Claims AS CLS
    ON CLS.claim_id = MAX_LIST.claim_id
 ORDER BY MAX_LIST.max_claim_seq

/*
 GROUP BY claim_id
     , defendant_name
HAVING MAX_CSC.claim_seq = MAX(MAX_CSC.claim_seq)
*/




SELECT LE.claim_id
     , CLS.patient_name
     , LE.claim_status
  FROM dbo.LegalEvents AS LE
  LEFT JOIN dbo.Claims AS CLS
    ON CLS.claim_id = LE.claim_id
  LEFT JOIN dbo.ClaimStatusCodes AS CSC
    ON CSC.claim_status = LE.claim_status
 WHERE (SELECT MIN(MAX_CSC.claim_seq)
          FROM (SELECT MAX(MAX_CSC.claim_seq)
                  FROM dbo.LegalEvents AS MAX_LE
                  LEFT JOIN dbo.ClaimStatusCodes AS MAX_CSC
                    ON MAX_CSC.claim_status = MAX_LE.claim_status
                 WHERE 10 = MAX_LE.claim_id
                   AND LE.defendant_name = MAX_LE.defendant_name) AS MAX_LE
                  LEFT JOIN dbo.ClaimStatusCodes AS MAX_CSC
                    ON MAX_CSC.claim_status = MAX_LE.claim_status
                 WHERE 10 = MAX_LE.claim_id))



 = /*MAX*/(SELECT MAX(MAX_CSC.claim_seq)
                             FROM dbo.LegalEvents AS MAX_LE
                             LEFT JOIN dbo.ClaimStatusCodes AS MAX_CSC
                               ON MAX_CSC.claim_status = MAX_LE.claim_status
                            WHERE 10 = MAX_LE.claim_id
                              AND LE.defendant_name = MAX_LE.defendant_name)
   AND CSC.claim_seq = /*MIN*/(SELECT MIN(MAX_CSC.claim_seq)
                             FROM dbo.LegalEvents AS MAX_LE
                             LEFT JOIN dbo.ClaimStatusCodes AS MAX_CSC
                               ON MAX_CSC.claim_status = MAX_LE.claim_status
                            WHERE 10 = MAX_LE.claim_id)
