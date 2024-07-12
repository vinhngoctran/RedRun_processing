function plotinundation(MaxH,node0,tri0)

TIT = ["(a) No Infrastructure","(a) Controlled","(b) Integrated","(c) \Deltah"];
BuildingInfo = shaperead("F:\OneDrive - hus.edu.vn\MODEL\tRIBS\2022_tRIBS\2.CaseStudy\RedRun\SelectedArea_2_building_simplified.shp");
RedRun_Small = shaperead('F:\OneDrive - hus.edu.vn\MODEL\tRIBS\2022_tRIBS\2.CaseStudy\RedRun\SelectedArea_2.shp');%
figure1 = figure('OuterPosition',[300 50 1300 800]);
filename = ["tRIBS_FREE_15.mat","tRIBS_BC_15.mat"];
MaxH(MaxH<1e-3) = NaN;
for i=1:3
    axes1 = axes('Parent',figure1,...
        'Position',[0.05+(i-1)*0.32 0.2 0.28 0.6]);hold on;box on
    
    X = [node0.coordX];     Y = [node0.coordY];     v = [X(:), Y(:)];	clearvars X Y;
    f = [tri0.vertices];    f = reshape(f, 3,[]);   f = (f + 1)';
    patch(axes1, 'Faces',f, 'Vertices',v, 'FaceVertexCData',MaxH(:,i), ...
        'FaceColor','flat', 'EdgeColor','None'); % 'None', 'Black'

    %     colormap(ax1, 'winter')
    set(axes1,'CLim',[0 5],'Colormap',...
        redwhiteblue(-5,5,2));
%     cb1 = colorbar(axes1, 'Position',[.05 .11 .0675 .815]);
%     cb1.Label.String = 'Water Depth (m)';
    colorbar;
    l0 = mapshow(RedRun_Small,'FaceColor','none','EdgeColor',[0.5 0.5 0.5],'LineWidth',1,'LineStyle','--','DisplayName','Study area');
    mapshow(BuildingInfo, 'FaceColor', [1 1 1])
   axis([min([RedRun_Small.X])-300 max([RedRun_Small.X])+300 min([RedRun_Small.Y])-300 max([RedRun_Small.Y])+300])      % ZOOM INTO MAINSTREAM
   if i==1 
   set(axes1,'Layer','top','Linewidth',1,'FontSize',11,'TickDir','out','TickLength',[0.01 0.01])
   else
       set(axes1,'Layer','top','Linewidth',1,'FontSize',11,'TickDir','out','TickLength',[0.01 0.01],'YTickLabel',[""])
   end
    title(TIT{i},'FontSize',14,'Color','b','VerticalAlignment','bottom');axes1.TitleHorizontalAlignment = 'right';
end
end