function plot_waterlevel()
%%
close all;
Surcharge = [333359.845 4709511.603
    334084.340 4709216.024
    333648.028 4708693.123
    333108.751 4706407.909
    332698.135 4708348.030];
k = 0;
for i=1:4
    for j=1:3
        k=k+1;
        POSS(k,:) = [0.07+(j-1)*0.32 0.77-(i-1)*0.23 0.26 0.18];
    end
end
figure1 = figure('OuterPosition',[300 20 1200 1150]);
axes1 = axes('Parent',figure1,...
    'Position',[0.06 0.6 0.27 0.35]);hold on;box on
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[1 1 1],'LineStyle','--','DisplayName','Warren','LineWidth',1);
River = shaperead("Map/MainOpenChannel.shp");
mapshow(River,'LineWidth',0.5,'Color','b','DisplayName','River');
xlim([3.3125*10^5 3.3475*10^5]);ylim([4.7062 4.7101]*10^6);
Culvert = shaperead("Map/Culvert.shp");
mapshow(Culvert,'LineWidth',2,'Color','c','DisplayName','Culvert');
Building = shaperead("Map/SelectedArea_2_building_simplified.shp");
mapshow(Building,'LineWidth',0.5,'FaceColor',[0.5 0.5 0.5],'DisplayName','Building');
Pipe = shaperead("Map/RedRun_pipe.shp");
mapshow(Pipe,'LineWidth',1,'Color','r','DisplayName','Pipe');

% Manhole = shaperead("Map/RedRun_Selected_manhole.shp");
% MH = mapshow(Manhole,'Marker','o','MarkerSize',3,'MarkerEdgeColor','g','MarkerFaceColor','r');
ManholeC = ["b","r","g","y","c"];
for i=1:size(Surcharge,1)
     MH{i} = plot(Surcharge(i,1),Surcharge(i,2),'Marker','o','MarkerSize',10,'MarkerEdgeColor','g','LineStyle','none','MarkerFaceColor',ManholeC{i},'DisplayName',['Manhole #',num2str(i)]);
end
IDout = ["OO1","OO3"];
load('E:\Clinton\RedRun_structure\Results\KDETB_Run_20210827_Int_SFM_.mat', 'ToTalLatLong','Allmanholesim');
CO = ["g","r"];
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    OF{i} = plot(ToTalLatLong{idx}(1),ToTalLatLong{idx}(2),'Marker','square','MarkerSize',10,'LineStyle','none','MarkerEdgeColor','k','MarkerFaceColor',CO{i},'DisplayName',['Outfall #',num2str(i)]);
end
legend1 = legend([OF{1},OF{2},MH{1},MH{2},MH{3},MH{4},MH{5}],'Position',[0.0602477496607408 0.604311427112482 0.107263511600527 0.13921694769592]);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
% title('a','FontSize',18,'Color','b');axes1.TitleHorizontalAlignment = 'left';

% Plot waterlevel at Outfalls
load('Results\Q_OutFall.mat','Qinoutfall','Houtfall','Q2outfall','InvertEle');
load('Results\H_outfall.mat','Houtfall2','EtaOutfall');
load('Selected_KDET.mat', 'SelectedDate');
TT = ["a. Outfall #1","b. Outfall #2"];
CrownE = [3.5, 0.6];
FloodW = [612,613;610,611;609,609;605.5,606]*0.3048;
kk=[8,12];
CO = ["g","r"];
Event = 5;
for i=1:2
    axes1 = axes('Parent',figure1,...
    'Position',POSS(i+1,:));hold on;box on
    plothydrograph_single(SelectedDate(:,Event),EtaOutfall{Event,1},EtaOutfall{Event,2},InvertEle(i),i,FloodW(:,i),CrownE(i),[0.138017381607251 0.322651574332791 0.184966211987508 0.248237139143581]);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTickLabel',[]);
    ylabel('Water level [m]')
    title(TT{i},'FontSize',18,'VerticalAlignment','baseline','Color','b');axes1.TitleHorizontalAlignment = 'left';
end

% Plot inflow and outfal at outfalls
TT = ["c. Outfall #1","d. Outfall #2"];
for i=1:2
    axes1 = axes('Parent',figure1,...
    'Position',POSS(4+i,:));hold on;box on
    plotdischarge_single(SelectedDate(:,Event),Q2outfall{Event,1},Qinoutfall{Event,1},Q2outfall{Event,2},Qinoutfall{Event,2},i);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTickLabel',[]);
    ylim([-60 40])
    ylabel('Discharge [m^3/s]')
    title(TT{i},'FontSize',18,'VerticalAlignment','baseline','Color','b');axes1.TitleHorizontalAlignment = 'left';
end

% Plot surcharge at manhole
load('Results/KDETA_Run_20090720_Free_SFM_.mat');
A2Z = ["e","f","g","h","i"];
Event = 5;
load('Selected_KDET.mat');
Structture = ["KDETA_Run_","KDETB_Run_"];
Scenario = ["None","Free","Int"];
EventName = datestr(SelectedDate(1,Event),'yyyymmdd');
load(['Results/',Structture{1},EventName,'_',Scenario{2},'_SFM_.mat']);
Data1 = ToTalData15m;
load(['Results/',Structture{1},EventName,'_',Scenario{3},'_SFM_.mat']);
Data2 = ToTalData15m;
load(['Results/',Structture{2},EventName,'_',Scenario{2},'_SFM_.mat']);
Data3 = ToTalData15m;
load(['Results/',Structture{2},EventName,'_',Scenario{3},'_SFM_.mat']);
Data4 = ToTalData15m;
for i=1:5
    axes1 = axes('Parent',figure1,...
    'Position',POSS(7+i,:));hold on;box on
    idx = findmanhole(Surcharge(i,:),ToTalLatLong);
    Qout1(:,1) = Data1{idx}.Data1;
    Qout1(:,2) = Data2{idx}.Data1;
    Qin1(:,1) = Data1{idx}.Data3;
    Qin1(:,2) = Data2{idx}.Data3;

    Qout2(:,1) = Data3{idx}.Data1;
    Qout2(:,2) = Data4{idx}.Data1;
    Qin2(:,1) = Data3{idx}.Data3;
    Qin2(:,2) = Data4{idx}.Data3;

    plotdischarge_single_manhole(SelectedDate(:,Event),Qout1,Qin1,Qout2,Qin2);
    if i>2
        set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top');
    else
        set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTickLabel',[]);
    end
    ylim([-5 15])
    ylabel('Discharge [m^3/s]')
    title([A2Z{i},'. Manhole #',num2str(i)],'FontSize',18,'VerticalAlignment','baseline','Color','b');axes1.TitleHorizontalAlignment = 'left';
end
% for i=1:12
%     axes1 = axes('Parent',figure1,...
%     'Position',POSS(i,:));hold on;box on
% end
exportgraphics(figure1,"Figs/F2.jpeg",'Resolution',600)
end