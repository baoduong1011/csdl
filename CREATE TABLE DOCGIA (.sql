
USE DE4_BUOI10
CREATE TABLE DOCGIA (
    MADG CHAR(5) PRIMARY KEY,
    HOTEN VARCHAR(30),
    NGAYSINH SMALLDATETIME,
    DIACHI VARCHAR(30),
    SODT VARCHAR(15)
)
SET DATEFORMAT DMY
INSERT INTO DOCGIA(MADG,HOTEN,NGAYSINH,DIACHI,SODT) VALUES('DG01','DUONG TUAN MINH','10/11/2001','SO 3 HAI BA TRUNG','0123456789')
INSERT INTO DOCGIA(MADG,HOTEN,NGAYSINH,DIACHI,SODT) VALUES('DG02','DUONG TUAN BAO','10/11/2001','SO 3 HAI BA TRUNG','0223456789')
INSERT INTO DOCGIA(MADG,HOTEN,NGAYSINH,DIACHI,SODT) VALUES('DG06','NGUYEN TAN MINH','12/03/1980','SO 4 NGUYEN DINH CHIEU','0323456789')
INSERT INTO DOCGIA(MADG,HOTEN,NGAYSINH,DIACHI,SODT) VALUES('DG03','DUONG TUAN KHAI','12/01/2003','SO 10/B HAI BA TRIEU','0423456789')
INSERT INTO DOCGIA(MADG,HOTEN,NGAYSINH,DIACHI,SODT) VALUES('DG04','HUYNH TRAN','12/11/1999','SO 10 NGUYEN TRAI','0143456789')
INSERT INTO DOCGIA(MADG,HOTEN,NGAYSINH,DIACHI,SODT) VALUES('DG05','DUONG TUAN MAI','15/11/2001','SO 16 HAI BA TRUNG','0123456789')




CREATE TABLE SACH(
    MASACH CHAR(5) PRIMARY KEY,
    TENSACH VARCHAR(25),
    THELOAI VARCHAR(25),
    NHAXUATBAN VARCHAR(30)
)

INSERT INTO SACH(MASACH,TENSACH,THELOAI,NHAXUATBAN) VALUES('MS001','LAP TRINH C++','TINHOC','HANOI')
INSERT INTO SACH(MASACH,TENSACH,THELOAI,NHAXUATBAN) VALUES('MS002','LAP TRINH C#','TINHOC','HANOI')
INSERT INTO SACH(MASACH,TENSACH,THELOAI,NHAXUATBAN) VALUES('MS003','DE MEN PHIEU LUU KY','VANHOC','HANOI')
INSERT INTO SACH(MASACH,TENSACH,THELOAI,NHAXUATBAN) VALUES('MS004','ECH NGOI DAY GIENG','NGUNGON','HANOI')
INSERT INTO SACH(MASACH,TENSACH,THELOAI,NHAXUATBAN) VALUES('MS005','TOAN LOP 5','GIAOKHOA','HANOI')

CREATE TABLE PHIEUTHUE (
    MAPT CHAR(5) PRIMARY KEY,
    MADG CHAR(5) ,
    NGAYTTHUE SMALLDATETIME,
    NGAYTRA SMALLDATETIME,
    SOSACHTHUE INT 
)

INSERT INTO PHIEUTHUE(MAPT,MADG,NGAYTTHUE,NGAYTRA,SOSACHTHUE) VALUES('PT01','DG01','13/06/2018','13/07/2018',1)
INSERT INTO PHIEUTHUE(MAPT,MADG,NGAYTTHUE,NGAYTRA,SOSACHTHUE) VALUES('PT02','DG01','13/07/2018','13/08/2018',10)
INSERT INTO PHIEUTHUE(MAPT,MADG,NGAYTTHUE,NGAYTRA,SOSACHTHUE) VALUES('PT03','DG02','12/03/2019','15/04/2019',2)
INSERT INTO PHIEUTHUE(MAPT,MADG,NGAYTTHUE,NGAYTRA,SOSACHTHUE) VALUES('PT04','DG03','23/06/2018','13/07/2018',5)
INSERT INTO PHIEUTHUE(MAPT,MADG,NGAYTTHUE,NGAYTRA,SOSACHTHUE) VALUES('PT05','DG03','23/01/2018','13/07/2018',100)
INSERT INTO PHIEUTHUE(MAPT,MADG,NGAYTTHUE,NGAYTRA,SOSACHTHUE) VALUES('PT06','DG04','01/06/2018','03/07/2018',12)

INSERT INTO PHIEUTHUE(MAPT,MADG,NGAYTTHUE,NGAYTRA,SOSACHTHUE) VALUES('PT07','DG05','13/06/2018','13/07/2018',8)

ALTER TABLE PHIEUTHUE ADD 
    CONSTRAINT PT_MADG_FK FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG)

