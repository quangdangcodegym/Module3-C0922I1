SELECT *, sum(quantity)
FROM order_item join `order` on `order`.id = `order_item`.id_order
group by id_order;

-- Nhung san pham da ban duoc
SELECT * 
FROM order_item oi join product p on p.id = oi.id_product
group by id_product;

-- Nhung san pham chua ban duoc
select *
from product
where id not in (select oi.id_product
					from order_item as oi);
                    

-- Dung exist
select *
from product as p
where not exists (select oi.id_product
					from order_item as oi where p.id = oi.id_product);
                    
-- Tính lương trung bình của giáo viên bộ môn Hệ thống thông tin
select avg(LUONG) as luong
from giaovien
where MABM  = 'HTTT'
group by MABM;

-- Với mỗi giáo viên, cho biết MAGV và số lượng công việc mà giáo viên đó có tham gia.
select gv.MAGV, gv.HOTEN, count(STT)
from thamgiadt tgdt join congviec cv on tgdt.MADT = cv.MADT and tgdt.STT = cv.SOTT
join giaovien gv on gv.MAGV = tgdt.MAGV
group by gv.MAGV ;

-- Cho biết những bộ môn từ 2 giáo viên trở lên.
select bm.TENBM,count(gv.MAGV) as SLGV 
from bomon bm JOIN giaovien gv on gv.MABM=bm.MABM
group by bm.TENBM
having SLGV>=2;

select *
from bomon bm JOIN giaovien gv on gv.MABM=bm.MABM;

-- Câu A6: Cho những giáo viên có lương nhỏ nhất

select min(luong)
from giaovien;

select * 
from giaovien
where luong = (select min(luong) from giaovien);

select * 
from giaovien
where luong <= all (select luong from giaovien);

-- Câu A8: Cho biết bộ môn (MABM) có đông giáo viên nhất
select *, count(MAGV)
from giaovien
group by MABM
having count(MAGV) = (select max(t.tcount) from (select count(MAGV) as tcount from giaovien group by MABM) as t);

select *, count(MAGV)
from giaovien
group by MABM
having count(MAGV) >= all ( select count(MAGV)
								from giaovien
								group by MABM);

-- Cho biết những giáo viên có lương lớn hơn lương trung bình của bộ môn mà giáo viên đó làm việc.
SELECT * 
FROM giaovien gv
where luong >= (SELECT avg(LUONG)
				FROM giaovien gv1
				where gv1.MABM = gv.MABM);
                
SELECT gv.MAGV,gv.HOTEN
FROM GIAOVIEN gv
JOIN (SELECT BM.MABM ,AVG(LUONG) as TBLUONG
       from GIAOVIEN
                JOIN BOMON BM ON GIAOVIEN.MABM = BM.MABM
       GROUP BY BM.MABM)as T ON T.MABM=gv.MABM
WHERE LUONG>=T.TBLUONG;


-- Với mỗi bộ môn, cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
select *, ifnull(temp.dem,0) as temp
from bomon bm left join  (SELECT MABM,count(MAGV) as dem FROM giaovien group by MABM) as temp on  bm.MABM = temp.MABM;

SELECT BOMON.TENBM, COUNT(MAGV)
FROM GIAOVIEN
RIGHT JOIN BOMON on GIAOVIEN.MABM = BOMON.MABM
GROUP BY BOMON.TENBM;

select *, (select count(gv.MAGV) from giaovien gv where gv.MABM = bm.MABM)
from bomon bm;
                
SELECT *, (SELECT COUNT(GIAOVIEN.MAGV) FROM GIAOVIEN WHERE GIAOVIEN.MABM = BOMON.MABM)
FROM BOMON; 

-- Cho biết những đề tài mà giáo viên ‘003’ không tham gia.
SELECT * 
FROM detai
where MADT not in (SELECT  MADT 
					FROM thamgiadt tgdt
					where tgdt.MAGV = '003');

select *
from bomon bm JOIN giaovien gv on gv.MABM=bm.MABM;

select *
from bomon bm, giaovien gv
where gv.MABM=bm.MABM;

drop spTinhLuongTBTheoBM if exists
delimiter //
create procedure spTinhLuongTBTheoBM(
	IN pTenBM varchar(20)
)
BEGIN
		select avg(LUONG) as luong
		from giaovien
		where MABM  = pTenBM
		group by MABM;
END //;

drop spTinhLuongTBTheoBM1 if exists
delimiter //
create procedure spTinhLuongTBTheoBM1(
	IN pMaBM varchar(20),
    OUT pMessage varchar(200)
)
BEGIN
	if(exists (select * from bomon where MABM = pMaBM)) then
		select avg(LUONG) as luong
		from giaovien
		where MABM  = pMaBM
		group by MABM;
	else
		set pMessage = 'ID khong ton tai';
	end if;
        
END //


-- Q78. Xóa các đề tài thuộc chủ đề “NCPT”.
			
-- Xuất ra thông tin của giáo viên (MAGV, HOTEN) và mức lương của giáo viên. 
-- Mức lương được xếp theo,quy tắc: Lương của giáo viên < $1800 : “THẤP” ; 
-- Từ $1800 đến $2200: TRUNG BÌNH; Lương > $2200:“CAO”
use c9_quanlydetai;
select *, CASE
    WHEN LUONG < 1800 THEN "THẤP"
    WHEN LUONG > 1800 and LUONG < 2200 THEN "TRUNG BÌNH"
    ELSE "CAO" 
END as thuhang
from giaovien;

