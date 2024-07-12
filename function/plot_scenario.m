function plot_scenario()
%%
close all
load('Results/Scen_Storage_OFM.mat','node0','tri0','MaxH');
load('Results/Scen_Storage_SFM.mat');
ConnectStorage = readtable('RedRun_Storage/Input/Sewer/ConnectStorage.txt');

k=0;
for i=1:3
    for j=1:4
        k=k+1;
        if i==1
            POSS(k,:) = [(j-1)*0.26 0.5-(i-1)*0.32 0.25 0.5];
        else
            POSS(k,:) = [(j-1)*0.24 0.7-(i-1)*0.32 0.25 0.5];
        end
    end
end
figure1 = figure('OuterPosition',[300 20 1200 1150]);
% Plot flooded area
axes1 = axes('Parent',figure1,...
    'Position',POSS(2,:));hold on;box on
load('Results/Scen_Storage_OFM.mat','node0','tri0','MaxH');
load('Results/Scen_Storage_SFM.mat');
plotinundation_single2(MaxH,node0,tri0,axes1,POSS(2,:));
plotsurcharge(axes1,ToTalData15m,ToTalLatLong,Allmanholesim);
xlim([3.315*10^5 3.347*10^5]);ylim([4.7062 4.7101]*10^6);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
title('a','FontSize',14);axes1.TitleHorizontalAlignment = 'left';

%
Event = 5;
load('Results/Scen_Storage_OFM.mat','MaxH');
MaxH_scen = MaxH;
load Results\Hmax.mat;
axes1 = axes('Parent',figure1,...
    'Position',[0.57 0.5 0.25 0.35]);hold on;
 plotinundation_different2(MaxH_scen-MaxH{Event,1}(:,3),node0,tri0,axes1,[0.57 0.5 0.25 0.35]);
    xlim([3.3125*10^5 3.3475*10^5]);ylim([4.7062 4.7101]*10^6);
    xlim([3.315*10^5 3.347*10^5]);ylim([4.7062 4.7101]*10^6);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
    title('b','FontSize',14);axes1.TitleHorizontalAlignment = 'left';

%
%%
load('Selected_KDET.mat', 'SelectedDate');
axes1 = axes('Parent',figure1,...
    'Position',[0.3 0.3 0.52 0.17]);hold on;
for i=1:3
    plot(SelectedDate(:,Event),ToTalData15m{end-3+i}.Data3,"LineWidth",1.5,'DisplayName',['S #',num2str(i)]);

end
legend('Location','northwest');
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top');
ylabel('Discharge [m^3/s]');ylim([0 45])
title('c','FontSize',14);axes1.TitleHorizontalAlignment = 'left';

%
YY = [4.708 4.7086;4.7081 4.709;4.7062 4.708]*10^6;
XX = [3.325 3.331;3.333 3.342;3.326 3.338]*10^5;
for i=1:3
    axes1 = axes('Parent',figure1,...
    'Position',[0.06 0.7-(i-1)*0.17 0.18 0.15]);hold on;box on
    BuildingInfo = shaperead("F:\OneDrive - hus.edu.vn\MODEL\tRIBS\2022_tRIBS\2.CaseStudy\RedRun\SelectedArea_2_building_simplified.shp");
    mapshow(BuildingInfo, 'FaceColor', [0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5])
    Pipe = shaperead("Map/RedRun_pipe.shp");
    mapshow(Pipe,'LineWidth',1,'Color','r','DisplayName','Pipe');
    plotlinking(ConnectStorage,Allmanholesim,ToTalLatLong);
    Manhole = shaperead("Map/RedRun_Selected_manhole.shp");
    MH = mapshow(Manhole,'Marker','o','MarkerSize',5,'MarkerEdgeColor','g','MarkerFaceColor','r');

    for j=1:size(ToTalData15m,2)
        if contains(Allmanholesim{j},['S',num2str(i)])
            l8 = scatter(ToTalLatLong{1,j}(1), ToTalLatLong{1,j}(2), 'square',...
                'MarkerEdgeColor','g',...
                'MarkerFaceColor','g','SizeData',100,'DisplayName','Surcharged manhole');
            text(ToTalLatLong{1,j}(1), ToTalLatLong{1,j}(2),['  S #',num2str(i)],'Color','k','FontSize',14)
        end
    end
    
    xlim([XX(i,:)]);ylim([YY(i,:)]);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
end
%
% load('Results\Scen_Hmax_AreaTime.mat','MaxH',"TimeMax",'AreaTimeMax0205');
% load('Results\Scen_H_outfall.mat','Houtfall2','EtaOutfall');
% load('Selected_KDET.mat');
% for i=1:size(tri0,2)
%     CentXY(i,:) = [tri0(i).centX,tri0(i).centY,tri0(i).area];
% end
% Warren = shaperead("Map/SelectedArea_2.shp");
% 
% XX = Warren.X(1:end)';
% YY = Warren.Y(1:end)';
% [in,on] = inpolygon(CentXY(:,1),CentXY(:,2),XX,YY);
% AREA = CentXY(in,3);
% 
% axes1 = axes('Parent',figure1,...
%     'Position',[0.6 0.5 0.38 0.174]);hold on;
% Event = 5;
% for i=1:6
%     AF(1,1) = sum(AREA)/1000000;
%     AF(2:97,i) = AreaTimeMax0205(:,i);
% end
% area(SelectedDate(:,Event),AF,'FaceAlpha',0.5)
% legend(["h≤0.1","0.1<h≤0.5","0.5<h≤1","1<h≤1.5","1.5<h≤2","2<h"],'Location','southwest')
% % bar(SelectedDate(:,Event),T_FloodArea);
% % end
% ylabel('Flooded area [km^2]');
% xlim([SelectedDate(1,Event) SelectedDate(end,Event)]);
% ylim([0 AF(1,1)]);
% set(axes1,'FontSize',12,'Layer','top','TickDir','out',...
%     'TickLength',[0.0065 0.00655],'Color','None');
% 
% title('b','FontSize',14);axes1.TitleHorizontalAlignment = 'left'


    Name = ['Figs/F_scen.pdf'];
%     exportgraphics(figure1, Name, 'ContentType', 'vector');
% exportgraphics(figure1,"Figs/F_Scen.jpeg",'Resolution',600);
end

