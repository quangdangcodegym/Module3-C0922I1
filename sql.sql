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
END
from giaovien;


