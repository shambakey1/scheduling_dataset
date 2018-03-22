#! /usr/bin/octave -qf
graph_iter_base="/g/db/results/figures/span/1/";
for i=0:9
  iter=load(["/g/db/results/span/1/alg_span_res_iter_" int2str(i)]);
  mypso_span(:,i+1)=iter(:,2);
  ndpso_span(:,i+1)=iter(:,3);
  span_diff(:,i+1)=(ndpso_span(:,i+1)-mypso_span(:,i+1))./ndpso_span(:,i+1)*100;
endfor
dataset_id=iter(:,1);
graphics_toolkit ("gnuplot");
for i=0:9
  graph_iter_file=["mypso_span_improv_ndpso_iter_" int2str(i) ".eps"];
  bar(dataset_id,span_diff(:,i+1));
  xlim([0 8100]);
  ylabel("Span improvement (%)");
  xlabel("Dataset ID");
  title(["Span improvement of MYPSO over NDPSO (%), Iteration " int2str(i)]);
  print(gcf,"-color","-deps",fullfile(graph_iter_base,graph_iter_file));
endfor  
graphics_toolkit ("fltk");