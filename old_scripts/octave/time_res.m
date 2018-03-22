#! /usr/bin/octave -qf
graphics_toolkit ("gnuplot");
for i=0:9
  time_iter=load(["/g/db/results/time/1/alg_time_res_iter_" int2str(i)]);
  graph_iter_base="/g/db/results/figures/time/1/";
  graph_iter_file=["Alg_time_comp_iter_" int2str(i) ".eps"];
  plot(time_iter(:,1),time_iter(:,4),"+r;MYPSO;",time_iter(:,1),time_iter(:,5),"ob;NDPSO;");
  xlim([0 8100]);
  ylabel("Alg time (mSec)");
  xlabel("Dataset ID");
  title(["Algorithm time comparison, Iteration " int2str(i)]);
  print(gcf,"-color","-deps",fullfile(graph_iter_base,graph_iter_file));
endfor  
graphics_toolkit ("fltk");