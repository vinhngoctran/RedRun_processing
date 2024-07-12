function plotdischarge_single_manhole2(SelectedDate,Q2outfall1,Qinoutfall1)

% close all
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
xsize = min([size(Q2outfall1,1)]);
XXX = [1:1:xsize]*15/60;
IV(1:xsize) = 0;
plot(XXX,IV,'LineWidth',1,'Color','k','LineStyle',':');
Houtfall1 = Q2outfall1(1:xsize,1) - Qinoutfall1(1:xsize,1);
Houtfall2 = Q2outfall1(1:xsize,2) - Qinoutfall1(1:xsize,2);
Houtfall1 = smoothdata(Houtfall1,'loess');
Houtfall2 = smoothdata(Houtfall2,'loess');
plot(XXX,Houtfall2,'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980],'DisplayName',TT{3});
plot(XXX,Houtfall1,'LineWidth',1.5,'Color',[0 0.4470 0.7410],'DisplayName',TT{2});


% Houtfall3 = Q2outfall2(1:xsize,1) - Qinoutfall2(1:xsize,1);
% Houtfall4 = Q2outfall2(1:xsize,2) - Qinoutfall2(1:xsize,2);
% Houtfall3 = smoothdata(Houtfall3,'loess');
% Houtfall4 = smoothdata(Houtfall4,'loess');
% plot(SelectedDate(1:xsize),Houtfall3,'LineWidth',2.5,'Color','g','DisplayName',TT{5},'LineStyle','--');
% plot(SelectedDate(1:xsize),Houtfall4,'LineWidth',1.5,'Color','r','DisplayName',TT{6},'LineStyle','--');


xlim([min(XXX) max(XXX)])

% if i==2
% legend('Position',LegendPOS)
% end

end