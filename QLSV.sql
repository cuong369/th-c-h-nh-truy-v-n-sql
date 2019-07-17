create database qlsv;
use qlsv;

CREATE TABLE monhoc (
    mamh CHAR(5) PRIMARY KEY,
    tenmh NVARCHAR(30) NOT NULL,
    sotrinh INT NOT NULL CHECK (sotrinh > 0 AND sotrinh < 7)
);

CREATE TABLE khoa (
    makhoa CHAR(5) PRIMARY KEY,
    tenkhoa NVARCHAR(30) NOT NULL,
    diachi NVARCHAR(100) NOT NULL,
    dienthoai VARCHAR(15) NOT NULL
);

CREATE TABLE hedt (
    mahedt CHAR(5) PRIMARY KEY,
    tenhedt NVARCHAR(30) NOT NULL
);

CREATE TABLE khoahoc (
    makhoahoc CHAR(5) PRIMARY KEY,
    tenkhoahoc NVARCHAR(30) NOT NULL
);

CREATE TABLE lop (
    malop CHAR(5) PRIMARY KEY,
    tenlop NVARCHAR(50) NOT NULL,
    makhoa CHAR(5),
    mahedt CHAR(5),
    makhoahoc CHAR(5),
    FOREIGN KEY (makhoa)
        REFERENCES khoa (makhoa),
    FOREIGN KEY (mahedt)
        REFERENCES hedt (mahedt),
    FOREIGN KEY (makhoahoc)
        REFERENCES khoahoc (makhoahoc)
);

-- gioitinh: kiểu dữ liệu có thể chọn là: char(1) hoặc bit
CREATE TABLE sinhvien (
    masv CHAR(15) PRIMARY KEY,
    tensv NVARCHAR(30),
    gioitinh BIT,
    ngaysinh DATE,
    quequan NVARCHAR(100),
    malop CHAR(5),
    FOREIGN KEY (malop)
        REFERENCES lop (malop)
);

CREATE TABLE diem (
    masv CHAR(15),
    mamh CHAR(5),
    hocky INT NOT NULL CHECK (hocky > 0),
    diemlan1 INT,
    diemlan2 INT,
    FOREIGN KEY (masv)
        REFERENCES sinhvien (masv),
    FOREIGN KEY (mamh)
        REFERENCES monhoc (mamh)
);

insert into hedt values('A01','Ðại Học');
insert into hedt values('B01','Cao Ðẳng');
insert into hedt values('C01','Trung Cấp');
insert into hedt values('D01','Công nhân');
insert into hedt values('N01', N'Lành nghề');

insert into monhoc values('SQL','SQL',5);
insert into monhoc values('JV','Java',6);
insert into monhoc values('CNPM','Công Nghệ phần mềm',4);
insert into monhoc values('PTHT','Phân tích hệ thống',4);
insert into monhoc values('Mang','Mạng máy tính',5);

insert into khoa values('CNTT',N'Công nghệ thông tin',N'Tầng 4 nhà B','043768888');
insert into khoa values('CK',N'Cõ Khí',N'Tầng 5 nhà B','043768888');
insert into khoa values('DT',N'Ðiện tử',N'Tằng 6 nhà B','043768888');
insert into khoa values('KT',N'Kinh Tế',N'Tầng 2 nhà C','043768888');

insert into khoahoc values('K1',N'Ðại học khóa 1');
insert into khoahoc values('K2',N'Ðại học khóa 2');
insert into khoahoc values('K3',N'Ðại học khóa 3');
insert into khoahoc values('K9',N'Ðại học khóa 4');
insert into khoahoc values('K10',N'Ðại học khóa 5');
insert into khoahoc values('K11',N'Ðại học khóa 6');

insert into lop values('MT1',N'MÁy Tính 1','CNTT','A01','K2');
insert into lop values('MT2',N'MÁy Tính 2','CNTT','A01','K2');
insert into lop values('MT3',N'MÁy Tính 3','CNTT','A01','K2');
insert into lop values('MT4',N'MÁy Tính 4','CNTT','A01','K2');
insert into lop values('KT1',N'Kinh tế 1','KT','A01','K2');

insert into sinhvien values(
'0241060218',N'Nguyễn Minh Một',1,'1989-08-27','Hải Dương','MT3'
);
insert into sinhvien values('0241060318',N'Nguyễn Minh Hai',1,'1989-08-02','Nam Dinh','MT1');
insert into sinhvien values('0241060418',N'Nguyễn Minh Ba',1,'1989-04-07','Ninh Binh','MT2');
insert into sinhvien values('0241060518',N'Nguyễn Minh Bốn',1,'1989-08-07','Ninh Binh','MT1');
insert into sinhvien values('0241060618',N'Nguyễn Minh Nãm',0,'1989-08-07','Nam Dinh','MT3');
insert into sinhvien values('0241060718',N'Nguyễn Minh Sáu',1,'1989-08-07','Ha Noi','MT3');
insert into sinhvien values('0241060148',N'Nguyễn Minh Mýời Một',0,'1989-08-07','Bac Giang','MT4');
insert into sinhvien values('0241060168',N'Nguyễn Minh Mýời Ba',1,'1989-08-07','Hai Duong','MT4');
insert into sinhvien values('0241060178',N'Nguyễn Minh Mýời Bốn',1,'1995-05-06','Nghe An','MT1');
insert into sinhvien values('0241060978',N'Nguyễn Minh Mýời Nãm',1,'2000-03-04','Nghe An','KT1');

insert into diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060218','SQL',5,7);
insert into diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060418','SQL',5,6);
insert into diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060218','CNPM',5,8);
insert into diem values('0241060518','SQL',5,4,6);
insert into diem values('0241060218','Mang',5,4,5);
insert into diem values('0241060218','JV',5,4,4);
insert into diem values('0241060518','JV',5,4,6);
insert into diem values('0241060218','PTHT',4,2,5);
insert into diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060318','SQL',4,9);
insert into diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060618','SQL',4,8);
insert into diem values('0241060318','Mang',5,3,4);
insert into diem values('0241060418','Mang',5,4,4);
insert into diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060518','Mang',5,8);
