#! /usr/local/bin/octave -qf
ratios_file_out="/g/db/2/graphs/ratios.eps";
ratio_file_in="/g/db/2/graphs/ratios.csv";
ratio=importdata("/g/db/2/results/ratios.csv",",",1);
graphics_toolkit ("gnuplot");
#bar(prop,ratio_within,";Ratio of datasets within \[0,-5\];","stacked",prop,ratio_out,";Ratio of data sets outside \[0,-5\];","stacked");
bar(ratio.data(:,1),ratio.data(:,6:7),'stacked',1);
legend("Ratio of data sets within [0,-5]\% of makespan improvement","Ratio of data sets within ]-5,-41.5]\% of makespan improvement","location","north");
xlim([0 80]);
ylim([0 120]);
set(gca,"xtick",[0:2:80]);
xlabel("Task and machine categories");
ylabel("Ratio (\%)");
print(gcf,"-color","-deps",ratios_file_out);
graphics_toolkit ("fltk");