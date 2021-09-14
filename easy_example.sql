CREATE SCHEMA exercise;

-- 創建 SCHEMA
DROP SCHEMA exercise;

-- 移除 SCHEMA
CREATE DATABASE exercise;

-- 創建 DATABASE
DROP DATABASE exercise;

-- 移除 DATABASE
CREATE TABLE Student(
    SId varchar(10),
    Sname varchar(10),
    Sage datetime,
    Ssex varchar(10)
);

-- 創建 Student TABLE
INSERT INTO
    Student
VALUES
    ('01', '趙雷', '1990-01-01', '男'),
    ('02', '錢電', '1990-12-21', '男'),
    ('03', '孫風', '1990-12-20', '男'),
    ('04', '李雲', '1990-12-06', '男'),
    ('05', '周梅', '1991-12-01', '女'),
    ('06', '吳蘭', '1992-01-01', '女'),
    ('07', '鄭竹', '1989-01-01', '女'),
    ('09', '張三', '2017-12-20', '女'),
    ('10', '李四', '2017-12-25', '女'),
    ('11', '李四', '2012-06-06', '女'),
    ('12', '趙六', '2013-06-13', '女'),
    ('13', '孫七', '2014-06-01', '女');

-- 新增列