#! /usr/bin/octave -qf
graphics_toolkit ("gnuplot");
for i=0:9
  span_iter=load(["/g/db/results/span/1/alg_span_res_iter_" int2str(i)]);
  graph_iter_base="/g/db/results/figures/span/1/";
  graph_iter_file=["span_comp_iter_" int2str(i) ".eps"];
  plot(span_iter(:,1),span_iter(:,2),"+r;MYPSO;",span_iter(:,1),span_iter(:,3),"ob;NDPSO;");
  xlim([0 8100]);
  ylabel("Span");
  xlabel("Dataset ID");
  title(["Span comparison, Iteration " int2str(i)]);
  print(gcf,"-color","-deps",fullfile(graph_iter_base,graph_iter_file));
endfor  
graphics_toolkit ("fltk");

tt=csvread("/g/db/results/tmp/ids.csv");
plot(tt(2:end,1),tt(2:end,2),"+r;fairspan;",tt(2:end,1),tt(2:end,3),"ob;ndpso_avg_span;",tt(2:end,1),tt(2:end,4),"*g;ndpso_min_span;",tt(2:end,1),tt(2:end,5),"hb;ndpso_max_span;");