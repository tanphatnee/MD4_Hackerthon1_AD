CREATE DATABASE QUANLYSV;
USE QUANLYSV;

-- Tạo bảng dmkhoa
CREATE TABLE dmkhoa (
    makhoa VARCHAR(20) PRIMARY KEY,
    tenkhoa VARCHAR(255)
);

-- Tạo bảng dmnganh
CREATE TABLE dmnganh (
    manganh INT PRIMARY KEY,
    tennganh VARCHAR(255),
    makhoa VARCHAR(20),
    FOREIGN KEY (makhoa) REFERENCES dmkhoa(makhoa)
);

-- Tạo bảng dmlop
CREATE TABLE dmlop (
    malop VARCHAR(20) PRIMARY KEY,
    tenlop VARCHAR(255),
    manganh INT,
    khoahoc INT,
    hedt VARCHAR(255),
    namnhaphoc INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);
-- Tạo bảng sinhvien
CREATE TABLE sinhvien (
    masv INT PRIMARY KEY,
    hoten VARCHAR(255),
    malop VARCHAR(20),
    gioitinh TINYINT(1),
    ngaysinh DATE,
    diachi VARCHAR(255),
    FOREIGN KEY (malop) REFERENCES dmlop(malop)
);

-- Tạo bảng dmhocphan
CREATE TABLE dmhocphan (
    mahp INT PRIMARY KEY,
    tenhp VARCHAR(255),
    sodvht INT,
    manganh INT,
    hocky INT,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)
);

-- Tạo bảng diemhp
CREATE TABLE diemhp (
    masv INT,
    mahp INT,
    diemhp FLOAT,
    foreign key(masv) references sinhvien(masv),
    FOREIGN KEY (mahp) REFERENCES dmhocphan(mahp)
);


-- THÊM DỮ LIỆU VÀO CÁC BẢNG 
-- Thêm dữ  liệu vào bảng dmkhoa
INSERT INTO dmkhoa (makhoa,tenkhoa) VALUES
 ('CNTT','CÔNG NGHỆ THÔNG TIN'),
 ('KT','KẾ TOÁN'),
 ('SP','SƯ PHẠM');
 
 -- Thêm dữ liệu vào bảng dmnganh
INSERT INTO dmnganh (manganh, tennganh, makhoa)
VALUES
    (140902, 'Sư phạm toán tin', 'SP'),
    (480202, 'Tin học ứng dụng', 'CNTT');

