WITH user_group_messages AS
  (
 SELECT hk_group_id,
        count(DISTINCT (hk_user_id)) AS cnt_users_in_group_with_messages
   FROM STV2023111328__DWH.l_user_group_activity luga
   GROUP BY hk_group_id
   ),
     user_group_log AS
  (
 SELECT hk_group_id,
        count(DISTINCT (hk_user_id)) AS cnt_added_users
   FROM STV2023111328__DWH.l_user_group_activity luga
   LEFT JOIN STV2023111328__DWH.s_auth_history sah ON luga.hk_l_user_group_activity = sah.hk_l_user_group_activity
   WHERE sah.event = 'add'
   GROUP BY luga.hk_group_id
   )
SELECT ugm.hk_group_id,
       ugl.cnt_added_users,
       ugm.cnt_users_in_group_with_messages,
       (ugm.cnt_users_in_group_with_messages / ugl.cnt_added_users) AS group_conversion
FROM user_group_messages AS ugm
LEFT JOIN user_group_log AS ugl ON ugm.hk_group_id = ugl.hk_group_id
LEFT JOIN STV2023111328__DWH.h_groups AS hg ON ugl.hk_group_id = hg.hk_group_id
WHERE ugm.hk_group_id in
    (SELECT hk_group_id
     FROM STV2023111328__DWH.h_groups hg2
     ORDER BY registration_dt ASC
     LIMIT 10)
ORDER BY group_conversion DESC;