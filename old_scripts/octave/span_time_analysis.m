#! /usr/bin/octave -qf

################## LOAD REQUIRED DATA ################
# load datasets with tasks less than machines
tlm=load("/g/db/results/tmp/mypso_ndpso_result_prop_tasks_less_than_machine.csv");
# load datasets with tasks greater than machines 
tgm=load("/g/db/results/tmp/mypso_ndpso_result_prop_tasks_greater_than_machine.csv");
# load datasets with tasks equal to machines
tem=load("/g/db/results/tmp/mypso_ndpso_result_prop_tasks_equal_machine.csv");

############### GLOBAL VARIABLES #####################
no_ds_machines=rows(tlm)+rows(tgm)+rows(tem); # Total number of records that have more than one machine
fid=fopen("/g/db/results/tmp/tmp_mypso_ndpso_comp.txt","w+");
bound=10;                                     # Boundary limit for ranges. i.e., this will be used for 10%, 20%, .. etc
mypso_id1=5;                                  # Column index 1 for mypso results
ndpso_id1=7;                                  # Column index 1 for ndpso results
imp_id1=0;                                    # Column index 1 for imporvement comparison. To be assigned later

fdisp(fid,"############### MYPSO better or equal to NDPSO ###############");
fdisp(fid,"");

# Extract sets where mypso has better span than ndpso from the previous sets
tlm_mypso=tlm(tlm(:,mypso_id1)<=tlm(:,ndpso_id1),:);
tgm_mypso=tgm(tgm(:,mypso_id1)<=tgm(:,ndpso_id1),:);
tem_mypso=tem(tem(:,mypso_id1)<=tem(:,ndpso_id1),:);

# Specify span improvement percentage of mypso over ndpso in the previous sets
tlm_mypso_imp=[tlm_mypso,(tlm_mypso(:,ndpso_id1)-tlm_mypso(:,mypso_id1))./tlm_mypso(:,ndpso_id1)*100];
tem_mypso_imp=[tem_mypso,(tem_mypso(:,ndpso_id1)-tem_mypso(:,mypso_id1))./tem_mypso(:,ndpso_id1)*100];
tgm_mypso_imp=[tgm_mypso,(tgm_mypso(:,ndpso_id1)-tgm_mypso(:,mypso_id1))./tgm_mypso(:,ndpso_id1)*100];

# Extract ranges for datasets (tasks less than machines) with mypso span equal or better than ndpso
imp_id1=columns(tlm_mypso_imp);               # Re-assign the improvement column index
fdisp(fid,"######## For datasets with tasks are less than machines ########");
fprintf(fid,"]low_bound\thigh_bound]\tNo\tPerc2tlm\tPer2ds\n");
tlm_mypso_imp_max=ceil(max(tlm_mypso_imp(:,imp_id1)));  # Maximum improvement of mypso over ndpso for datasets with tasks less than machines
i=-bound;  # Iteration counter
do
  i+=bound;
  tmp_val=rows(tlm(and(tlm_mypso_imp(:,imp_id1)<=i,tlm_mypso_imp(:,imp_id1)>i-bound),:));
  if(i==0)
    fprintf(fid,"0\t0\t%d\t%f\t%f\n",tmp_val,tmp_val/rows(tlm)*100,tmp_val/no_ds_machines*100);
  elseif
    fprintf(fid,"%d\t%d\t%d\t%f\t%f\n",i-bound,i,tmp_val,tmp_val/rows(tlm)*100,tmp_val/no_ds_machines*100);
  endif
until (i>tlm_mypso_imp_max)

# Extract ranges for datasets (tasks equal to machines) with mypso span equal or better than ndpso
imp_id1=columns(tem_mypso_imp);               # Re-assign the improvement column index
fdisp(fid,"######## For datasets with tasks equal to machines ########");
fprintf(fid,"]low_bound\thigh_bound]\tNo\tPerc2tem\tPer2ds\n");
tem_mypso_imp_max=ceil(max(tem_mypso_imp(:,imp_id1)));  # Maximum improvement of mypso over ndpso for datasets with tasks equal to machines
i=-bound;  # Iteration counter
do
  i+=bound;
  tmp_val=rows(tem(and(tem_mypso_imp(:,imp_id1)<=i,tem_mypso_imp(:,imp_id1)>i-bound),:));
  if(i==0)
    fprintf(fid,"0\t0\t%d\t%f\t%f\n",tmp_val,tmp_val/rows(tem)*100,tmp_val/no_ds_machines*100);
  elseif
    fprintf(fid,"%d\t%d\t%d\t%f\t%f\n",i-bound,i,tmp_val,tmp_val/rows(tem)*100,tmp_val/no_ds_machines*100);
  endif
until (i>tem_mypso_imp_max)

# Extract ranges for datasets (tasks greater than machines) with mypso span equal or better than ndpso
imp_id1=columns(tgm_mypso_imp);               # Re-assign the improvement column index
fdisp(fid,"######## For datasets with tasks greater than machines ########");
fprintf(fid,"]low_bound\thigh_bound]\tNo\tPerc2tgm\tPer2ds\n");
tgm_mypso_imp_max=ceil(max(tgm_mypso_imp(:,imp_id1)));  # Maximum improvement of mypso over ndpso for datasets with tasks greater than machines
i=-bound;  # Iteration counter
do
  i+=bound;
  tmp_val=rows(tgm(and(tgm_mypso_imp(:,imp_id1)<=i,tgm_mypso_imp(:,imp_id1)>i-bound),:));
  if(i==0)
    fprintf(fid,"0\t0\t%d\t%f\t%f\n",tmp_val,tmp_val/rows(tgm)*100,tmp_val/no_ds_machines*100);
  elseif
    fprintf(fid,"%d\t%d\t%d\t%f\t%f\n",i-bound,i,tmp_val,tmp_val/rows(tgm)*100,tmp_val/no_ds_machines*100);
  endif
