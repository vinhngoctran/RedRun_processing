function plot_SM1()
%%
close all
k=0;
for i=1:3
     POSS(i,:) = [0.02+(i-1)*0.32 0.2 0.3 0.7];
end
figure1 = figure('OuterPosition',[300 20 1200 800]);

axes1 = axes('Parent',figure1,...
    'Position',POSS(1,:));hold on;box on
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[1 1 1],'LineStyle','--','DisplayName','Warren','LineWidth',1);
Building = shaperead("Map/SelectedArea_2_building.shp");
mapshow(Building,'LineWidth',0.5,'FaceColor',[0.5 0.5 0.5],'DisplayName','Building','FaceAlpha',0.5);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
title('a','FontSize',18);axes1.TitleHorizontalAlignment = 'left';
annotation(figure1,'rectangle',...
    [0.0727905405405406 0.516265912305516 0.123155405405405 0.271570014144272],'LineWidth',1);

axes1 = axes('Parent',figure1,...
    'Position',POSS(2,:));hold on;box on
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[1 1 1],'LineStyle','--','DisplayName','Warren','LineWidth',1);
% Building = shaperead("Map/SelectedArea_2_building.shp");
mapshow(Building,'LineWidth',0.5,'FaceColor',[0.5 0.5 0.5],'DisplayName','Building','FaceAlpha',0.5);
xlim([3.32 3.333]*10^5);ylim([4.708 4.7098]*10^6)
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
title('b','FontSize',18);axes1.TitleHorizontalAlignment = 'left';

axes1 = axes('Parent',figure1,...
    'Position',POSS(3,:));hold on;box on
Warren = shaperead("Map/SelectedArea_2.shp");
WR = mapshow(Warren,'FaceColor',[1 1 1],'LineStyle','--','DisplayName','Warren','LineWidth',1);
Building = shaperead("Map/SelectedArea_2_building_simplified.shp");
mapshow(Building,'LineWidth',0.5,'FaceColor',"#0072BD",'DisplayName','Building','FaceAlpha',0.5);
xlim([3.32 3.333]*10^5);ylim([4.708 4.7098]*10^6)
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[],'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5]);
title('c','FontSize',18);axes1.TitleHorizontalAlignment = 'left';



%     Name = ['Figs/F1.pdf'];
%     exportgraphics(figure1, Name, 'ContentType', 'vector');
% exportgraphics(figure1,"Figs/FM3.jpeg",'Resolution',600);
end

