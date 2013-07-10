-- 回答
-- ビューの作成
CREATE VIEW EmptySeats(start_seat) AS
SELECT MAIN_RST.seat + 1
  FROM Restaurant MAIN_RST
 WHERE NOT EXISTS(SELECT 1
                    FROM Restaurant CHK_RST
                   WHERE CHK_RST.seat = MAIN_RST.seat + 1)
   AND MAIN_RST.seat < 1000
 UNION
SELECT 1
  FROM Restaurant MAIN_RST
 WHERE NOT EXISTS(SELECT 1
                    FROM Restaurant CHK_RST
                   WHERE CHK_RST.seat = 1)

-- セレクト文
SELECT START_EMP.start_seat
     , MIN(ISNULL(END_EMP.seat - 1, 1000)) AS end_date
  FROM EmptySeats AS START_EMP
  LEFT JOIN Restaurant AS END_EMP
    ON END_EMP.seat > START_EMP.start_seat
 GROUP BY START_EMP.start_seat



--○1番：1年間はたらかなった後、5年間フルにﾉ働いた
INSERT INTO Pensions VALUES('1', 2006, 12, 10);
INSERT INTO Pensions VALUES('1', 2005, 12, 10);
INSERT INTO Pensions VALUES('1', 2004, 12, 10);
INSERT INTO Pensions VALUES('1', 2003, 12, 10);
INSERT INTO Pensions VALUES('1', 2002, 12, 10);
INSERT INTO Pensions VALUES('1', 2001,  0,  0);

--○2番：10ヶ月 * 6年間
INSERT INTO Pensions VALUES('2', 2006, 10, 1);
INSERT INTO Pensions VALUES('2', 2005, 10, 1);
INSERT INTO Pensions VALUES('2', 2004, 10, 1);
INSERT INTO Pensions VALUES('2', 2003, 10, 1);
INSERT INTO Pensions VALUES('2', 2002, 10, 1);
INSERT INTO Pensions VALUES('2', 2001, 10, 1);

--×3番：10ヶ月 * 3年間, 1年休み, 10ヶ月 *  3
INSERT INTO Pensions VALUES('3', 2006, 10, 1);
INSERT INTO Pensions VALUES('3', 2005, 10, 1);
INSERT INTO Pensions VALUES('3', 2004, 10, 1);
INSERT INTO Pensions VALUES('3', 2003,  0, 0);
INSERT INTO Pensions VALUES('3', 2002, 10, 1);
INSERT INTO Pensions VALUES('3', 2001, 10, 1);
INSERT INTO Pensions VALUES('3', 2000, 10, 1);


--×4番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  5 + 9ヶ月
INSERT INTO Pensions VALUES('4', 2007,  9, 1);
INSERT INTO Pensions VALUES('4', 2006, 10, 1);
INSERT INTO Pensions VALUES('4', 2005, 10, 1);
INSERT INTO Pensions VALUES('4', 2004, 10, 1);
INSERT INTO Pensions VALUES('4', 2003, 10, 1);
INSERT INTO Pensions VALUES('4', 2002, 10, 1);
INSERT INTO Pensions VALUES('4', 2001,  0, 0);
INSERT INTO Pensions VALUES('4', 2000, 10, 1);

--○5番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  6
INSERT INTO Pensions VALUES('5', 2007, 10, 1);
INSERT INTO Pensions VALUES('5', 2006, 10, 1);
INSERT INTO Pensions VALUES('5', 2005, 10, 1);
INSERT INTO Pensions VALUES('5', 2004, 10, 1);
INSERT INTO Pensions VALUES('5', 2003, 10, 1);
INSERT INTO Pensions VALUES('5', 2002, 10, 1);
INSERT INTO Pensions VALUES('5', 2001,  0, 0);
INSERT INTO Pensions VALUES('5', 2000, 10, 1);

--×6番：12ヶ月 * 4年間, 1年休み
INSERT INTO Pensions VALUES('6', 2004, 0, 1);
INSERT INTO Pensions VALUES('6', 2003, 12, 1);
INSERT INTO Pensions VALUES('6', 2002, 12, 1);
INSERT INTO Pensions VALUES('6', 2001, 12, 0);
INSERT INTO Pensions VALUES('6', 2000, 12, 1);

--○5番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  6
INSERT INTO Pensions VALUES('7', 2007, 10, 1);
INSERT INTO Pensions VALUES('7', 2006, 10, 1);
INSERT INTO Pensions VALUES('7', 2005, 10, 1);
INSERT INTO Pensions VALUES('7', 2004, 10, 1);
INSERT INTO Pensions VALUES('7', 2003, 10, 1);
INSERT INTO Pensions VALUES('7', 2002, 10, 1);
INSERT INTO Pensions VALUES('7', 2001, 10, 1);
INSERT INTO Pensions VALUES('7', 2000, 10, 1);
INSERT INTO Pensions VALUES('7', 1999,  0, 0);

--○5番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  6
INSERT INTO Pensions VALUES('8', 2007, 10, 1);
INSERT INTO Pensions VALUES('8', 2006, 10, 1);
INSERT INTO Pensions VALUES('8', 2005, 10, 1);

--○5番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  6
INSERT INTO Pensions VALUES('9', 2007, 10, 1);
INSERT INTO Pensions VALUES('9', 2006, 10, 1);
INSERT INTO Pensions VALUES('9', 2005, 10, 1);
INSERT INTO Pensions VALUES('9', 2004, 10, 1);
INSERT INTO Pensions VALUES('9', 2003, 10, 1);
INSERT INTO Pensions VALUES('9', 2002, 10, 1);
INSERT INTO Pensions VALUES('9', 2001, 10, 1);
INSERT INTO Pensions VALUES('9', 2000, 10, 1);

--○5番：10ヶ月 * 1年間, 1年休み, 10ヶ月 *  6
INSERT INTO Pensions VALUES('10', 2007, 10, 1);
INSERT INTO Pensions VALUES('10', 2006, 10, 1);
INSERT INTO Pensions VALUES('10', 2005, 10, 1);
INSERT INTO Pensions VALUES('10', 2004, 10, 1);
INSERT INTO Pensions VALUES('10', 2003, 10, 1);
INSERT INTO Pensions VALUES('10', 2002, 9, 1); -- 59
INSERT INTO Pensions VALUES('10', 2001, 3, 1); -- 62
INSERT INTO Pensions VALUES('10', 2000, 2, 1); -- 64
INSERT INTO Pensions VALUES('10', 1999, 10, 1);
