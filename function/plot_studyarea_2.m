function plot_studyarea_2()
%%
close all
k=0;
for i=1:3
    for j=1:4
        k=k+1;
        if i==1
            POSS(k,:) = [0.02+(j-1)*0.26 0.7-(i-1)*0.32 0.23 0.27];
        else
            POSS(k,:) = [0.02+(j-1)*0.24 0.7-(i-1)*0.32 0.2 0.27];
        end
    end
end
figure1 = figure('OuterPosition',[300 20 1200 1150]);

% plot (a) Study area
axes1 = axes('Parent',figure1,...
    'Position',POSS(1,:));hold on;box on
RedRun = shaperead("Map/Domain2.shp");
RR = mapshow(RedRun,'FaceColor',[1 1 1],'DisplayName','Red Run','LineWidth',1);
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[0.9 0.9  0.9],'DisplayName','Warren','LineWidth',1);
River = shaperead("Map/MainOpenChannel.shp");
mapshow(River,'LineWidth',1,'Color','b','DisplayName','River');
Culvert = shaperead("Map/Culvert.shp");
mapshow(Culvert,'LineWidth',1,'Color','c','DisplayName','Culvert');
Pipe = shaperead("Map/RedRun_pipe.shp");
mapshow(Pipe,'LineWidth',1,'Color','r','DisplayName','Pipe');
InOut = shaperead("Map/InOutLets.shp");
Outlet = mapshow(InOut(1),'Marker','o','MarkerSize',10,'MarkerEdgeColor','g','MarkerFaceColor','g');
Inlet = mapshow(InOut(2),'Marker','o','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor','r');
xlim([3.19*10^5 3.424*10^5]);ylim([4.7 4.723]*10^6)
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
title('a','FontSize',18);axes1.TitleHorizontalAlignment = 'left';
axes1 = axes('Parent',figure1,...
    'Position',[0.13 0.87 0.121621621621622 0.122421948912015]);hold on;box on
ax = usamap({'MI'});
set(ax,'Visible','off')
states = readgeotable('usastatehi.shp'); 
geoshow(states, 'FaceColor', [1 1 1]);mlabel off; plabel off; gridm off

RedRun = readgeotable("Map/InOutLets.shp");
% try; 
geoshow(42.535,-83.056,'Marker','o','MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','b');
latlim = getm(ax,'MapLatLimit');
lonlim = getm(ax,'MapLonLimit');
lat = states.LabelLat;
lon = states.LabelLon;
tf = ingeoquad(lat,lon,latlim,lonlim);
textm(lat(22)-1,lon(22),"MI",'Fontsize',13,'HorizontalAlignment','left')


% plot (b) Specific area
axes1 = axes('Parent',figure1,...
    'Position',POSS(2,:));hold on;box on
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
Year100 = shaperead("Map/100YearFloodZone.shp");
Year500 = shaperead("Map/500YearFZ.shp");
mapshow(Year500,'LineWidth',0.5,'FaceColor',[0.8500 0.3250 0.0980],'DisplayName','0.2% Annual Chance Flood Hazard','FaceAlpha',0.5);
mapshow(Year100,'LineWidth',0.5,'FaceColor','b','DisplayName','1% Annual Chance Flood Hazard','FaceAlpha',0.5);

Manhole = shaperead("Map/RedRun_Selected_manhole.shp");
MH = mapshow(Manhole,'Marker','o','MarkerSize',3,'MarkerEdgeColor','g','MarkerFaceColor','r');
IDout = ["OO1","OO3"];
load('E:\Clinton\RedRun_structure\Results\KDETB_Run_20210827_Int_SFM_.mat', 'ToTalLatLong','Allmanholesim');
CO = ["g","r"];
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    OF = plot(ToTalLatLong{idx}(1),ToTalLatLong{idx}(2),'Marker','square','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',CO{i});
end
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
title('b','FontSize',18);axes1.TitleHorizontalAlignment = 'left';

% Plot (c) two outfalls
axes1 = axes('Parent',figure1,...
    'Position',POSS(3,:));hold on;box on
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
title('c','FontSize',18);axes1.TitleHorizontalAlignment = 'left';
CO = ["g","r"];
PPP = [0.52 0.85 0.16 0.12
    0.52 0.7 0.16 0.12];
for i=1:2
    axes1 = axes('Parent',figure1,...
        'Position',PPP(i,:));hold on;box on
        imageO = imread(['Map/O',num2str(i),'.JPG']);
        imshow(imageO);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
    title(['Outfall #',num2str(i)],'FontSize',14,'VerticalAlignment','baseline','Color',CO{i});axes1.TitleHorizontalAlignment = 'right';
end


axes1 = axes('Parent',figure1,...
    'Position',[0.70 0.77 0.13 0.18]);hold on;box on
y1=[1 1];                      %#create first curve
y2=[2 2];                   %#create second curve
x = 1:numel(y1);
XData1=[x,fliplr(x)];                %#create continuous x value array for plotting
YData1=[y1,fliplr(y2)]; 
l1 = patch('Parent',axes1,'DisplayName','Red Run watershed',...
    'YData',YData1,...
    'XData',XData1,...
    'FaceColor',[1 1 1],...
    'EdgeColor',[0 0 0],'Linewidth',1.5);
l2 = patch('Parent',axes1,'DisplayName','Warren area',...
    'YData',YData1,...
    'XData',XData1,...
    'FaceColor',[1 1 1],...
    'EdgeColor',[0 0 0],'Linewidth',1.5,'Linestyle','--');
