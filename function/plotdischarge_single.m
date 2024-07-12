function plotdischarge_single(SelectedDate,Q2outfall1,Qinoutfall1,Q2outfall2,Qinoutfall2,i)

% close all
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
xsize = min([size(Q2outfall1,1) size(Q2outfall2,1)]);
IV(1:xsize) = 0;
plot(SelectedDate(1:xsize),IV,'LineWidth',1,'Color','k');
if i==2
     Qinoutfall1(54:57,i,2) = NaN;
     Qinoutfall1(:,i,2) = fillmissing(Qinoutfall1(:,i,2),'linear');
end
Houtfall1 = Q2outfall1(1:xsize,i,1) - Qinoutfall1(1:xsize,i,1);
Houtfall2 = Q2outfall1(1:xsize,i,2) - Qinoutfall1(1:xsize,i,2);
plot(SelectedDate(1:xsize),Houtfall1,'LineWidth',2,'Color','g','DisplayName',TT{2});
plot(SelectedDate(1:xsize),Houtfall2,'LineWidth',2,'Color','r','DisplayName',TT{3});

Houtfall3 = Q2outfall2(1:xsize,i,1) - Qinoutfall2(1:xsize,i,1);
Houtfall4 = Q2outfall2(1:xsize,i,2) - Qinoutfall2(1:xsize,i,2);
plot(SelectedDate(1:xsize),Houtfall3,'LineWidth',2,'Color','g','DisplayName',TT{5},'LineStyle','--');
plot(SelectedDate(1:xsize),Houtfall4,'LineWidth',2,'Color','r','DisplayName',TT{6},'LineStyle','--');


xlim([min(SelectedDate) max(SelectedDate)])

% if i==2
% legend('Position',LegendPOS)
% end

end