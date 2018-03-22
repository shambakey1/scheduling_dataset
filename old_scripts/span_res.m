plot(span_0(:,1),span_0(:,2),"+;MYPSO;",span_0(:,1),span_0(:,3),"o;NDPSO;")
xlim ([0 8100]);
ylabel ("Span");
xlabel ("Dataset ID");
title("Span comparison, iteration 0");
print -color -depsc2 "/g/db/results/figures/span_comp_iter_0"