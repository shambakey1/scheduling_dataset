########## CURRENT EXPERIMENT FOR NDPSO USES CONVERSION THRESHOLD OF 100 ITERATIONS AND TAKES FAIRSPAN RESULTS FOR INITILIZATION ############
########## STORE CURRENT VALUES OF NDPSO AND NDPSO_RESULT_PROP IN NEW TABLES  #################
drop table if exists ndpso_conv_100_fairspan_init;
create table ndpso_conv_100_fairspan_init like ndpso;
insert into ndpso_conv_100_fairspan_init (select * from ndpso);
drop table if exists ndpso_result_prop_conv_100_fairspan_init;
create table ndpso_result_prop_conv_100_fairspan_init like ndpso_result_prop;
insert into ndpso_result_prop_conv_100_fairspan_init (select * from ndpso_result_prop);

################### COMPARE SFMS AND NDPSO WITH CONVERSION THRESHOLD OF 100 AND FAIRSPAN INITIALIZATION FOR EACH ITERATION FOR EACH DATASET ###########
drop table if exists sfms_ndpso_result_prop_conv_100_fairspan_init_comp;
create table sfms_ndpso_result_prop_conv_100_fairspan_init_comp (select ndpso_result_prop_conv_100_fairspan_init.*, 
(ndpso_result_prop_conv_100_fairspan_init.time/ndpso_result_prop_conv_100_fairspan_init.end_conv_iter) as time_per_loop,
(ndpso_result_prop_conv_100_fairspan_init.time*(ndpso_result_prop_conv_100_fairspan_init.start_conv_iter+1)/ndpso_result_prop_conv_100_fairspan_init.end_conv_iter) as min_time_to_conv, 
fairspan_result_prop.span as fairspan_span, fairspan_result_prop.time as fairspan_time, 
((ndpso_result_prop_conv_100_fairspan_init.objectives-fairspan_result_prop.span)*100/greatest(ndpso_result_prop_conv_100_fairspan_init.objectives,fairspan_result_prop.span)) as span_impr_perc,
((ndpso_result_prop_conv_100_fairspan_init.time-fairspan_result_prop.time)*100/if(ndpso_result_prop_conv_100_fairspan_init.time=fairspan_result_prop.time,1,greatest(ndpso_result_prop_conv_100_fairspan_init.time,fairspan_result_prop.time))) as time_impr_perc,
((floor(ndpso_result_prop_conv_100_fairspan_init.time*(ndpso_result_prop_conv_100_fairspan_init.start_conv_iter+1)/ndpso_result_prop_conv_100_fairspan_init.end_conv_iter)-fairspan_result_prop.time)*100/if(floor(ndpso_result_prop_conv_100_fairspan_init.time*(ndpso_result_prop_conv_100_fairspan_init.start_conv_iter+1)/ndpso_result_prop_conv_100_fairspan_init.end_conv_iter)=fairspan_result_prop.time,1,greatest(fairspan_result_prop.time,floor(ndpso_result_prop_conv_100_fairspan_init.time*(ndpso_result_prop_conv_100_fairspan_init.start_conv_iter+1)/ndpso_result_prop_conv_100_fairspan_init.end_conv_iter)))) as time_impr_perc_min_conv
 from ndpso_result_prop_conv_100_fairspan_init, fairspan_result_prop 
where ndpso_result_prop_conv_100_fairspan_init.dataset_conf_id=fairspan_result_prop.dataset_conf_id and fairspan_result_prop.iter_no=0);