l3 = patch('Parent',axes1,'DisplayName','Building footprint',...
    'YData',YData1,...
    'XData',XData1,...
    'FaceColor',[0.5 0.5 0.5],...
    'EdgeColor',[0 0 0],'Linewidth',1.5);
l4 = patch('Parent',axes1,'DisplayName','1% Annual chance flood',...
    'YData',YData1,...
    'XData',XData1,...
    'FaceColor',[0.388235294117647 0.113725490196078 0.941176470588235],...
    'EdgeColor',[0 0 0],'Linewidth',1.5);
l5 = patch('Parent',axes1,'DisplayName','0.2% Annual chance flood',...
    'YData',YData1,...
    'XData',XData1,...
    'FaceColor',[0.941176470588235 0.631372549019608 0.498039215686275],...
    'EdgeColor',[0 0 0],'Linewidth',1.5);
l6 = plot([1 2],'LineWidth',2,'Color','b','DisplayName','River/Open channel');
l7 = plot([1 2],'LineWidth',2,'Color',[0.3010 0.7450 0.9330],'DisplayName','Culvert');
l8 = plot([1 2],'LineWidth',2,'Color','r','DisplayName','Pipe');
l9 = plot(1,1,'LineStyle','none','Marker','o','MarkerEdgeColor','none','MarkerFaceColor','r','DisplayName','Inlet','MarkerSize',15);
l10 = plot(1,1,'LineStyle','none','Marker','o','MarkerEdgeColor','none','MarkerFaceColor','g','DisplayName','Outlet','MarkerSize',15);
l11 = plot(1,1,'LineStyle','none','Marker','o','MarkerEdgeColor','g','MarkerFaceColor','r','DisplayName','Manhole','MarkerSize',10);
l12 = plot(1,1,'LineStyle','none','Marker','square','MarkerEdgeColor','k','MarkerFaceColor','g','DisplayName','Outfall #1','MarkerSize',20);
l13 = plot(1,1,'LineStyle','none','Marker','square','MarkerEdgeColor','k','MarkerFaceColor','r','DisplayName','Outfall #2','MarkerSize',20);

legend([l1, l2, l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13],...
    'Position',[0.686936941165645 0.698202459791864 0.203265761537058 0.271838536739199]);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
    

% Plot Maximum Inundation depth
TT = ["d. HR-NA","e. HR-Controlled","f. HR-Integrated";"h. NR-NA","i. NR-Controlled","j. NR-Integrated"];
TT2 = ["d. HR-Integrated","e. NR-Integrated","f. HR-Controlled"];
load Results\Hmax.mat;
load('Results\KDETA_Run_20090720_Free_OFM_.mat','node0','tri0');
Event = 5;
load('Selected_KDET.mat');
Structture = ["KDETA_Run_","KDETB_Run_"];
Scenario = ["None","Free","Int"];
EventName = datestr(SelectedDate(1,Event),'yyyymmdd');
for i=1:3  
    axes1 = axes('Parent',figure1,...
    'Position',POSS(4+i,:));hold on;box on
    if i==1
        plotinundation_single(MaxH{Event,1}(:,3),node0,tri0,axes1,POSS(4+i,:));
        Savename = ['Results/',Structture{1},EventName,'_',Scenario{3},'_SFM_.mat'];
    elseif i==2
        plotinundation_single(MaxH{Event,2}(:,3),node0,tri0,axes1,POSS(4+i,:));
        Savename = ['Results/',Structture{2},EventName,'_',Scenario{3},'_SFM_.mat'];
    else
        plotinundation_single(MaxH{Event,1}(:,2),node0,tri0,axes1,POSS(4+i,:));
        Savename = ['Results/',Structture{1},EventName,'_',Scenario{2},'_SFM_.mat'];
    end 
        
        load(Savename);
        plotsurcharge(axes1,ToTalData15m,ToTalLatLong,Allmanholesim);
        xlim([3.315*10^5 3.347*10^5]);ylim([4.7062 4.7101]*10^6);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
    title(TT2{1,i},'FontSize',18);axes1.TitleHorizontalAlignment = 'left';
end

% for i=1:3
%     axes1 = axes('Parent',figure1,...
%     'Position',POSS(8+i,:));hold on;box on
%     plotinundation_single(MaxH{Event,2}(:,i),node0,tri0,axes1,POSS(8+i,:));
%     if i>1
%         Savename = ['Results/',Structture{2},EventName,'_',Scenario{i},'_SFM_.mat'];
%         load(Savename);
%         plotsurcharge(axes1,ToTalData15m,ToTalLatLong,Allmanholesim);
%     end
%     set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
%     title(TT{2,i},'FontSize',18);axes1.TitleHorizontalAlignment = 'left';
% end

% Plot inundation different
TT2 = ["g. \Deltah (d-f)","k. \Deltah (i-j)"];
for i=1:1
    if i==1
        SubP = POSS(8,:);
    else
        SubP = POSS(12,:);
    end
    axes1 = axes('Parent',figure1,...
    'Position',SubP);hold on;box on
    plotinundation_different(MaxH{Event,i}(:,3)-MaxH{Event,i}(:,2),node0,tri0,axes1,SubP);
    xlim([3.3125*10^5 3.3475*10^5]);ylim([4.7062 4.7101]*10^6);
    xlim([3.315*10^5 3.347*10^5]);ylim([4.7062 4.7101]*10^6);
    set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
    title(TT2{i},'FontSize',18);axes1.TitleHorizontalAlignment = 'left';
end
    Name = ['Figs/F1.pdf'];
%     exportgraphics(figure1, Name, 'ContentType', 'vector');
% exportgraphics(figure1,"Figs/F1.jpeg",'Resolution',600);
end

