function plot_SM1()
%%
close all
k=0;
for i=1:3
     POSS(i,:) = [0.02+(i-1)*0.32 0.2 0.3 0.6];
end
figure1 = figure('OuterPosition',[300 20 1200 800]);

% plot (a) Study area
axes1 = axes('Parent',figure1,...
    'Position',POSS(1,:));hold on;box on
RedRun = shaperead("Map/Domain2.shp");
RR = mapshow(RedRun,'FaceColor',[1 1 1],'DisplayName','Red Run','LineWidth',1);
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[0.9 0.9  0.9],'DisplayName','Warren','LineWidth',1,'LineStyle','--');
River = shaperead("Map/MainOpenChannel.shp");
mapshow(River,'LineWidth',1,'Color','b','DisplayName','River');
Culvert = shaperead("Map/Culvert.shp");
mapshow(Culvert,'LineWidth',1,'Color','c','DisplayName','Culvert');
Pipe = shaperead("Map/RedRun_pipe.shp");
mapshow(Pipe,'LineWidth',1,'Color','r','DisplayName','Pipe');
Manhole = shaperead("Map/RedRun_Selected_manhole.shp");
MH = mapshow(Manhole,'Marker','o','MarkerSize',3,'MarkerEdgeColor','g','MarkerFaceColor','r','LineWidth',0.5);

xlim([3.195*10^5 3.39*10^5]);ylim([4.7 4.72]*10^6)
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
% title('a','FontSize',18);axes1.TitleHorizontalAlignment = 'left';


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

Manhole = shaperead("Map/RedRun_Selected_manhole.shp");
MH = mapshow(Manhole,'Marker','o','MarkerSize',6,'MarkerEdgeColor','g','MarkerFaceColor','r');
IDout = ["OO1","OO3"];
load('E:\Clinton\RedRun_structure\Results\KDETB_Run_20210827_Int_SFM_.mat', 'ToTalLatLong','Allmanholesim');
CO = ["g","r"];
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    OF = plot(ToTalLatLong{idx}(1),ToTalLatLong{idx}(2),'Marker','square','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor',CO{i});
end
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
% title('b','FontSize',18);axes1.TitleHorizontalAlignment = 'left';



axes1 = axes('Parent',figure1,...
    'Position',[0.7 0.5 0.1 0.1]);hold on;box on
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


l6 = plot([1 2],'LineWidth',2,'Color','b','DisplayName','River/Open channel');
l7 = plot([1 2],'LineWidth',2,'Color',[0.3010 0.7450 0.9330],'DisplayName','Culvert');
l8 = plot([1 2],'LineWidth',2,'Color','r','DisplayName','Pipe');
l11 = plot(1,1,'LineStyle','none','Marker','o','MarkerEdgeColor','g','MarkerFaceColor','r','DisplayName','Manhole','MarkerSize',10);
l12 = plot(1,1,'LineStyle','none','Marker','square','MarkerEdgeColor','k','MarkerFaceColor','g','DisplayName','Outfall #1','MarkerSize',20);
l13 = plot(1,1,'LineStyle','none','Marker','square','MarkerEdgeColor','k','MarkerFaceColor','r','DisplayName','Outfall #2','MarkerSize',20);

legend([l1, l2, l3,l6,l7,l8,l11,l12,l13],...
    'Position',[0.65653153576024 0.399169990703234 0.203265761537058 0.370422439743134]);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[1 1 1],'YColor',[1 1 1]);
    

%     Name = ['Figs/F1.pdf'];
%     exportgraphics(figure1, Name, 'ContentType', 'vector');
% exportgraphics(figure1,"Figs/F1.jpeg",'Resolution',600);
end

