function plot_floodResponse2()
%%
close all;
load('Results\Hmax.mat', 'MaxH');
load('Results\KDETA_Run_20090720_Free_OFM_.mat', 'tri0')
load('Results\Hmax_Time.mat',"TimeMax","TimeMax0205");
load('Results\Hmax_AreaTime.mat','AreaTimeMax0205');
for i=1:size(tri0,2)
    CentXY(i,:) = [tri0(i).centX,tri0(i).centY,tri0(i).area];
end
Warren = shaperead("Map/SelectedArea_2.shp");

XX = Warren.X(1:end)';
YY = Warren.Y(1:end)';
[in,on] = inpolygon(CentXY(:,1),CentXY(:,2),XX,YY);
AREA = CentXY(in,3);
for i=1:size(MaxH,1)
    for j=1:2
        MaxHArea{i,j} = MaxH{i,j}(in,:);
    end
end

clearvars HouRain
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
DH = [0.1:0.1:2];
Event = 5;

for i=1:size(MaxH,1)
    for j=1:numel(DH)
        idx = find(MaxHArea{i,1}(:,3)>DH(j));
        AreaFlood(j,i) = sum(AREA(idx,1))/1000000;
        VolFlood(j,i) = 0;
        for k=1:numel(idx)
            VolFlood(j,i) = VolFlood(j,i)+AREA(idx(k),1)*MaxHArea{i,1}(idx(k),3);
        end
    end
end


Return(1:end,2) = [1:1:14]';
Return2 = sortrows(Return,1);
% load('E:\Clinton\IDF_SterlingHeight.mat')
% MaxRain = max(SelectedData);
% modefit = fit(IDF(:,2),IDF(:,1),'exp1');
% Return = modefit(MaxRain);
close all
Name = ["a. \Deltah > 0.5m","b. \Deltah > 1m","c. \Deltah > 1.5m"];
Col = ["k","g","r"];
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
figure1 = figure('OuterPosition',[300 20 1200 800]);

axes1 = axes('Parent',figure1,...
    'Position',[0.25 0.1 0.26 0.35]);hold on;
for i=1:14
    if i==1
        plot(AreaFlood(:,Return2(i,2)),DH,"LineWidth",1,'DisplayName',['P = ','0.1',' year'])
    else
    plot(AreaFlood(:,Return2(i,2)),DH,"LineWidth",1,'DisplayName',['P = ',num2str(round(Return2(i,1),1)),' year'])
    end
end
xlabel('Flooded area [km^2]');ylabel('Inundation depth [m]')
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top');
title('b','FontSize',14);axes1.TitleHorizontalAlignment = 'left';

axes1 = axes('Parent',figure1,...
    'Position',[0.565 0.1 0.26 0.35]);hold on;
for i=1:14
    if i==1
        plot(VolFlood(:,Return2(i,2)),DH,"LineWidth",1,'DisplayName',['P = ','0.1',' year'])
    else
    plot(VolFlood(:,Return2(i,2)),DH,"LineWidth",1,'DisplayName',['P = ',num2str(round(Return2(i,1),1)),' year'])
    end
end
xlabel('Flooded volume [m^2]');ylabel('Inundation depth [m]')
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top');
title('c','FontSize',14);axes1.TitleHorizontalAlignment = 'left';
legend1 = legend;
set(legend1,...
    'Position',[0.805039416780482 0.1 0.123170042678983 0.391089097698136]);


for ii=1:5
TimeMaxE = TimeMax0205{Event,1}(:,3,ii);
TimeMaxE(TimeMaxE<10) = NaN;
TimeMaxE_W = TimeMaxE(in,1);
for i=1:numel(SelectedDate(:,Event))
    idx = find(TimeMaxE_W==i);
    T_FloodArea(i,ii) = sum(AREA(idx))/1000000;
end
end

axes1 = axes('Parent',figure1,...
    'Position',[0.25 0.58 0.6 0.25]);hold on;
% for ii=1:5
for i=1:6
    AF(1,1) = sum(AREA)/1000000;
    AF(2:97,i) = AreaTimeMax0205{Event,1}(:,3,i);
end
area(SelectedDate(:,Event),AF,'FaceAlpha',0.5)
legend(["h≤0.1","0.1<h≤0.5","0.5<h≤1","1<h≤1.5","1.5<h≤2","2<h"],'Location','southwest')
% bar(SelectedDate(:,Event),T_FloodArea);
% end
ylabel('Flooded area [km^2]');
xlim([SelectedDate(1,Event) SelectedDate(end,Event)]);
ylim([0 AF(1,1)]);
set(axes1,'FontSize',12,'Layer','top','TickDir','out',...
    'TickLength',[0.0065 0.00655],'Color','None');
% title('c','FontSize',14);axes1.TitleHorizontalAlignment = 'left';
% xtickformat("MM-dd HH:mm")




axes1 = axes('Parent',figure1,...
    'Position',[0.25 0.837 0.6 0.085]);hold on;
Event = 5;
bar(SelectedDate(:,Event),SelectedData(:,Event),'FaceColor',[0.5 .5 .5],'EdgeColor',[0.9 .9 .9]);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.0065 0.00655],'layer','top');
for i=1:numel(SelectedDate(:,Event))
    if i>3
        RRsum(i,1) = sum(SelectedData(i-3:i,Event));
    end

    if i>7
        RRsum(i,2) = sum(SelectedData(i-7:i,Event));
    end

    if i> 11
        RRsum(i,3) = sum(SelectedData(i-11:i,Event));
    end

    if i > 23
        RRsum(i,4) = sum(SelectedData(i-23:i,Event));
    end
end
STARTT = [4 8 12 24];
NameR = [1 2 3 6];
CC = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E"];
% for i=1:4
%     plot(SelectedDate(STARTT(i):end,Event),RRsum(STARTT(i):end,i),"LineWidth",1.5,'DisplayName',[num2str(NameR(i)),'-hour'],'Color',CC{i})
%     idx = find(RRsum(:,i)==max(RRsum(:,i)));
%     plot([SelectedDate(idx,Event) SelectedDate(idx,Event)],[max(RRsum(:,i)) 150],"LineWidth",1.5,"LineStyle","--",'Color',CC{i})
% end
ylabel('Rainfall');
xlim([SelectedDate(1,Event) SelectedDate(end,Event)]);
set(axes1,'FontSize',12,'Layer','top','TickDir','out',...
    'TickLength',[0.0065 0.00655],...
    'XAxisLocation','top','Xticklabel',[],'YDir','reverse','Color','None');
ylim([0 20]);
title('a','FontSize',14);axes1.TitleHorizontalAlignment = 'left';
% exportgraphics(figure1, "Figs/F4.eps", 'ContentType', 'vector');
% exportgraphics(figure1, "Figs/F4.pdf", 'ContentType', 'vector');
% exportgraphics(figure1,"Figs/F4.jpeg",'Resolution',600);

end