until (i>tgm_mypso_imp_max)

fdisp(fid,"############### NDPSO better or equal to MYPSO ###############");
fdisp(fid,"");

# Extract sets ndpso has better span than mypso from previous sets
tlm_ndpso=tlm(tlm(:,ndpso_id1)<tlm(:,mypso_id1),:);
tgm_ndpso=tgm(tgm(:,ndpso_id1)<tgm(:,mypso_id1),:);
tem_ndpso=tem(tem(:,ndpso_id1)<tem(:,mypso_id1),:);

# Specify span improvement percentage of ndpso over mypso in the previous sets
tlm_ndpso_imp=[tlm_ndpso,(tlm_ndpso(:,mypso_id1)-tlm_ndpso(:,ndpso_id1))./tlm_ndpso(:,mypso_id1)*100];
tem_ndpso_imp=[tem_ndpso,(tem_ndpso(:,mypso_id1)-tem_ndpso(:,ndpso_id1))./tem_ndpso(:,mypso_id1)*100];
tgm_ndpso_imp=[tgm_ndpso,(tgm_ndpso(:,mypso_id1)-tgm_ndpso(:,ndpso_id1))./tgm_ndpso(:,mypso_id1)*100];

# Extract ranges for datasets (tasks less than machines) with mypso span equal or better than ndpso
imp_id1=columns(tlm_ndpso_imp);               # Re-assign the improvement column index
fdisp(fid,"######## For datasets with tasks are less than machines ########");
fprintf(fid,"]low_bound\thigh_bound]\tNo\tPerc2tlm\tPer2ds\n");
tlm_ndpso_imp_max=ceil(max(tlm_ndpso_imp(:,imp_id1)));  # Maximum improvement of mypso over ndpso for datasets with tasks less than machines
i=-bound;  # Iteration counter
do
  i+=bound;
  tmp_val=rows(tlm(and(tlm_ndpso_imp(:,imp_id1)<=i,tlm_ndpso_imp(:,imp_id1)>i-bound),:));
  if(i==0)
    fprintf(fid,"0\t0\t%d\t%f\t%f\n",tmp_val,tmp_val/rows(tlm)*100,tmp_val/no_ds_machines*100);
  elseif
    fprintf(fid,"%d\t%d\t%d\t%f\t%f\n",i-bound,i,tmp_val,tmp_val/rows(tlm)*100,tmp_val/no_ds_machines*100);
  endif
until (i>tlm_ndpso_imp_max)

# Extract ranges for datasets (tasks equal to machines) with mypso span equal or better than ndpso
imp_id1=columns(tem_ndpso_imp);               # Re-assign the improvement column index
fdisp(fid,"######## For datasets with tasks equal to machines ########");
fprintf(fid,"]low_bound\thigh_bound]\tNo\tPerc2tem\tPer2ds\n");
tem_ndpso_imp_max=ceil(max(tem_ndpso_imp(:,imp_id1)));  # Maximum improvement of mypso over ndpso for datasets with tasks equal to machines
i=-bound;  # Iteration counter
do
  i+=bound;
  tmp_val=rows(tem(and(tem_ndpso_imp(:,imp_id1)<=i,tem_ndpso_imp(:,imp_id1)>i-bound),:));
  if(i==0)
    fprintf(fid,"0\t0\t%d\t%f\t%f\n",tmp_val,tmp_val/rows(tem)*100,tmp_val/no_ds_machines*100);
  elseif
    fprintf(fid,"%d\t%d\t%d\t%f\t%f\n",i-bound,i,tmp_val,tmp_val/rows(tem)*100,tmp_val/no_ds_machines*100);
  endif
until (i>tem_ndpso_imp_max)

# Extract ranges for datasets (tasks greater than machines) with mypso span equal or better than ndpso
imp_id1=columns(tgm_ndpso_imp);               # Re-assign the improvement column index
fdisp(fid,"######## For datasets with tasks greater than machines ########");
fprintf(fid,"]low_bound\thigh_bound]\tNo\tPerc2tgm\tPer2ds\n");
tgm_ndpso_imp_max=ceil(max(tgm_ndpso_imp(:,imp_id1)));  # Maximum improvement of mypso over ndpso for datasets with tasks greater than machines
i=-bound;  # Iteration counter
do
  i+=bound;
  tmp_val=rows(tgm(and(tgm_ndpso_imp(:,imp_id1)<=i,tgm_ndpso_imp(:,imp_id1)>i-bound),:));
  if(i==0)
    fprintf(fid,"0\t0\t%d\t%f\t%f\n",tmp_val,tmp_val/rows(tgm)*100,tmp_val/no_ds_machines*100);
  elseif
    fprintf(fid,"%d\t%d\t%d\t%f\t%f\n",i-bound,i,tmp_val,tmp_val/rows(tgm)*100,tmp_val/no_ds_machines*100);
  endif
until (i>tgm_ndpso_imp_max)

# Close outpuf file
fclose(fid);