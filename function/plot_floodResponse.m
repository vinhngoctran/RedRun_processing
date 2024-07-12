function plot_floodResponse()
%%
close all;
load('Results\Hmax.mat', 'MaxH');
load('Results\KDETA_Run_20090720_Free_OFM_.mat', 'tri0')
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
modefit = fit(RP,YR,'exp1');
Return = modefit(MaxRain);


% load('E:\Clinton\IDF_SterlingHeight.mat')
% MaxRain = max(SelectedData);
% modefit = fit(IDF(:,2),IDF(:,1),'exp1');
% Return = modefit(MaxRain);
close all
Name = ["a. \Deltah > 0.5m","b. \Deltah > 1m","c. \Deltah > 1.5m"];
DH = [0.5,1,1.5];
Col = ["k","g","r"];
TT = ["HR-NA","HR-Controlled","HR-Integrated","NR-NA","NR-Controlled","NR-Integrated"];
figure1 = figure('OuterPosition',[300 20 1200 1150]);
for i=1:3
    if i==3
        axes1 = axes('Parent',figure1,...
    'Position',[0.08 0.25 0.26 0.25]);hold on;box on
    else
    axes1 = axes('Parent',figure1,...
    'Position',[0.08+(i-1)*0.33 0.6 0.26 0.25]);hold on;box on
    end
    for j=1:3
        for k=1:size(MaxH,1)
            idx = find(MaxHArea{k,1}(:,j)>DH(i));
            AreaFlood(k,1) = sum(AREA(idx,1))/1000000;
        end
        PlotDat = [Return,AreaFlood];
        PlotDat = sortrows(PlotDat,1);
        plot(PlotDat(:,1),PlotDat(:,2),"Color",Col{j},"LineStyle","-","Marker","o","MarkerFaceColor",Col{j},"MarkerEdgeColor",Col{j},'DisplayName',TT{j});
    end

    for j=1:3
        for k=1:size(MaxH,1)
            idx = find(MaxHArea{k,2}(:,j)>DH(i));
            AreaFlood(k,1) = sum(AREA(idx,1))/1000000;
        end
        PlotDat = [Return,AreaFlood];
        PlotDat = sortrows(PlotDat,1);
        plot(PlotDat(:,1),PlotDat(:,2),"Color",Col{j},"LineStyle","--","Marker","o","MarkerFaceColor",Col{j},"MarkerEdgeColor",Col{j},'DisplayName',TT{j+3});
    end
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top');
    title(Name{i},'FontSize',18,'Color','b');axes1.TitleHorizontalAlignment = 'left';
    if i==1 || i==3
        ylabel('Flooded area [km^2]');
    end
    ylim([0 8])
    xlabel('Return period [year]');
    if i==3
        legend;
    end
end
TTT = [1:1:size(SelectedData,1)]*15;
axes1 = axes('Parent',figure1,...
    'Position',[0.08+0.33 0.25 0.26 0.25]);hold on;box on
for i=1:14
    B = cumsum(SelectedData(:,i));
    plot([0,TTT],[0;B],'LineWidth',1);
end
ylabel('Cumulative rainfall [mm]');
xlabel('Time [min]');xlim([0 max(TTT)]);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top');
title('d. Rainfall distribution','FontSize',18,'Color','b');axes1.TitleHorizontalAlignment = 'left';

% exportgraphics(figure1,"Figs/F3.jpeg",'Resolution',600)
end