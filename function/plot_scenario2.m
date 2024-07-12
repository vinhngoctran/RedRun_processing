
close all
for i=1:3
    if i==1
        POSS(i,:) = [0.05+(i-1)*0.28 0.355 0.25 0.395];
    else
        POSS(i,:) = [0.05+(i-1)*0.28 0.3 0.25 0.45];
    end
end
figure1 = figure('OuterPosition',[300 20 1200 1150]);
% Plot flooded area
axes1 = axes('Parent',figure1,...
    'Position',POSS(1,:));hold on;box on
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[1 1 1],'LineStyle','--','DisplayName','Warren','LineWidth',1);
River = shaperead("Map/MainOpenChannel.shp");
mapshow(River,'LineWidth',2,'Color',[0 0.4470 0.7410],'DisplayName','River');
Culvert = shaperead("Map/Culvert.shp");
mapshow(Culvert,'LineWidth',2,'Color','b','DisplayName','Culvert');
Building = shaperead("Map/SelectedArea_2_building_simplified.shp");
mapshow(Building,'LineWidth',0.5,'FaceColor',[0.3 0.3 0.3],'EdgeColor',[0.3 0.3 0.3],'DisplayName','Building','FaceAlpha',0.3);
Pipe = shaperead("Map/RedRun_pipe.shp");
mapshow(Pipe,'LineWidth',2,'Color',[0.4660 0.6740 0.1880],'DisplayName','Pipe');
Manhole = shaperead("Map/RedRun_Selected_manhole.shp");
MH = mapshow(Manhole,'Marker','o','MarkerSize',5,'MarkerEdgeColor','k','MarkerFaceColor',[0.6350 0.0780 0.1840]);
IDout = ["OO1","OO3"];
load('E:\Clinton\RedRun_structure\Results\KDETB_Run_20210827_Int_SFM_.mat', 'ToTalLatLong','Allmanholesim');
CO = ["#77AC30","#D95319"];
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    OF = plot(ToTalLatLong{idx}(1),ToTalLatLong{idx}(2),'Marker','square','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',CO{i});
end
load('Results/Scen_Storage_SFM.mat');
% ConnectStorage = readtable('RedRun_Storage/Input/Sewer/ConnectStorage.txt');
% plotlinking2(ConnectStorage,Allmanholesim,ToTalLatLong);
plotstorage(axes1,ToTalData15m,ToTalLatLong,Allmanholesim);

xlim([3.317*10^5 3.344*10^5]);ylim([4.7063 4.7101]*10^6);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[]);

title('a','FontSize',14);axes1.TitleHorizontalAlignment = 'left';
annotation(figure1,'rectangle',...
    [0.129222972972974 0.532639545884579 0.058277027027027 0.0652790917691581],...
    'FaceColor',[0 0.447058823529412 0.741176470588235],...
    'FaceAlpha',0.2);

annotation(figure1,'rectangle',...
    [0.197635135135137 0.54399243140965 0.0827702702702689 0.0785241248817409],...
    'FaceColor',[0 0.447058823529412 0.741176470588235],...
    'FaceAlpha',0.2);

annotation(figure1,'rectangle',...
    [0.133445945945947 0.3569394512772 0.0886824324324309 0.0520340586565752],...
    'FaceColor',[0 0.447058823529412 0.741176470588235],...
    'FaceAlpha',0.2);


axes1 = axes('Parent',figure1,...
    'Position',POSS(2,:));hold on;box on
load('Results/Scen_Storage_OFM.mat','node0','tri0','MaxH');
plotinundation_single2(MaxH,node0,tri0,axes1,POSS(2,:));
plotsurcharge2(axes1,ToTalData15m,ToTalLatLong,Allmanholesim);
xlim([3.317*10^5 3.344*10^5]);ylim([4.7063 4.7101]*10^6);

set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[]);
title('b','FontSize',14);axes1.TitleHorizontalAlignment = 'left';


Event = 5;
load('Results/Scen_Storage_OFM.mat','MaxH');
MaxH_scen = MaxH;
load Results\Hmax.mat;
axes1 = axes('Parent',figure1,...
    'Position',POSS(3,:));hold on;box on
plotinundation_different2(MaxH_scen-MaxH{Event,1}(:,3),node0,tri0,axes1,[0.57 0.5 0.25 0.35]);
xlim([3.317*10^5 3.344*10^5]);ylim([4.7063 4.7101]*10^6);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[]);
title('c','FontSize',14);axes1.TitleHorizontalAlignment = 'left';
Name = ['Figs/F_scen.pdf'];
exportgraphics(figure1, Name, 'ContentType', 'vector');
exportgraphics(figure1,"Figs/F_Scen.jpeg",'Resolution',600);