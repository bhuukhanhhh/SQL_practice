﻿-- Cơ Sở Dữ Liệu --
-- Bài Thực Hành Số 1 & 2 --



-- Bài tập 1
-- Sinh viên cài đặt hoàn chỉnh bằng các câu lệnh SQL cho 2 CSDL QuanLyBanHang (Phần I, câu 1 bài tập thực hành trang 3) và QuanLyGiaoVu (Phần I, câu 1 bài tập thực hành trang 11).

-- QUANLYBANHANG --
CREATE DATABASE THUCHANH_QUANLYBANHANG
USE THUCHANH_QUANLYBANHANG

	-- Table: KHACHHANG
	CREATE TABLE KHACHHANG (
		MAKH CHAR(4) NOT NULL PRIMARY KEY,
		HOTEN VARCHAR(40),
		DCHI VARCHAR(50),
		SODT VARCHAR(20),
		NGSINH SMALLDATETIME,
		DOANHSO MONEY,
		NGDK SMALLDATETIME
	)

	-- Table: NHANVIEN
	CREATE TABLE NHANVIEN (
		MANV CHAR(4) NOT NULL PRIMARY KEY,
		HOTEN VARCHAR(40),
		SODT VARCHAR(20),
		NGVL SMALLDATETIME
	)

	-- Table: SANPHAM
	CREATE TABLE SANPHAM (
		MASP CHAR(4) NOT NULL PRIMARY KEY,
		TENSP VARCHAR(40),
		DVT VARCHAR(20),
		NUOCSX VARCHAR(40),
		GIA MONEY
	)

	-- Table: HOADON
	CREATE TABLE HOADON (
		SOHD INT NOT NULL PRIMARY KEY,
		NGHD SMALLDATETIME,
		MAKH CHAR(4),
		MANV CHAR(4),
		TRIGIA MONEY
	)

	-- Table: CTHD
	CREATE TABLE CTHD (
		SOHD INT NOT NULL,
		MASP CHAR(4) NOT NULL,
		SL INT,
		CONSTRAINT PK_CTHD PRIMARY KEY (SOHD, MASP)
	)

	-- FOREIGN KEY OF TABLE: HOADON --
	ALTER TABLE HOADON ADD CONSTRAINT FK_MAKH_HOADON_KHACHHANG FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH)
	ALTER TABLE HOADON ADD CONSTRAINT FK_MANV_HOADON_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV)

	-- FOREIGN KEY OF TABLE: CTHD
	ALTER TABLE CTHD ADD CONSTRAINT FK_SOHD_CTHD_HOADON FOREIGN KEY (SOHD) REFERENCES HOADON (SOHD)
	ALTER TABLE CTHD ADD CONSTRAINT FK_MASP_CTHD_SANPHAM FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP)



-- QUANLYGIAOVU --
CREATE DATABASE THUCHANH_QUANLYGIAOVU
USE THUCHANH_QUANLYGIAOVU

	-- Table: HOCVIEN
	CREATE TABLE HOCVIEN (
		MAHV CHAR(5) NOT NULL PRIMARY KEY,
		HO VARCHAR(40),
		TEN VARCHAR(10),
		NGSINH SMALLDATETIME,
		GIOITINH VARCHAR(3),
		NOISINH VARCHAR(40),
		MALOP CHAR(3)
	)

	-- Table: LOP
	CREATE TABLE LOP (
		MALOP CHAR(3) NOT NULL PRIMARY KEY,
		TENLOP VARCHAR(40),
		TRGLOP CHAR(5),
		SISO TINYINT,
		MAGVCN CHAR(4)
	)

	-- Table: KHOA
	CREATE TABLE KHOA (
		MAKHOA VARCHAR(4) NOT NULL PRIMARY KEY,
		TENKHOA VARCHAR(40),
		NGTLAP SMALLDATETIME,
		TRGKHOA CHAR(4)
	)

	-- Table: MONHOC
	CREATE TABLE MONHOC (
		MAMH VARCHAR(10) NOT NULL PRIMARY KEY,
		TENMH VARCHAR(40),
		TCLT TINYINT,
		TCTH TINYINT,
		MAKHOA VARCHAR(4)
	)

	-- Table: DIEUKIEN
	CREATE TABLE DIEUKIEN (
		MAMH VARCHAR(10) NOT NULL,
		MAMH_TRUOC VARCHAR(10) NOT NULL,
		CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH, MAMH_TRUOC)
	)

	-- Table: GIAOVIEN
	CREATE TABLE GIAOVIEN (
		MAGV CHAR(4) NOT NULL PRIMARY KEY,
		HOTEN VARCHAR(40),
		HOCVI VARCHAR(10),
		HOCHAM VARCHAR(10),
		GIOITINH VARCHAR(3),
		NGSINH SMALLDATETIME,
		NGVL SMALLDATETIME,
		HESO NUMERIC(4,2),
		MUCLUONG MONEY,
		MAKHOA VARCHAR(4)
	)

	-- Table: GIANGDAY
	CREATE TABLE GIANGDAY (
		MALOP CHAR(3) NOT NULL,
		MAMH VARCHAR(10) NOT NULL,
		MAGV CHAR(4),
		HOCKY TINYINT,
		NAM SMALLINT,
		TUNGAY SMALLDATETIME,
		DENNGAY SMALLDATETIME,
		CONSTRAINT PK_GIANGDAY PRIMARY KEY (MALOP, MAMH)
	)

	-- Table: KETQUATHI
	CREATE TABLE KETQUATHI (
		MAHV CHAR(5) NOT NULL,
		MAMH VARCHAR(10) NOT NULL,
		LANTHI TINYINT NOT NULL,
		NGTHI SMALLDATETIME,
		DIEM NUMERIC(4,2),
		KQUA VARCHAR(10),
		CONSTRAINT PK_KETQUATHI PRIMARY KEY (MAHV, MAMH, LANTHI)
	)

	-- FOREIGN KEY OF TABLE: HOCVIEN --
	ALTER TABLE HOCVIEN ADD CONSTRAINT FK_MALOP_HOCVIEN_LOP FOREIGN KEY (MALOP) REFERENCES LOP (MALOP)

	-- FOREIGN KEY OF TABLE: LOP --
	ALTER TABLE LOP ADD CONSTRAINT FK_TRGLOP_LOP_HOCVIEN FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN (MAHV)
	ALTER TABLE LOP ADD CONSTRAINT FK_MAGVCN_LOP_GIAOVIEN FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN (MAGV)

	-- FOREIGN KEY OF TABLE: KHOA --
	ALTER TABLE KHOA ADD CONSTRAINT FK_TRGKHOA_KHOA_GIAOVIEN FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN (MAGV)

	-- FOREIGN KEY OF TABLE: MONHOC --
	ALTER TABLE MONHOC ADD CONSTRAINT FK_MAKHOA_MONHOC_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA (MAKHOA)

	-- FOREIGN KEY OF TABLE: DIEUKIEN --
	ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_MAMH_DIEUKIEN_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)
	ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_MAMHTRUOC_DIEUKIEN_MONHOC FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC (MAMH)

	-- FOREIGN KEY OF TABLE: GIAOVIEN --
	ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_MAKHOA_GIAOVIEN_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA (MAKHOA)

	-- FOREIGN KEY OF TABLE: GIANGDAY --
	ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MALOP_GIANGDAY_LOP FOREIGN KEY (MALOP) REFERENCES LOP (MALOP)
	ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MAMH_GIANGDAY_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)
	ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MAGV_GIANGDAY_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN (MAGV)

	-- FOREIGN KEY OF TABLE: KETQUATHI --
	ALTER TABLE KETQUATHI ADD CONSTRAINT FK_MAHV_KETQUATHI_HOCVIEN FOREIGN KEY (MAHV) REFERENCES HOCVIEN (MAHV)
	ALTER TABLE KETQUATHI ADD CONSTRAINT FK_MAMH_KETQUATHI_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)

	-- Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN.
	ALTER TABLE HOCVIEN ADD GHICHU VARCHAR(20), DIEMTB NUMERIC(4,2), XEPLOAI VARCHAR(12)





