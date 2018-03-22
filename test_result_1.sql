DELIMITER $$
 DROP PROCEDURE IF EXISTS test_results$$
 CREATE PROCEDURE test_results()
 BEGIN
set @iter_no=1;

 WHILE @iter_no<=3 DO
 drop table if exists mypso_time;
 create temporary table if not exists mypso_time (select pso_time,pso_to_task_time from mypso_result_prop where iter_no=@iter_no);
 set @res_path=CONCAT("\'/g/db/results/res_",@iter_no,"\'");
set @mypso_str=concat("select * from mypso_time into outfile ",@res_path);
 prepare mypso_stat from @mypso_str;
 execute mypso_stat;
 SET  @iter_no=@iter_no+1; 
 END WHILE;
 deallocate prepare mypso_stat;
 
 END$$
DELIMITER ;

CALL test_results();