/**
Q81. Xuất ra thông tin thu nhập của giáo viên. Thu nhập của giáo viên được tính bằng LƯƠNG + PHỤ CẤP. 
Nếu giáo viên là trưởng bộ môn thì PHỤ CẤP là 300, và giáo viên là trưởng khoa thì PHỤ CẤP là 600.
**/
SELECT MAGV,LUONG, (LUONG + if( exists (SELECT * FROM bomon where TRUONGBM = gv.MAGV), 300, 0)
							+if( exists (SELECT * FROM khoa where TRUONGKHOA = gv.MAGV), 600, 0)
					)  as phucap
FROM giaovien gv;

SELECT GV.MAGV, GV.HOTEN,LUONG,
       CASE
           WHEN (K.TRUONGKHOA IS NOT NULL AND B.TRUONGBM IS NOT NULL) THEN (LUONG +900)
           WHEN K.TRUONGKHOA IS NOT NULL THEN (LUONG + 600)
           WHEN B.TRUONGBM IS NOT NULL THEN (LUONG+300)
           ELSE (LUONG)
END AS THUNHAP
FROM GIAOVIEN GV
LEFT JOIN KHOA K ON GV.MAGV = K.TRUONGKHOA
LEFT JOIN BOMON B on GV.MAGV=B.TRUONGBM;

/**
Q82. Xuất ra năm mà giáo viên dự kiến sẽ nghĩ hưu với quy định: Tuổi nghỉ hưu của Nam là 60, của Nữ là 55.
**/

select *, CASE
    WHEN PHAI = 'Nam' THEN year(DATE_ADD(NGSINH, INTERVAL 60 YEAR))
    WHEN PHAI = 'Nữ' THEN year(DATE_ADD(NGSINH, INTERVAL 55 YEAR))
END as namvehuu
from giaovien;

SELECT GV.HOTEN,
       GV.NGSINH,
       CASE
           WHEN GV.PHAI = 'Nam' THEN YEAR(NOW()) + 60 - (year(NOW()) - YEAR(GV.NGSINH))
           WHEN GV.PHAI = 'Nữ' THEN YEAR(NOW()) + 55 - (YEAR(NOW()) - YEAR(GV.NGSINH))
           END AS NAMNGHIHUU
FROM GIAOVIEN GV;


/**
Q80. Xuất ra thông tin giáo viên (MAGV, HOTEN) và xếp hạng dựa vào mức lương. Nếu giáo viên có lương cao
nhất thì hạng là 1.
**/
CREATE DEFINER=`root`@`localhost` PROCEDURE `spThuHangLuongGiaoVien`()
BEGIN
	SET @rank=0;
    select *
    from giaovien gv1 join (select *, @rank:=@rank+1 AS hang
							from (	select distinct LUONG
									from giaovien
									order by LUONG DESC) as t
							) as temp on gv1.LUONG = temp.LUONG order by temp.hang;
END

SELECT MAGV,
       HOTEN,
       LUONG,
       DENSE_RANK()  OVER (ORDER BY LUONG DESC ) LUONG_RANK
FROM giaovien;


-- Viết procedure thực hiện các chức năng:
# Câu 1: Hoàn thiện thêm giáo viên
#  + Truyền vào: HOTEN,LUONG,PHAI,NGSINH,GVQLCM, MABM
#  + Không cần truyền mã giáo viên, tự động sinh mã giáo viên mới và thêm vào.
#  Thêm thành công thì trả ra MAGV mới, không thêm được thì trả MAGV mới = NULL. Đổi lại dùng tham số INOUT
#  + Kiểm tra tồn tại MABM trước khi thêm
-- Lấy id cuối cùng +1
DELIMITER //
DROP PROCEDURE IF EXISTS getLastId;
CREATE PROCEDURE getLastId(OUT id char(3))
BEGIN
    -- SELECT CAST(GV.MAGV AS DECIMAL) + 1 INTO id FROM (SELECT MAGV FROM GIAOVIEN ORDER BY MAGV DESC LIMIT 1) AS GV;
    declare maxId integer;
    
    set id = (SELECT CAST(GV.MAGV AS DECIMAL) + 1 FROM (SELECT MAGV FROM GIAOVIEN ORDER BY MAGV DESC LIMIT 1) AS GV);
	if(id <10) then
		set id = concat('00', id);
	else
		if(id <100) then
			set id = concat('0', id);
        end if;
    end if;
end //
DELIMITER ;
-- Procedure thêm giáo viên.
DELIMITER //
DROP PROCEDURE IF EXISTS addNewTeacher;
CREATE PROCEDURE addNewTeacher(
			tHOTEN VARCHAR(50), tLUONG DECIMAL(10, 1), tPHAI VARCHAR(3), tNGSINH DATE,
			tGVQLCM VARCHAR(3), tMABM VARCHAR(4), 
            OUT tMAGV VARCHAR(3))
BEGIN
	-- declare biến: khai báo biến
    -- gán giá trị: set 
    -- gán giá trị cho biến 
    IF (EXISTS(SELECT BM.MABM
               FROM BOMON bm
               WHERE bm.MABM = tMABM)) THEN
               
		 set @MaGV = '';
        call getLastId(@MaGV);
        INSERT INTO GIAOVIEN (MAGV,HOTEN, LUONG, PHAI, NGSINH, GVQLCM, MABM)
        VALUES (@MaGV,tHOTEN, tLUONG, tPHAI, tNGSINH, tGVQLCM, tMABM);
        set tMAGV = @MaGV;
    ELSE
        -- SELECT NULL INTO tMAGV;
        set tMAGV = null;
    END IF;
end //

set @tMAGV = '';
CALL addNewTeacher('Đặng Văn Quang12', 2500, 'Nam', '1993-05-12', null, 'HPT', @tMAGV);
SELECT @tMAGV;




