function plotdischarge_single_manhole2(SelectedDate,Q2outfall1,Qinoutfall1)

% close all
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
xsize = min([size(Q2outfall1,1)]);
XXX = [1:1:xsize]*15/60;
IV(1:xsize) = 0;
plot(XXX,IV,'LineWidth',1,'Color','k','LineStyle',':');
Houtfall1 = Q2outfall1(1:xsize,1) - Qinoutfall1(1:xsize,1);
Houtfall2 = Q2outfall1(1:xsize,2) - Qinoutfall1(1:xsize,2);
plot(XXX,Houtfall2,'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980],'DisplayName',TT{3});
plot(XXX,Houtfall1,'LineWidth',1.5,'Color',[0 0.4470 0.7410],'DisplayName',TT{2});


xlim([min(XXX) max(XXX)])


end