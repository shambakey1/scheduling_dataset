#! /usr/bin/octave -qf
############### LOAD REQUIRED RESULTS #################
in_data_fairspan=importdata("/g/db/res_1/fairspan_result_prop.csv");
in_data_ndpso=importdata("/g/db/res_1/ndpso_result_prop.csv");
in_data_ndpso_conv_100=importdata("/g/db/res_1/ndpso_result_prop_conv_th_100.csv");
in_data_ndpso_conv_100_fairspan_initial=importdata("/g/db/res_1/ndpso_result_prop_conv_th_100_with_fairspan_initial_solution.csv");
fairspan_dataset_conf_id=1;
fairspan_iter_no=2;
fairspan_time_id=3;
fairspan_span_id=4;
ndpso_dataset_conf_id=1;
ndpso_iter_no=2;
ndpso_time_id=3;
ndpso_map_time_id=4;
ndpso_span_id=5;
ndpso_start_conv_id=7;
ndpso_end_conv_id=8;


