DELIMITER $$
 DROP PROCEDURE IF EXISTS test_span_results$$
 CREATE PROCEDURE test_span_results()
 BEGIN
set @iter_no=0;

 WHILE @iter_no<10 DO
	 drop table if exists mypso_span;
	 drop table if exists ndpso_span;
	 #drop table if exists fairspan_time;
	 #drop table if exists alg_time;
	 create temporary table if not exists mypso_span (select dataset_conf_id,max(span) as mypso_span from mypso where iter_no=@iter_no group by dataset_conf_id);
	 create temporary table if not exists ndpso_span (select dataset_conf_id,max(span) as ndpso_span from ndpso where iter_no=@iter_no group by dataset_conf_id);
	 #create temporary table if not exists fairspan_time (select dataset_conf_id,time as fairspan_time from fairspan_result_prop where iter_no=@iter_no);
	 #create temporary table if not exists alg_time (select mypso_time.dataset_conf_id,pso_time,pso_to_task_time,(pso_time+pso_to_task_time) as mypso_total_time,ndpso_time,fairspan_time from mypso_time, ndpso_time, fairspan_time where mypso_time.dataset_conf_id=ndpso_time.dataset_conf_id=fairspan_time.dataset_conf_id);
	 set @res_path=CONCAT("\'/g/db/results/alg_span_res_iter_",@iter_no,"\'");
	 #set @mypso_str=concat("select mypso_time.dataset_conf_id,pso_time,pso_to_task_time,(pso_time+pso_to_task_time) as mypso_total_time,ndpso_time,fairspan_time from mypso_time, ndpso_time, fairspan_time where mypso_time.dataset_conf_id=ndpso_time.dataset_conf_id=fairspan_time.dataset_conf_id into outfile ",@res_path);
     set @mypso_str=concat("select mypso_span.dataset_conf_id,mypso_span,ndpso_span from mypso_span, ndpso_span where mypso_span.dataset_conf_id=ndpso_span.dataset_conf_id into outfile ",@res_path);
	 prepare mypso_stat from @mypso_str;
	 execute mypso_stat;
	 deallocate prepare mypso_stat;
     set @end_cur_iter=concat("done iteration ",@iter_no);
	 SELECT @end_cur_iter;
	 SET  @iter_no=@iter_no+1; 
 END WHILE;
 END$$
DELIMITER ;

CALL test_span_results();
