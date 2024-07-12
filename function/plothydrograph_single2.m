function plothydrograph_single2(SelectedDate,Houtfall1,Houtfall2,InvertEle,i,FloodW,CrownE,LegendPOS)

% close all
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
xsize = min([size(Houtfall1,1) size(Houtfall2,1)]);
XXX = [1:1:xsize]*15/60;
if i==2
     Houtfall1(54:57,i,3) = NaN;
     Houtfall1(:,i,3) = fillmissing(Houtfall1(:,i,3),'linear');
end

IV(1:xsize) = CrownE+InvertEle;
% plot(XXX,IV,'LineWidth',1.5,'Color',[0.5 0.5 0.5],'LineStyle','--','DisplayName','Crown elevation')
IVI(1:xsize) = InvertEle;
% plot(XXX,IV,'LineWidth',1.5,'Color',[0.5 0.5 0.5],'LineStyle',':','DisplayName','Invert elevation')
p=patch([XXX fliplr(XXX)].',[IVI fliplr(IV)].',[0.7 0.7 0.7],'DisplayName','Outfall elevation');
set(p ,'FaceColor', [0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7])

WN = ["0.2% Annual chance flood","1% Annual chance flood","2% Annual chance flood","10% Annual chance flood"];
CL = ["#EDB120","#77AC30","#4DBEEE","#7E2F8E"];
xlim([min(XXX) max(XXX)])
for ii=1:4
    IV(1:xsize) = FloodW(ii);
    plot(XXX,IV,'LineWidth',2,'Color',CL{ii},'DisplayName',WN{ii})
end
% plot(SelectedDate(1:xsize),Houtfall1(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName',TT{1});
plot(XXX,Houtfall1(1:xsize,i,3),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980],'DisplayName',TT{3});
plot(XXX,Houtfall1(1:xsize,i,2),'LineWidth',1.5,'Color',[0 0.4470 0.7410],'DisplayName',TT{2});


% plot(SelectedDate(1:xsize),Houtfall2(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName',TT{4},'LineStyle','--');
% plot(SelectedDate(1:xsize),Houtfall2(1:xsize,i,2),'LineWidth',2,'Color','g','DisplayName',TT{5},'LineStyle','--');
% plot(SelectedDate(1:xsize),Houtfall2(1:xsize,i,3),'LineWidth',2,'Color','r','DisplayName',TT{6},'LineStyle','--');
if i==2
legend('Position',LegendPOS,'Box','off')
end

end