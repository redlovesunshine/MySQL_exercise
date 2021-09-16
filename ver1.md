# 50 道 SQL 練習題

[TOC]


---


### 0. 創建 Schema 和 Table

* 建立一個名為 exercise 的 schema
```sql=
CREATE schema exercise;
```
* 刪除 Schema
```sql=
DROP schema exercise;
```
* 創建學生表、科目表、教師表、成績表
```sql=
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


### 1. 查詢 01 課程⽐ 02 課程成績⾼的學⽣訊息及課程分數


預期結果須如下：
|SId|Sname|Sage|Ssex|score|
| --- | --- |--- | --- | --- |
|02|錢電|1990 -12 -21 00 :00 :00|男|70.0|
|04|李雲|1990 -12 -06 00 :00 :00|男|50.0|


``` sql=
select st.*, s.score
FROM student as st 
JOIN (SELECT s1.SId, s1.score
FROM (SELECT * FROM sc WHERE CId = 01) AS s1
JOIN (SELECT * FROM sc WHERE CId = 02) AS s2 
ON s1.SId = s2.SId
WHERE s1.score > s2.score) as s
ON st.SId = s.SId;
```
### 2. 查詢同時存在 " 01 " 課程和 " 02 " 課程的情況

預期結果須如下：
| Sid | 01_score | 02_score |
| --- | -------- | -------- |
| 01  | 80.0     | 90.0     |
| 02  | 70.0     | 60.0     |
| 03  | 80.0     | 80.0     |
| 04  | 50.0     | 30.0     |
| 05  | 76.0     | 87.0     |


```sql=
SELECT s1.SId, s1.score as 01_score, s2.score as 02_score 
FROM 
(select * FROM sc WHERE CId = 01) as s1 
JOIN 
(select * FROM sc WHERE CId = 02) as s2
ON s1.Sid = s2.SId;
```

### 3. 查詢存在" 01 "課程但可能不存在" 02 "課程的情況
(不存在時顯示為 null )

預期結果如下：
| Sid | 01_score | 02_score |
| --- | -------- | -------- |
| 01  | 80.0     | 90.0     |
| 02  | 70.0     | 60.0     |
| 03  | 80.0     | 80.0     |
| 04  | 50.0     | 30.0     |
| 05  | 76.0     | 87.0     |
| 06  | 31.0     | (NULL)   |

```sql=
SELECT s1.SId, s1.score AS 01_score, s2.score AS 02_score 
FROM
(SELECT * FROM sc WHERE CId = 01) AS s1
LEFT JOIN
(SELECT * FROM sc WHERE CId = 02) AS s2
ON s1.SId = S2.SId
```

### 4. 查詢不存在" 01 "課程但存在" 02 "課程的情況

預期結果如下：
| Sid | 01_score | 02_score |
| --- | -------- | -------- |
| 01  | 80.0     | 90.0     |
| 02  | 70.0     | 60.0     |
| 03  | 80.0     | 80.0     |
| 04  | 50.0     | 30.0     |
| 05  | 76.0     | 87.0     |
| 07  | (NULL)   | 89.0     |

```sql=
SELECT s2.SId, s1.score AS 01_score, s2.score AS 02_score
FROM
(SELECT * FROM sc WHERE CId = 01) AS s1
right JOIN
(SELECT * FROM sc WHERE CId = 02) AS s2
ON s1.SId = s2.SId
```
### 5. 查詢平均成績⼤於等於 60 分的同學的學⽣編號和學⽣姓名和平均成績

預期結果如下：
| Sid | name | AVGscore |
| --- | ---  | -------- |
| 01  | 趙雷 |  89.6667 |
| 02  | 錢電 |  70.0000 |
| 03  | 孫風 |  80.0000 | 
| 05  | 周梅 |  81.5000 | 
| 07  | 鄭竹 |  93.5000 | 

```sql=
SELECT student.SId, student.Sname AS name, s.AVGscore
FROM student JOIN(SELECT sc.SId, AVG(sc.score) AS AVGscore
FROM sc
GROUP BY SId
HAVING AVG(score)>60) as s
ON student.SId = s. SId

```

### 6. 查詢在 SC 表存在成績的學⽣信息

預期結果如下：

|SId|Sname|Sage|Ssex|
| --- | --- |--- | --- |
|01|趙雷|1990-01-01 00:00:00|男|
|02|錢電|1990-12-21 00:00:00|男|
|03|孫風|1990-12-20 00:00:00|男|
|04|李雲|1990-12-06 00:00:00|男|
|05|周梅|1991-12-01 00:00:00|女|
|06|吳蘭|1992-01-01 00:00:00|女|
|07|鄭竹|1989-01-01 00:00:00|女|

```sql=
select student.* FROM student JOIN
(SELECT DISTINCT SId FROM sc) AS s 
ON student.SId = s.SId
```
### 7. 查詢所有同學的學⽣編號、學⽣姓名、選課總數、所有課程的總成績(沒成績的顯示為 null )

預期結果如下：
|SId|Sname|Sage|Ssex|Count|Score|
|:----|:----|:----|:----|:----|:----|
|01|趙雷|1990-01-01 00:00:00|男|3|269.0|
|02|錢電|1990-12-21 00:00:00|男|3|210.0|
|03|孫風|1990-12-20 00:00:00|男|3|240.0|
|04|李雲|1990-12-06 00:00:00|男|3|100.0|
|05|周梅|1991-12-01 00:00:00|⼥|2|163.0|
|06|吳蘭|1992-01-01 00:00:00|⼥|2|65.0|
|07|鄭竹|1989-01-01 00:00:00|⼥|2|187.0|
|09|張三|2017-12-20 00:00:00|⼥|(NULL) |(NULL) |
|10|李四|2017-12-25 00:00:00|⼥|(NULL) |(NULL)|
|11|李四|2012-06-06 00:00:00|⼥|(NULL) |(NULL) |
|12|趙六|2013-06-13 00:00:00|⼥|(NULL) |(NULL) |
|13|孫七|2014-06-01 00:00:00|⼥|(NULL) |(NULL) |
```sql=
SELECT student.*, s.Count, s.Score 
FROM student LEFT JOIN
(SELECT sc.SId, count(CId) AS Count, SUM(sc.score) AS Score
FROM sc
GROUP BY SId) AS s 
ON student.SId = s.SId
```

### 8. 查詢「李」姓老師的數量

預期結果如下：
|COUNT(*)|
|:----|
|1|
```sql=
SELECT COUNT(*) FROM teacher
where Tname LIKE '李%'
```