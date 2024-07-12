function plotinundation_single(MaxH,node0,tri0,axes1,POSS)

BuildingInfo = shaperead("F:\OneDrive - hus.edu.vn\MODEL\tRIBS\2022_tRIBS\2.CaseStudy\RedRun\SelectedArea_2_building_simplified.shp");
RedRun_Small = shaperead('F:\OneDrive - hus.edu.vn\MODEL\tRIBS\2022_tRIBS\2.CaseStudy\RedRun\SelectedArea_2.shp');%
filename = ["tRIBS_FREE_15.mat","tRIBS_BC_15.mat"];
MaxH(MaxH<0.05) = NaN;   
MaxH(MaxH>2) = 2; 
    X = [node0.coordX];     Y = [node0.coordY];     v = [X(:), Y(:)];	clearvars X Y;
    f = [tri0.vertices];    f = reshape(f, 3,[]);   f = (f + 1)';
    patch(axes1, 'Faces',f, 'Vertices',v, 'FaceVertexCData',MaxH, ...
        'FaceColor','flat', 'EdgeColor','None'); % 'None', 'Black'

    %     colormap(ax1, 'winter')
%     set(axes1,'CLim',[0 max(MaxH)],'Colormap',...
%         jet(10));
    set(axes1,'CLim',[0 max(MaxH)],'Colormap',...
        redwhiteblue(0, max(MaxH),1));
%     cb1 = colorbar(axes1, 'Position',[.05 .11 .0675 .815]);
%     cb1.Label.String = 'Water Depth (m)';
%     colorbar;
POSS(1) = POSS(1)+POSS(3)+0.005;
POSS(3) = 0.012;
    colorbar('YTick',linspace(0,max(MaxH),6),'Position',...
    POSS)
    l0 = mapshow(RedRun_Small,'FaceColor','none','EdgeColor',[0 0 0],'LineWidth',1,'LineStyle','--','DisplayName','Study area');
    mapshow(BuildingInfo, 'FaceColor', [0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5])
   axis([min([RedRun_Small.X])-300 max([RedRun_Small.X])+300 min([RedRun_Small.Y])-300 max([RedRun_Small.Y])+300])      % ZOOM INTO MAINSTREAM

end