-- Bài tập 2
-- Sinh viên hoàn thành Phần I bài tập QuanLyBanHang từ câu 2 đến câu 10.

--	----------------------------------------------------------------------
--	I.	Ngôn ngữ định nghĩa dữ liệu (Data Definition Language):
--	----------------------------------------------------------------------
--	2.	Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
	ALTER TABLE SANPHAM ADD GHICHU VARCHAR(20)

--	3.	Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG
	ALTER TABLE KHACHHANG ADD LOAIKH TINYINT

--	4.	Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
	ALTER TABLE SANPHAM ALTER COLUMN GHICHU VARCHAR(100)

--	5.	Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
	ALTER TABLE SANPHAM DROP COLUMN GHICHU

--	6.	Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, ...
	ALTER TABLE KHACHHANG ALTER COLUMN LOAIKH VARCHAR(50)

--	7.	Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”).
	ALTER TABLE SANPHAM ADD CONSTRAINT CHECKING_DVT_SANPHAM CHECK (DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc'))

--	8.	Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”).
	ALTER TABLE SANPHAM ADD CONSTRAINT CHECKING_GIA_SANPHAM CHECK (GIA >= 500)

--	9.	Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
	ALTER TABLE CTHD ADD CONSTRAINT CHECKING_SL_CTHD CHECK (SL >= 1)

--	10.	Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
	ALTER TABLE KHACHHANG ADD CONSTRAINT CHECKING_NGDK_NGSINH CHECK (NGDK > NGSINH)





-- Bài tập 3
-- Sinh viên hoàn thành Phần I bài tập QuanLyGiaoVu từ câu 2 đến câu 8.

--	----------------------------------------------------------------------
--	I.	Ngôn ngữ định nghĩa dữ liệu (Data Definition Language):
--	----------------------------------------------------------------------
--	2.	Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: "K1101"


--	3.	Thuộc tính GIOITINH chỉ có giá trị là "Nam" hoặc "Nu".
	ALTER TABLE HOCVIEN ADD CONSTRAINT CHECKING_GIOITINH_HOCVIEN CHECK (GIOITINH IN ('Nam', 'Nu'))
	ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECKING_GIOITINH_GIAOVIEN CHECK (GIOITINH IN ('Nam', 'Nu'))

--	4.	Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).


--	5.	Kết quả thi là "Dat" nếu điểm từ 5 đến 10 và "Khong dat" nếu điểm nhỏ hơn 5.
	ALTER TABLE KETQUATHI ADD CONSTRAINT CHECK_KQUA_KETQUATHI CHECK (
		(KQUA = 'Dat' AND DIEM BETWEEN 5 AND 10)
		OR
		(KQUA = 'Khong dat' AND DIEM < 5)
	)

--	6.	Học viên thi một môn tối đa 3 lần.
	ALTER TABLE KETQUATHI ADD CONSTRAINT CHECKING_LANTHI_KETQUATHI CHECK (LANTHI <= 3)

--	7.	Học kỳ chỉ có giá trị từ 1 đến 3.
	ALTER TABLE GIANGDAY ADD CONSTRAINT CHECKING_HOCKY_GIANGDAY CHECK (HOCKY BETWEEN 1 AND 3)

--	8.	Học vị của giáo viên chỉ có thể là "CN", "KS", "Ths", "TS", "PTS".
	ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECKING_HOCVI_GIAOVIEN CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'))
