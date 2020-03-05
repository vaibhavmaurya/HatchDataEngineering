select 
a.*,
b.KotOrderNo,
b.KOTOrderDateAndTime,
b.PayMode,
b.SettlementDateTime
from
hatch_bill_data as a inner join hatch_kot_data as b
on
a.BillDate_and_Time = b.BillDate_and_Time AND
a.BillNo = b.BillNo AND
a.Tbl_ = b.Tbl_ AND
a.Pax = b.Pax AND
a.ItemName = b.ItemName

where a.Restaurant = 'The Estate' and strftime('%d',a.BillDate_and_Time) = '01'

select * from hatch_kot_data as a where a.Restaurant = 'The Estate' and strftime('%d',a.BillDate_and_Time) = '01' and ItemName = 'Akki Rotti'

select * from hatch_bill_data as a where a.Restaurant = 'The Estate' and strftime('%d',a.BillDate_and_Time) = '01' and a.ItemName = 'Akki Rotti'

select * from hatch_bill_data

PRAGMA table_info (hatch_bill_data)

select * from hatch_kot_data

select distinct lower(ItemName), row_number() from hatch_kot_data

CREATE TABLE item_table(
   ItemCode INTEGER PRIMARY KEY AUTOINCREMENT,
   ItemName           TEXT      NOT NULL
);


select ItemCode, count(distinct ItemName) FROM (select  ItemCode, lower(ItemName) as ItemName from hatch_bill_data)
GROUP BY ItemCode
having  count(distinct ItemName) > 1

select distinct ItemName FROM hatch_bill_data
where ItemCode = '9999.0'

insert into item_table  (ItemName)
select  distinct lower(ItemName) as ItemName from hatch_kot_data

select * from item_table

select * from hatch_kot_data


select julianday(datetime('now'));	

select (strftime('%s',SettlementDateTime) - strftime('%s',BillDate_and_Time))/60 from hatch_kot_data
--15:33:00

select * from hatch_kot_data

create view KOT_FULL_VIEW as
SELECT

strftime('%Y',BillDate_and_Time) as Year,

strftime('%d',BillDate_and_Time) as BillDay,

strftime('%m',BillDate_and_Time) as Month,

strftime('%H',BillDate_and_Time) as BHour,
strftime('%H',SettlementDateTime) as SHour,
strftime('%H',KOTOrderDateAndTime) as KHour,

Strftime('%w', BillDate_and_Time)  as weekday,



 CASE 
   WHEN Strftime('%w', BillDate_and_Time) = '0' 
		 OR Strftime('%w', BillDate_and_Time) = '6' THEN 'Y' 
   ELSE 'N' 
 end                                      AS isweekday ,

a.* 

from hatch_kot_data as a;


select * from KOT_FULL_VIEW;

drop view KOT_DURATIONS;
create view KOT_DURATIONS as
select 
strftime('%Y',BillDate_and_Time) as Year,

strftime('%d',BillDate_and_Time) as BillDay,

strftime('%m',BillDate_and_Time) as Month,

Strftime('%w', BillDate_and_Time)  as weekday,
Restaurant,
Tbl_,
Pax,
BillNo,
BillDate_and_Time,
SettlementDateTime,

(strftime('%s',SettlementDateTime) - strftime('%s',BillDate_and_Time))/60 as bill_settled_duration,
(strftime('%s',BillDate_and_Time) - strftime('%s',min(KOTOrderDateAndTime)))/60 as minkot_to_bill_duration,
(strftime('%s',BillDate_and_Time) - strftime('%s',max(KOTOrderDateAndTime)))/60 as maxkot_to_bill_duration,
(strftime('%s',SettlementDateTime) - strftime('%s',max(KOTOrderDateAndTime)))/60 as maxkot_to_settle_duration

from hatch_kot_data

group by
Restaurant,
Tbl_,
Pax,
BillNo,
BillDate_and_Time;


select * from KOT_DURATIONS;





