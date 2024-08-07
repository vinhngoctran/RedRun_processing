function plot_waterlevel_3()
%%
close all;
Surcharge = [333359.845 4709511.603
    334084.340 4709216.024
    333648.028 4708693.123
    333108.751 4706407.909
    332698.135 4708348.030];
k = 0;
for i=1:2
    for j=1:2
        k=k+1;
        POSS(k,:) = [0.352+(j-1)*0.23 0.8-(i-1)*0.185 0.19 0.14];
    end
end
figure1 = figure('OuterPosition',[300 20 1200 1150]);
axes1 = axes('Parent',figure1,...
    'Position',[0.02 0.2 0.27 0.35]);hold on;box on
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[1 1 1],'LineStyle','--','DisplayName','Warren','LineWidth',1);
River = shaperead("Map/MainOpenChannel.shp");
mapshow(River,'LineWidth',1.5,'Color',[0 0.4470 0.7410],'DisplayName','River');
xlim([3.3125*10^5 3.3475*10^5]);ylim([4.7062 4.7101]*10^6);

Building = shaperead("Map/SelectedArea_2_building_simplified.shp");
mapshow(Building,'LineWidth',0.5,'FaceColor',[0.7 0.7 0.7],'DisplayName','Building');
Pipe = shaperead("Map/RedRun_pipe.shp");
mapshow(Pipe,'LineWidth',1,'Color',[0.4660 0.6740 0.1880],'DisplayName','Pipe');
Culvert = shaperead("Map/Culvert.shp");
mapshow(Culvert,'LineWidth',1.5,'Color','b','DisplayName','Culvert');
% Manhole = shaperead("Map/RedRun_Selected_manhole.shp");
% MH = mapshow(Manhole,'Marker','o','MarkerSize',3,'MarkerEdgeColor','g','MarkerFaceColor','r');
ManholeC = ["#0072BD","#EDB120","#7E2F8E","#D95319","#77AC30"];
for i=1:size(Surcharge,1)
     MH{i} = plot(Surcharge(i,1),Surcharge(i,2),'Marker','o','MarkerSize',15,'MarkerEdgeColor','k','LineStyle','none','MarkerFaceColor',ManholeC{i},'DisplayName',['Manhole #',num2str(i)]);
end
IDout = ["OO1","OO3"];
load('E:\Clinton\RedRun_structure\Results\KDETB_Run_20210827_Int_SFM_.mat', 'ToTalLatLong','Allmanholesim');
CO = ["#77AC30","#D95319"];
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    OF{i} = plot(ToTalLatLong{idx}(1),ToTalLatLong{idx}(2),'Marker','square','MarkerSize',14,'LineStyle','none','MarkerEdgeColor','k','MarkerFaceColor',CO{i},'DisplayName',['Outfall #',num2str(i)]);
end
legend1 = legend([OF{1},OF{2},MH{1},MH{2},MH{3},MH{4},MH{5}],'Position',[0.02 0.205 0.107263511600527 0.153804928084049]);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
title('a','FontSize',18,'Color','k','VerticalAlignment','top');axes1.TitleHorizontalAlignment = 'left';




% Plot waterlevel at Outfalls
load('Results\Q_OutFall.mat','Qinoutfall','Houtfall','Q2outfall','InvertEle');
load('Results\H_outfall.mat','Houtfall2','EtaOutfall');
load('Selected_KDET.mat', 'SelectedDate');
TT = ["b. Outfall #1","c. Outfall #2"];
CrownE = [3.5, 0.6];
FloodW = [612,613;610,611;609,609;605.5,606]*0.3048;
kk=[8,12];
CO = ["g","r"];
Event = 5;
for i=1:2
    POSS2 = [0.068+(i-1)*0.22 0.6 0.18 0.14];
    axes1 = axes('Parent',figure1,...
    'Position',POSS2);hold on
    plothydrograph_single2(SelectedDate(:,Event),EtaOutfall{Event,1},EtaOutfall{Event,2},InvertEle(i),i,FloodW(:,i),CrownE(i),[0.755276586338164 0.221371629357239 0.184966211987508 0.150898765818398]);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','LineWidth',1);
    ylim([180 188])
    if i==1
    ylabel('Elevation [m]');
    end
    title(TT{i},'FontSize',14,'VerticalAlignment','cap');axes1.TitleHorizontalAlignment = 'left';
end


% Plot inflow and outfal at outfalls
TT = ["d. Outfall #1","e. Outfall #2"];
for i=1:2
    POSS2 = [0.54+(i-1)*0.22 0.6 0.18 0.14];
    axes1 = axes('Parent',figure1,...
    'Position',POSS2);hold on;
    plotdischarge_single2(SelectedDate(:,Event),Q2outfall{Event,1},Qinoutfall{Event,1},Q2outfall{Event,2},Qinoutfall{Event,2},i);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','LineWidth',1);%axes1.XRuler.Axle.Visible = 'off';
    ylim([-100 50])
    if i==1
    ylabel('Discharge [m^3/s]')
    end
    title(TT{i},'FontSize',14,'VerticalAlignment','cap');axes1.TitleHorizontalAlignment = 'left';
end


% Plot surcharge at manhole
load('Results/KDETA_Run_20090720_Free_SFM_.mat');
A2Z = ["f","g","h","i",'j'];
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
k=0;
for i=1:2
    for j=1:3
        k=k+1;
        POSS2(k,:) = [0.345+(j-1)*0.21 0.41-(i-1)*0.19 0.175 0.13];
    end
end
for i=1:5
    
    axes1 = axes('Parent',figure1,...
    'Position',POSS2(i,:));hold on;
    idx = findmanhole(Surcharge(i,:),ToTalLatLong);
    Qout1(:,1) = Data1{idx}.Data1;
    Qout1(:,2) = Data2{idx}.Data1;
    Qin1(:,1) = Data1{idx}.Data3;
    Qin1(:,2) = Data2{idx}.Data3;

%     Qout2(:,1) = Data3{idx}.Data1;
%     Qout2(:,2) = Data4{idx}.Data1;
%     Qin2(:,1) = Data3{idx}.Data3;
%     Qin2(:,2) = Data4{idx}.Data3;

    plotdischarge_single_manhole2(SelectedDate(:,Event),Qout1,Qin1);
    
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','LineWidth',1);
    
    ylim([-5 15])
    if i==1 || i==4
    ylabel('Discharge [m^3/s]')
    end
    title([A2Z{i},'. Manhole #',num2str(i)],'FontSize',14,'VerticalAlignment','cap');axes1.TitleHorizontalAlignment = 'left';
end
annotation(figure1,'textbox',...
    [0.494087837837843 0.183077578671382 0.0544763499795384 0.0302743607798949],...
    'String',{'hour'},...
    'LineStyle','none',...
    'FontSize',14);
annotation(figure1,'textbox',...
    [0.703547297297302 0.183077578671382 0.0544763499795384 0.0302743607798949],...
    'String',{'hour'},...
    'LineStyle','none',...
    'FontSize',14);

% for i=1:12
%     axes1 = axes('Parent',figure1,...
%     'Position',POSS(i,:));hold on;box on
% % end
exportgraphics(figure1, "Figs/F2_main.pdf", 'ContentType', 'vector');
exportgraphics(figure1,"Figs/F2_main.jpeg",'Resolution',600)
end