-- Thêm dữ liệu vào bảng dmlop
INSERT INTO dmlop (malop, tenlop, manganh, khoahoc, hedt, namnhaphoc)
VALUES
    ('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
    ('CT12', 'cao đẳng tin học', 480202, 12, 'CĐ', 2013),
    ('CT13', 'cao đẳng tin học', 480202, 13, 'TC', 2014);

-- Thêm dữ liệu vào bảng dmhocphan
INSERT INTO dmhocphan (mahp, tenhp, sodvht, manganh, hocky) VALUES
(1, 'Toán cao cấp A1', 4, 480202, 1),
(2, 'Tiếng anh 1', 3, 480202, 1),
(3, 'Vật lí đại cương', 4, 480202, 1),
(4, 'Tiếng anh 2', 7, 480202, 1),
(5, 'Tiếng anh 1', 3, 140902, 2),
(6, 'Xác suất thống kê', 4, 480202, 2);

INSERT INTO SinhVien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES
(1, 'Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
       (2, 'Nguyễn Thi Cấm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
       (3, 'võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
       (4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
       (5, 'Tran Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạch'),
       (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
       (7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù mỹ'),
       (8, 'Nguyễn Van Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
       (9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài  Nhơn');

-- Thêm dữ liệu vào bảng diemhp
INSERT INTO diemhp (masv, mahp, diemhp) VALUES
(2, 2, 5.9),
(2, 3, 4.5),
(3, 1, 4.3),
(3, 2, 6.7),
(3, 3, 7.3),
(4, 1, 4),
(4, 2, 5.2),
(4, 3, 3.5),
(5, 1, 9.8),
(5, 2, 7.9),
(5, 3, 7.5),
(6, 1, 6.1),
(6, 2, 5.6),
(6, 3, 4),
(7, 1, 6.2);
-- Thực hiện các câu  lệnh truy vấn 
-- * câu lệnh truy vấn lồng .
-- 1. Cho biết họ tên sinh viên KHÔNG học học phần nào 
SELECT masv AS MaSV, hoten AS HoTen
FROM sinhvien
WHERE masv NOT IN (
    SELECT DISTINCT masv
    FROM diemhp
);

-- 2. Cho biết họ tên sinh viên CHƯA học học phần nào có mã 1 
	SELECT masv AS MaSV, hoten AS HoTen
	FROM sinhvien
	WHERE masv NOT IN (
		SELECT DISTINCT masv
		FROM diemhp
		WHERE mahp = 1
	);
-- 3. Cho biết Tên học phần KHÔNG có sinh viên điểm HP <5. 
SELECT mahp AS MaHP, tenhp AS TenHocPhan
FROM dmhocphan
WHERE mahp NOT IN (
    SELECT DISTINCT mahp
    FROM diemhp
    WHERE diemhp < 5
);
-- 4.	Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5 
SELECT masv AS MaSV, hoten AS HoTen
FROM sinhvien
WHERE  masv NOT IN (
    SELECT DISTINCT masv
    FROM diemhp
    WHERE diemhp < 5
);
-- 	DẠNG CẤU TRÚC LỒNG NHAU KHÔNG KẾT NỐI
-- 5.	Cho biết Tên lớp có sinh viên tên Hoa .
SELECT dmlop.tenlop AS TenLop
FROM dmlop
WHERE dmlop.malop IN (
    SELECT sinhvien.malop
    FROM sinhvien
    WHERE sinhvien.hoten LIKE '%Hoa%'
);
-- 6.	Cho biết HoTen sinh viên có điểm học phần 1 là <5.
SELECT hoten AS HoTen
FROM sinhvien
WHERE masv IN (
    SELECT masv
    FROM diemhp
    WHERE mahp = 1 AND diemhp < 5
);
-- 7.	Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị học trình của học phần mã 1.
SELECT mahp AS MaHP, tenhp AS TenHocPhan, sodvht AS SoDvht, hocky AS HocKy
FROM dmhocphan
WHERE sodvht >= (
    SELECT sodvht
    FROM dmhocphan
    WHERE mahp = 1
);
-- 	DẠNG TRUY VẤN VỚI LƯỢNG TỪ: ALL, ANY, EXISTS
-- 8.	Cho biết HoTen sinh viên có DiemHP cao nhất. (ALL)
SELECT sv.masv , sv.HoTen, dh.MaHP, dh.DiemHP
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
WHERE dh.DiemHP = (SELECT MAX(DiemHP) FROM diemhp);
-- 9.	Cho biết MaSV, HoTen sinh viên có điểm học phần mã 1 cao nhất.
SELECT sv.MaSV, sv.HoTen
FROM sinhvien sv
JOIN (SELECT MaSV FROM diemhp WHERE MaHP = 1 ORDER BY DiemHP DESC LIMIT 1) dh ON sv.MaSV = dh.MaSV;
-- 10.	Cho biết MaSV, MaHP có điểm HP lớn hơn bất kì các điểm HP của sinh viên mã 3 (ANY).
SELECT masv AS MaSV, mahp AS MaHP
FROM diemhp
WHERE diemhp > ANY (
    SELECT diemhp
    FROM diemhp
    WHERE masv = 3
)
AND diemhp IS NOT NULL;
-- 11.	Cho biết MaSV, HoTen sinh viên ít nhất một lần học học phần nào đó. (EXISTS)
SELECT masv AS MaSV, hoten AS HoTen
FROM sinhvien
WHERE EXISTS (
    SELECT 1
    FROM diemhp
    WHERE sinhvien.masv = diemhp.masv
);
-- 12.	Cho biết MaSV, HoTen sinh viên đã không học học phần nào. (EXISTS)
SELECT masv AS MaSV, hoten AS HoTen
FROM sinhvien
WHERE NOT EXISTS (
    SELECT 1
    FROM diemhp
    WHERE sinhvien.masv = diemhp.masv
);
-- 	DẠNG TRUY VẤN VỚI CẤU TRÚC TẬP HỢP: UNION
-- 13.	Cho biết MaSV đã học ít nhất một trong hai học phần có mã 1, 2. 
SELECT masv AS MaSV
FROM diemhp
WHERE mahp = 1
UNION
SELECT masv AS MaSV
FROM diemhp
WHERE mahp = 2;
-- 14.	Tạo thủ tục có tên KIEM_TRA_LOP cho biết HoTen sinh viên KHÔNG có điểm HP <5 ở lớp có mã chỉ định (tức là tham số truyền vào procedure là mã lớp). Phải kiểm tra MaLop chỉ định có trong danh mục hay không, nếu không thì hiển thị thông báo ‘Lớp này không có trong danh mục’. Khi lớp tồn tại thì đưa ra kết quả.
-- Ví dụ gọi thủ tục: Call KIEM_TRA_LOP(‘CT12’).
DELIMITER //
CREATE PROCEDURE KIEM_TRA_LOP(IN malop VARCHAR(20))
BEGIN
    DECLARE count_l INT;
    SELECT COUNT(*) INTO count_l
    FROM dmlop
    WHERE malop = malop;
    IF count_l = 0 THEN
        SELECT 'Lớp này không có trong danh mục' AS KetQua;
    ELSE
        SELECT hoten AS HoTen
        FROM sinhvien
        WHERE malop = malop
        AND masv NOT IN (
            SELECT masv
            FROM diemhp
            WHERE diemhp < 5
        );
    END IF;
END //
DELIMITER ;
CALL KIEM_TRA_LOP('CT12');

-- 15.	Tạo một trigger để kiểm tra tính hợp lệ của dữ liệu nhập vào bảng sinhvien là MaSV không được rỗng  Nếu rỗng hiển thị thông báo ‘Mã sinh viên phải được nhập’.
DELIMITER //
CREATE TRIGGER tr_check_MaSV_not_empty
BEFORE INSERT ON sinhvien
FOR EACH ROW
BEGIN
    IF NEW.MaSV IS NULL OR NEW.MaSV = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã sinh viên phải được nhập';
    END IF;
END //
DELIMITER ;
-- 16.	Tạo một TRIGGER khi thêm một sinh viên trong bảng sinhvien ở một lớp nào đó thì cột SiSo của lớp đó trong bảng dmlop (các bạn tạo thêm một cột SiSo trong bảng dmlop) tự động tăng lên 1, đảm bảo tính toàn vẹn dữ liệu khi thêm một sinh viên mới trong bảng sinhvien thì sinh viên đó phải có mã lớp trong bảng dmlop. Đảm bảo tính toàn vẹn dữ liệu khi thêm là mã lớp phải có trong bảng dmlop.
-- Thêm cột SiSo vào bảng dmlop
DELIMITER //
CREATE TRIGGER tr_update_SiSo
AFTER INSERT ON sinhvien
FOR EACH ROW
BEGIN
    UPDATE dmlop
    SET SiSo = SiSo + 1
    WHERE MaLop = NEW.MaLop;
END //
DELIMITER ;
-- 17.	Viết một function DOC_DIEM đọc điểm chữ số thập phân thành chữ  Sau đó ứng dụng để lấy ra MaSV, HoTen, MaHP, DiemHP, DOC_DIEM(DiemHP) để đọc điểm HP của sinh viên đó thành chữ
DELIMITER //
CREATE FUNCTION DOC_DIEM(DiemHP FLOAT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE DiemChu VARCHAR(255);
    CASE
        WHEN DiemHP >= 9.5 THEN SET DiemChu = 'A+';
        WHEN DiemHP >= 8.5 THEN SET DiemChu = 'A';
        WHEN DiemHP >= 7.5 THEN SET DiemChu = 'B+';
        WHEN DiemHP >= 6.5 THEN SET DiemChu = 'B';
        WHEN DiemHP >= 5.5 THEN SET DiemChu = 'C+';
        WHEN DiemHP >= 4.5 THEN SET DiemChu = 'C';
        WHEN DiemHP >= 3.5 THEN SET DiemChu = 'D+';
        WHEN DiemHP >= 2.0 THEN SET DiemChu = 'D';
        ELSE SET DiemChu = 'F';
    END CASE;
    RETURN DiemChu;      
END //
DELIMITER ;
SELECT sv.MaSV,sv.HoTen,dh.MaHP,dh.DiemHP,DOC_DIEM(dh.DiemHP) AS DiemChu
FROM diemhp dh
JOIN sinhvien sv ON dh.MaSV = sv.MaSV        
LIMIT 0, 1000;
-- 18.	Tạo thủ tục: HIEN_THI_DIEM Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của những sinh viên có DiemHP nhỏ hơn số chỉ định, nếu không có thì hiển thị thông báo không có sinh viên nào.
DELIMITER //
CREATE PROCEDURE HIEN_THI_DIEM(IN threshold FLOAT)
BEGIN
    DECLARE student_count INT;
    SELECT COUNT(*) INTO student_count
    FROM sinhvien sv
    JOIN diemhp dh ON sv.MaSV = dh.MaSV
    WHERE dh.DiemHp < threshold;

    IF student_count > 0 THEN
        SELECT sv.MaSV, sv.HoTen, sv.MaLop, dh.DiemHp, dh.MaHP
        FROM sinhvien sv
        JOIN diemhp dh ON sv.MaSV = dh.MaSV
        WHERE dh.DiemHp < threshold;
    ELSE
        SELECT 'Không có sinh viên nào' AS Message;
    END IF;
END //
DELIMITER ;
CALL HIEN_THI_DIEM(5);
-- 19.	Tạo thủ tục: HIEN_THI_MAHP hiển thị HoTen sinh viên CHƯA học học phần có mã chỉ định. Kiểm tra mã học phần chỉ định có trong danh mục không. Nếu không có thì hiển thị thông báo không có học phần này.
DELIMITER //
CREATE PROCEDURE HIEN_THI_MAHP(IN maHP INT)
BEGIN
    DECLARE hphExists INT;
    SELECT COUNT(*) INTO hphExists FROM dmhocphan WHERE MaHP = maHP;
    IF hphExists = 0 THEN
        SELECT 'Không có học phần với mã chỉ định.' AS Message;
    ELSE
        -- Display HoTen sinh viên who have not studied the specified học phần
        SELECT sv.HoTen
        FROM sinhvien sv
        WHERE sv.MaSV NOT IN (SELECT MaSV FROM diemhp WHERE MaHP = maHP);
    END IF;
END //
DELIMITER ;
CALL HIEN_THI_MAHP(1);
-- 20.	Tạo thủ tục: HIEN_THI_TUOI  Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh, GioiTinh, Tuoi của sinh viên có tuổi trong khoảng chỉ định. Nếu không có thì hiển thị không có sinh viên nào.
DELIMITER //
CREATE PROCEDURE HIEN_THI_TUOI(IN TuoiMin INT, IN TuoiMax INT)
BEGIN
    SELECT sv.MaSV, sv.HoTen, sv.MaLop, sv.NgaySinh, sv.Gioitinh,
           TIMESTAMPDIFF(YEAR, sv.NgaySinh, CURDATE()) AS Tuoi
    FROM sinhvien sv
    WHERE TIMESTAMPDIFF(YEAR, sv.NgaySinh, CURDATE()) BETWEEN TuoiMin AND TuoiMax
    UNION
    SELECT NULL, 'Không có sinh viên nào', NULL, NULL, NULL, NULL
    WHERE NOT EXISTS (
        SELECT 1 FROM sinhvien WHERE TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) BETWEEN TuoiMin AND TuoiMax
    );
END //
DELIMITER ;
CALL HIEN_THI_TUOI(20, 30);