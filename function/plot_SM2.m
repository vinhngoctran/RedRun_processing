function plot_SM2()
%%
close all;

load('Selected_KDET.mat');
for i=1:size(SelectedData,1)-11
    HouRain(i,:) = sum(SelectedData(i:i+11,:));
end
load('E:\Clinton\IDF.mat');
YR = [1 2 5 10 25 50 100 200 500 1000]';
IDF = IDF * 25.4;
RP = [1.14	1.37	1.74	2.06	2.51	2.87	3.24	3.63	4.16	4.56]'*25.4;
MaxRain = max(HouRain);
% modefit = fit(IDF(:,2),YR,'exp1');
modefit = fit(RP,YR,'linearinterp');
Return = modefit(MaxRain);
Return(10)=1;
CC = rand(14,3);
close all
Name = ["a. \Deltah > 0.5m","b. \Deltah > 1m","c. \Deltah > 1.5m"];
DH = [0.5,1,1.5];
Col = ["k","g","r"];
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
figure1 = figure('OuterPosition',[300 20 1200 700]);

axes1 = axes('Parent',figure1,...
    'Position',[0.1 0.7 0.26 0.15]);hold on
    i=5;
    b=bar(SelectedDate(:,i),SelectedData(:,i) );
    b.FaceColor = CC(i,:);
    ylabel('R_d [mm/15-min]')
    xlim([SelectedDate(1,i) SelectedDate(end,i)])
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','LineWidth',1.5);
title('a','FontSize',16);axes1.TitleHorizontalAlignment = 'left';


TTT = [1:1:size(SelectedData,1)]*15;
axes1 = axes('Parent',figure1,...
    'Position',[0.1 0.25 0.26 0.33]);hold on
for i=1:14
    B = cumsum(SelectedData(:,i));
    plot([0,TTT],[0;B],'LineWidth',1.5,'Color',CC(i,:));
    plot(TTT(end),B(end),'LineStyle','none','Marker','square','MarkerSize',15,'DisplayName',datestr(SelectedDate(1,i),'mm-dd-yyyy'),'MarkerEdgeColor',CC(i,:),'LineWidth',1.5);
end
ylabel('R_c [mm]');
xlabel('Time [min]');xlim([0 max(TTT)]);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','LineWidth',1.5);
title('b','FontSize',16);axes1.TitleHorizontalAlignment = 'left';


axes1 = axes('Parent',figure1,...
    'Position',[0.45 0.25 0.5 0.6]);hold on
plot(YR,RP,'LineWidth',1,'Marker','o','Color','k','MarkerFaceColor','k','DisplayName','NOAA''s rainfall frequency curve')
for i=1:14
    ll{i}=plot(Return(i),MaxRain(i),'LineStyle','none','Marker','square','MarkerSize',15,'DisplayName',datestr(SelectedDate(1,i),'mm-dd-yyyy'),'MarkerEdgeColor',CC(i,:),'LineWidth',1.5);
end
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','LineWidth',1.5,'XScale','log');
legend('Location','northwest','Box','off','NumColumns',2);ylim([0 150])
xlabel('Return period [year]'); ylabel('R_d [mm/3-hour]')
title('c','FontSize',16);axes1.TitleHorizontalAlignment = 'left';




% exportgraphics(figure1,"Figs/FM2.jpeg",'Resolution',600)
% exportgraphics(figure1, "Figs/FM2.pdf", 'ContentType', 'vector');
end