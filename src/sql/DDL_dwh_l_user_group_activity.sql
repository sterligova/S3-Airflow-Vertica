drop table if exists STV2023111328__DWH.l_user_group_activity CASCADE;

create table STV2023111328__DWH.l_user_group_activity
(
	hk_l_user_group_activity bigint primary key,
	hk_user_id bigint not null CONSTRAINT fk_h_users REFERENCES STV2023111328__DWH.h_users (hk_user_id),
	hk_group_id bigint not null CONSTRAINT fk_h_groups REFERENCES STV2023111328__DWH.h_groups (hk_group_id),
	load_dt           datetime,
	load_src          varchar(20)
)
order by load_dt
SEGMENTED BY hk_l_user_group_activity all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);