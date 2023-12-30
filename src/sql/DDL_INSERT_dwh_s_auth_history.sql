drop table if exists STV2023111328__DWH.s_auth_history CASCADE;
create table STV2023111328__DWH.s_auth_history
(
    hk_l_user_group_activity bigint not null CONSTRAINT fk_l_user_group_activity REFERENCES STV2023111328__DWH.l_user_group_activity (hk_l_user_group_activity),
    user_id_from integer,
    event varchar(100),
    event_dt datetime,
    load_dt datetime,
    load_scr varchar(20)
)
order by load_dt
SEGMENTED BY hk_l_user_group_activity all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


INSERT INTO STV2023111328__DWH.s_auth_history(hk_l_user_group_activity, user_id_from,event,event_dt,load_dt,load_scr)
select distinct   
	luga.hk_l_user_group_activity,
    gl.user_id_from,
    gl.event,
	gl.datetime, 
	now() as load_dt,
	's3' as load_src
from STV2023111328__STAGING.group_log as gl
left join STV2023111328__DWH.h_groups as hg on gl.group_id = hg.group_id
left join STV2023111328__DWH.h_users as hu on gl.user_id = hu.user_id
left join STV2023111328__DWH.l_user_group_activity as luga on (hg.hk_group_id = luga.hk_group_id) and (hu.hk_user_id = luga.hk_user_id)
where luga.hk_l_user_group_activity not in (select hk_l_user_group_activity from STV2023111328__DWH.s_auth_history)
and gl.event = 'add' or gl.event = 'leave';