CREATE TABLE CHITIET (
    MAPT CHAR(5),
    MASACH CHAR(5),
    CONSTRAINT CT_MAPT_MASACH PRIMARY KEY(MAPT,MASACH)
)


INSERT INTO CHITIET(MAPT,MASACH) VALUES('PT01','MS001')
INSERT INTO CHITIET(MAPT,MASACH) VALUES('PT02','MS002')
INSERT INTO CHITIET(MAPT,MASACH) VALUES('PT03','MS003')
INSERT INTO CHITIET(MAPT,MASACH) VALUES('PT04','MS004')
INSERT INTO CHITIET(MAPT,MASACH) VALUES('PT05','MS005')
INSERT INTO CHITIET(MAPT,MASACH) VALUES('PT06','MS002')
INSERT INTO CHITIET(MAPT,MASACH) VALUES('PT07','MS003')
ALTER TABLE CHITIET ADD 
    CONSTRAINT CT_MAPT_FK FOREIGN KEY (MAPT) REFERENCES PHIEUTHUE(MAPT),
    CONSTRAINT CT_MASACH_FK FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)


--2.1
GO
CREATE TRIGGER PHIEUTHUE_TRIGGER ON PHIEUTHUE FOR INSERT , UPDATE AS 
BEGIN
    IF EXISTS(
        SELECT *
        FROM inserted I 
        WHERE (YEAR(NGAYTHUE) = YEAR(NGAYTRA)) AND (MONTH(NGAYTHUE) = MONTH(NGAYTRA)) AND (DAY(NGAYTRA) - DAY(NGAYTHUE) <=10) 
    )
    BEGIN 
        RAISERROR('DU LIEU MOI KHONG HOP LE!!!',0,1)
    END 
    ELSE 
    BEGIN 
        PRINT('THEM DU LIEU THANH CONG!!!');
    END 
END
















-- 3.3
GO 
SELECT S1.THELOAI,S1.TENSACH
FROM SACH S1,PHIEUTHUE PT,CHITIET_PT CTPT
WHERE S1.MASACH = CTPT.MASACH AND PT.MAPT = CTPT.MAPT 
GROUP BY S.THELOAI,S.TENSACH 
HAVING COUNT(DISTINCT S1.MASACH) >= ALL(
                SELECT COUNT(DISTINCT S2.MASACH) 
                FROM  SACH S2,PHIEUTHUE PT,CHITIET_PT CTPT
                WHERE  S2.MASACH = CTPT.MASACH AND PT.MAPT = CTPT.MAPT
                GROUP BY S2.THELOAI,S2.TENSACH 
                HAVING S1.THELOAI = S2.THELOAI 
)







 
CREATE TRIGGER SACH4_TRIGGER ON  PHIEUTHUE FOR INSERT,UPDATE 
AS 
BEGIN 


























--2.1
GO 
CREATE TRIGGER BANG_DIA_TRIGGER ON BANG_DIA FOR INSERT,UPDATE AS 
BEGIN
    IF EXISTS(
        SELECT *
        FROM inserted I 
        WHERE I.THELOAI != 'CANHAC' OR I.THELOAI != 'PHIMHANHDONG' OR I.THELOAI != 'PHIMTINHCAM' OR I.THELOAI != 'PHIMHOATHINH'
    )
     BEGIN 
        RAISERROR('DU LIEU MOI KHONG HOP LE!!!',0,1)
    END 
    ELSE 
    BEGIN 
        PRINT('THEM DU LIEU THANH CONG!!!');
    END 
END























--2.2 
GO
CREATE TRIGGER KHACHHANG_TRIGGER ON KHACHHANG FOR UPDATE AS 
BEGIN 
    IF EXISTS(
        SELECT *
        FROM inserted I , PHIEUTHUE PT 
        WHERE I.MAKH = PT.MAKH AND (I.LOAIKH!='VIP' AND PT.SOLUONGTHUE >5)
    )
     BEGIN 
        RAISERROR('DU LIEU MOI KHONG HOP LE!!!',0,1)
    END 
    ELSE 
    BEGIN 
        PRINT('THEM DU LIEU THANH CONG!!!');
    END 
END

GO
CREATE TRIGGER PHIEUTHUE3_TRIGGER ON PHIEUTHUE FOR UPDATE,INSERT AS 
BEGIN 
    IF EXISTS(
        SELECT *
        FROM inserted I , KHACHHANG KH 
        WHERE I.MAKH = KH.MAKH AND (KH.LOAIKH!='VIP' AND I.SOLUONGTHUE >5)
    )
     BEGIN 
        RAISERROR('DU LIEU MOI KHONG HOP LE!!!',0,1)
    END 
    ELSE 
    BEGIN 
        PRINT('THEM DU LIEU THANH CONG!!!');
    END 
END
