CREATE DATABASE HumanResource
GO

USE HumanResource
GO

CREATE TABLE PhongBan (
    MaPB VARCHAR(7) PRIMARY KEY NOT NULL,
    TenPB NVARCHAR(50)
);
GO

CREATE TABLE NhanVien (
    MaNV VARCHAR(7) PRIMARY KEY NOT NULL,
    TenNV NVARCHAR(50),
    NgaySinh DATETIME,
    SoCMND CHAR(9) NOT NULL,
    GioiTinh CHAR NOT NULL,
    DiaChi NVARCHAR(100),
    NgayVaoLam DATETIME,
    MaPB VARCHAR(7),
    FOREIGN KEY (MaPB) REFERENCES PhongBan(MaPB)
);
GO

CREATE TABLE LuongDA (
    MaDA VARCHAR(8) NOT NULL,
    MaNV VARCHAR(7) NOT NULL,
    NgayNhan DATETIME,
    SoTien MONEY,
    CONSTRAINT check_money_positive CHECK (SoTien > 0),
    PRIMARY KEY (MaDA, MaNV),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);
GO

--1. Thực hiện chèn dữ liệu vào các bảng vừa tạo (ít nhất 5 bản ghi cho mỗi bảng).
INSERT INTO PhongBan (MaPB, TenPB)
VALUES ('PB001', N'Bộ phận Kế toán'),
       ('PB002', N'Bộ phận Nhân sự'),
       ('PB003', N'Bộ phận Kinh doanh'),
       ('PB004', N'Bộ phận Kỹ thuật'),
       ('PB005', N'Bộ phận Marketing');

INSERT INTO NhanVien (MaNV, TenNV, NgaySinh, SoCMND, GioiTinh, DiaChi, NgayVaoLam, MaPB)
VALUES ('NV001', N'Nguyễn Văn A', '1990-05-15', '123456789', 'M', N'Hà Nội', '2015-08-20', 'PB001'),
       ('NV002', N'Trần Thị B', '1995-10-25', '987654321', 'F', N'Hồ Chí Minh', '2016-01-10', 'PB002'),
       ('NV003', N'Lê Văn C', '1988-12-03', '246813579', 'M', N'Đà Nẵng', '2017-03-05', 'PB003'),
       ('NV004', N'Phạm Thị D', '1992-07-12', '135792468', 'F', N'Hải Phòng', '2018-06-15', 'PB004'),
       ('NV005', N'Huỳnh Văn E', '1985-09-28', '864213579', 'M', N'Cần Thơ', '2019-04-30', 'PB005');

INSERT INTO LuongDA (MaDA, MaNV, NgayNhan, SoTien)
VALUES ('LDA001', 'NV001', '2023-01-05', 15000000),
       ('LDA002', 'NV002', '2023-01-05', 16000000),
       ('LDA003', 'NV003', '2023-01-05', 17000000),
       ('LDA004', 'NV004', '2023-01-05', 18000000),
       ('LDA005', 'NV005', '2023-01-05', 19000000);
GO

--2. Viết một query để hiển thị thông tin về các bảng LUONGDA, NHANVIEN, PHONGBAN.
SELECT *
FROM LuongDA;
GO

SELECT *
FROM NhanVien;
GO

SELECT *
FROM PhongBan;
GO

--3. Viết một query để hiển thị những nhân viên có giới tính là ‘F’.
SELECT * FROM NhanVien
WHERE GioiTinh = 'F'
GO

--4. Hiển thị tất cả các dự án, mỗi dự án trên 1 dòng.
SELECT * FROM PhongBan
GO

SELECT * FROM NhanVien
GO

SELECT * FROM LuongDA
GO

--5. Hiển thị tổng lương của từng nhân viên (dùng mệnh đề GROUP BY).
SELECT MaNV, SUM(SoTien) AS 'Tổng lương'
FROM LuongDA
GROUP BY MaNV;
GO

--6. Hiển thị tất cả các nhân viên trên một phòng ban cho trước (VD: ‘Hành chính’).
SELECT NV.MaNV, NV.TenNV, NV.NgaySinh, NV.SoCMND, NV.GioiTinh, NV.DiaChi, NV.NgayVaoLam, PB.TenPB
FROM NhanVien NV
JOIN PhongBan PB ON NV.MaPB = PB.MaPB
WHERE PB.TenPB = N'Hành chính';
GO

--7. Hiển thị mức lương của những nhân viên phòng hành chính.
SELECT NV.MaNV, NV.TenNV, LD.SoTien
FROM NhanVien NV
JOIN LuongDA LD ON NV.MaNV = LD.MaNV
JOIN PhongBan PB ON NV.MaPB = PB.MaPB
WHERE PB.TenPB = N'Hành chính';
GO

--8. Hiển thị số lượng nhân viên của từng phòng.
SELECT PB.TenPB, COUNT(NV.MaNV) AS SoLuongNhanVien
FROM PhongBan PB
LEFT JOIN NhanVien NV ON PB.MaPB = NV.MaPB
GROUP BY PB.TenPB;
GO

--9. Viết một query để hiển thị những nhân viên mà tham gia ít nhất vào một dự án.
SELECT DISTINCT NV.MaNV, NV.TenNV
FROM NhanVien NV
INNER JOIN LuongDA LD ON NV.MaNV = LD.MaNV
HAVING COUNT(LD.MaDA) >= 1;
GO

--10. Viết một query hiển thị phòng ban có số lượng nhân viên nhiều nhất.
SELECT TOP 1 PB.MaPB, PB.TenPB, COUNT(NV.MaNV) AS SoLuongNhanVien
FROM PhongBan PB
LEFT JOIN NhanVien NV ON PB.MaPB = NV.MaPB
GROUP BY PB.MaPB, PB.TenPB
ORDER BY SoLuongNhanVien DESC;
GO

--11. Tính tổng số lượng của các nhân viên trong phòng Hành chính.
SELECT SUM(1) AS TongSoLuongNhanVien
FROM NhanVien NV
JOIN PhongBan PB ON NV.MaPB = PB.MaPB
WHERE PB.TenPB = N'Hành chính';
GO

--12. Xoá dự án có mã dự án là DXD02.
DELETE FROM LuongDA
WHERE MaDA = 'DXD02';
GO

--13. Xoá đi từ bảng LuongDA những nhân viên có mức lương 2000000.
DELETE FROM LuongDA
WHERE SoTien = 2000000;
GO

--14. Cập nhật lại lương cho những người tham gia dự án XDX01 thêm 10% lương cũ.
UPDATE LuongDA
SET SoTien = SoTien * 1.1
WHERE MaDA = 'XDX01';
GO

--15. Xoá các bản ghi tương ứng từ bảng NhanVien đối với những nhân viên không có mã nhân viên
--tồn tại trong bảng LuongDA.
DELETE FROM NhanVien
WHERE NOT EXISTS (
    SELECT 1
    FROM LuongDA LD
    WHERE NhanVien.MaNV = LD.MaNV
);
GO