################### COMPARE SFMS AND NDPSO WITH CONVERSION THRESHOLD OF 100 AND FAIRSPAN INITIALIZATION OVER ALL ITERATIONS FOR THE SAME DATASET ###########
drop table if exists sfms_ndpso_result_prop_avg_conv_100_fairspan_init_comp;
create table sfms_ndpso_result_prop_avg_conv_100_fairspan_init_comp (select dataset_conf_id,
avg(time) as ndpso_avg_time,
avg(map_time) as ndpso_avg_map_time,
avg(objectives) as ndpso_avg_span,
avg(start_conv_iter) as ndpso_avg_start_conv_iter,
avg(end_conv_iter) as ndpso_avg_end_conv_iter,
avg(time_per_loop) as ndpso_avg_time_per_loop,
avg(min_time_to_conv) as ndpso_avg_min_time_to_conv,
avg(fairspan_span) as sfms_span,
avg(fairspan_time) as sfms_time,
avg(span_impr_perc) as span_impr_perc_avg,
avg(time_impr_perc) as time_impr_perc_avg,
avg(time_impr_perc_min_conv) as time_impr_perc_min_conv_avg,
(avg(time_impr_perc)*0.9+avg(span_impr_perc)*0.1) as time_span_90_10,
(avg(time_impr_perc)*0.8+avg(span_impr_perc)*0.2) as time_span_80_20,
(avg(time_impr_perc)*0.7+avg(span_impr_perc)*0.3) as time_span_70_30,
(avg(time_impr_perc)*0.6+avg(span_impr_perc)*0.4) as time_span_60_40,
(avg(time_impr_perc)*0.5+avg(span_impr_perc)*0.5) as time_span_50_50,
(avg(time_impr_perc)*0.4+avg(span_impr_perc)*0.6) as time_span_40_60,
(avg(time_impr_perc)*0.3+avg(span_impr_perc)*0.7) as time_span_30_70,
(avg(time_impr_perc)*0.2+avg(span_impr_perc)*0.8) as time_span_20_80,
(avg(time_impr_perc)*0.1+avg(span_impr_perc)*0.9) as time_span_10_90,
(avg(time_impr_perc_min_conv)*0.9+avg(span_impr_perc)*0.1) as time_span_min_conv_90_10,
(avg(time_impr_perc_min_conv)*0.8+avg(span_impr_perc)*0.2) as time_span_min_conv_80_20,
(avg(time_impr_perc_min_conv)*0.7+avg(span_impr_perc)*0.3) as time_span_min_conv_70_30,
(avg(time_impr_perc_min_conv)*0.6+avg(span_impr_perc)*0.4) as time_span_min_conv_60_40,
(avg(time_impr_perc_min_conv)*0.5+avg(span_impr_perc)*0.5) as time_span_min_conv_50_50,
(avg(time_impr_perc_min_conv)*0.4+avg(span_impr_perc)*0.6) as time_span_min_conv_40_60,
(avg(time_impr_perc_min_conv)*0.3+avg(span_impr_perc)*0.7) as time_span_min_conv_30_70,
(avg(time_impr_perc_min_conv)*0.2+avg(span_impr_perc)*0.8) as time_span_min_conv_20_80,
(avg(time_impr_perc_min_conv)*0.1+avg(span_impr_perc)*0.9) as time_span_min_conv_10_90
from sfms_ndpso_result_prop_conv_100_fairspan_init_comp group by dataset_conf_id);

############### PRINT FINAL RESULTS ################
select * from sfms_ndpso_result_prop_conv_100_fairspan_init_comp;
select * from sfms_ndpso_result_prop_avg_conv_100_fairspan_init_comp;
##################################
describe sfms_ndpso_result_prop_avg_conv_100_fairspan_init_comp;
set @count=(select count(*) from sfms_ndpso_result_prop_avg_conv_100_fairspan_init_comp);
select (select count(*) from sfms_ndpso_result_prop_avg_conv_100_fairspan_init_comp where span_impr_perc_avg>=-5)/@count*100;
select * from dataset_conf where id in (select dataset_conf_id from sfms_ndpso_result_prop_avg_conv_100_fairspan_init_comp where span_impr_perc_avg>=-5);
select * from dataset_conf where id in (1,2);
set @x_low="0";
set @x_medium="0";
set @x_high="0";
select * from dataset_conf where task_hetero in (@x_low,@x_medium,@x_high);