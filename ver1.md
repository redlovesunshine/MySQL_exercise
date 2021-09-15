# 50 道 SQL 練習題

0. 創建 Schema 和 Table

* 建立一個名為 exercise 的 schema
```sql=
CREATE schema exercise;
```
* 刪除 Schema
```sql
DROP schema exercise;
```
* 創建學生表、科目表、教師表、成績表
```sql
CREATE TABLE Student(
    SId varchar(10),
    Sname varchar(10),
    Sage datetime,
    Ssex varchar(10)
);

INSERT INTO
    Student
VALUES
    ('01', '趙雷', '1990-01-01', '男'),
    ('02', '錢電', '1990-12-21', '男'),
    ('03', '孫風', '1990-12-20', '男'),
    ('04', '李雲', '1990-12-06', '男'),
    ('05', '周梅', '1991-12-01', '⼥'),
    ('06', '吳蘭', '1992-01-01', '⼥'),
    ('07', '鄭竹', '1989-01-01', '⼥'),
    ('09', '張三', '2017-12-20', '⼥'),
    ('10', '李四', '2017-12-25', '⼥'),
    ('11', '李四', '2012-06-06', '⼥'),
    ('12', '趙六', '2013-06-13', '⼥'),
    ('13', '孫七', '2014-06-01', '⼥');

-- 科目表 Course
CREATE TABLE Course(
    CId varchar(10),
    Cname nvarchar(10),
    TId varchar(10)
);

INSERT INTO
    Course
VALUES
    ('01', '語文', '02'),
    ('02', '數學', '01'),
    ('03', '英語', '03');

-- 教師表 Teacher
CREATE TABLE Teacher(TId varchar(10), Tname varchar(10));

INSERT INTO
    Teacher
VALUES
    ('01', '張三'),
    ('02', '李四'),
    ('03', '王五');

-- 成績表 SC
CREATE TABLE SC(
    SId varchar(10),
    CId varchar(10),
    score decimal(18, 1)
);

INSERT INTO
    SC
VALUES
    ('01', '01', 80),
    ('01', '02', 90),
    ('01', '03', 99),
    ('02', '01', 70),
    ('02', '02', 60),
    ('02', '03', 80),
    ('03', '01', 80),
    ('03', '02', 80),
    ('03', '03', 80),
    ('04', '01', 50),
    ('04', '02', 30),
    ('04', '03', 20),
    ('05', '01', 76),
    ('05', '02', 87),
    ('06', '01', 31),
    ('06', '03', 34),
    ('07', '02', 89),
    ('07', '03', 98);
```
:shaved_ice: : MYSQL 中創建 Schema 和 Database 相同；Oracle 和 MSSQL 中創建 Schema 和 Database則不同


1. 查詢 01 課程⽐ 02 課程成績⾼的學⽣信息及課程分數


預期結果須如下：
|SId|Sname|Sage|Ssex|score|
| --- | --- |--- | --- | --- |
|02|錢電|1990 -12 -21 00 :00 :00|男|70.0|
|04|李雲|1990 -12 -06 00 :00 :00|男|50.0|


``` sql
select st.*, s.score
FROM student as st 
JOIN (SELECT s1.SId, s1.score
FROM (SELECT * FROM sc WHERE CId = 01) AS s1
JOIN (SELECT * FROM sc WHERE CId = 02) AS s2 
ON s1.SId = s2.SId
WHERE s1.score > s2.score) as s
ON st.SId = s.SId;
```
2. 查詢同時存在 " 01 " 課程和 " 02 " 課程的情況

hello moto


