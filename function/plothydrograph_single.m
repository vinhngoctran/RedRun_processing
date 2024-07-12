function plothydrograph_single(SelectedDate,Houtfall1,Houtfall2,InvertEle,i,FloodW,CrownE,LegendPOS)

% close all
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
xsize = min([size(Houtfall1,1) size(Houtfall2,1)]);
plot(SelectedDate(1:xsize),Houtfall1(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName',TT{1});
plot(SelectedDate(1:xsize),Houtfall1(1:xsize,i,2),'LineWidth',2,'Color','g','DisplayName',TT{2});
plot(SelectedDate(1:xsize),Houtfall1(1:xsize,i,3),'LineWidth',2,'Color','r','DisplayName',TT{3});

plot(SelectedDate(1:xsize),Houtfall2(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName',TT{4},'LineStyle','--');
plot(SelectedDate(1:xsize),Houtfall2(1:xsize,i,2),'LineWidth',2,'Color','g','DisplayName',TT{5},'LineStyle','--');
plot(SelectedDate(1:xsize),Houtfall2(1:xsize,i,3),'LineWidth',2,'Color','r','DisplayName',TT{6},'LineStyle','--');
IV(1:xsize) = CrownE+InvertEle;
plot(SelectedDate(1:xsize),IV,'LineWidth',2,'Color',[0.5 0.5 0.5],'LineStyle','--','DisplayName','Crown elevation')
IV(1:xsize) = InvertEle;
plot(SelectedDate(1:xsize),IV,'LineWidth',2,'Color',[0.5 0.5 0.5],'LineStyle','-.','DisplayName','Invert elevation')

WN = ["0.2% Annual chance flood","1% Annual chance flood","2% Annual chance flood","10% Annual chance flood"];
CL = ["m","y","c","b"];
xlim([min(SelectedDate) max(SelectedDate)])
for ii=1:4
    IV(1:xsize) = FloodW(ii);
    plot(SelectedDate(1:xsize),IV,'LineWidth',2,'Color',CL{ii},'DisplayName',WN{ii})
end
if i==2
legend('Position',LegendPOS)
end

end