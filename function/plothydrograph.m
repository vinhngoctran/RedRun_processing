function plothydrograph(InvertEle,Qinoutfall,Houtfall,Q2outfall)

% close all
figure1 = figure('OuterPosition',[300 50 1100 800]);
xsize = min([size(Qinoutfall,1) size(Houtfall,1) size(Q2outfall,1)]);
TIT = ["(a) Outfall 1","(b) Outfall 2";"(c) Outfall 1","(d) Outfall 2"];
for i=1:2
    axes1 = axes('Parent',figure1,...
        'Position',[0.1+(i-1)*0.45 0.6 0.35 0.32]);hold on;box on
    if size(Houtfall,3)==3
        plot([0:1:xsize-1],Houtfall(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName','eta_{No Infrastructure}');
        plot([0:1:xsize-1],Houtfall(1:xsize,i,2),'LineWidth',2,'Color','b','DisplayName','eta_{Free}');
        plot([0:1:xsize-1],Houtfall(1:xsize,i,3),'LineWidth',2,'Color','r','DisplayName','eta_{Integrated}');
    else
        plot([0:1:xsize-1],Houtfall(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName','eta_{Free}');
        plot([0:1:xsize-1],Houtfall(1:xsize,i,2),'LineWidth',2,'Color','b','DisplayName','eta_{Integrated}');
    end
    IV(1:xsize) = InvertEle(i);
    plot([0:1:xsize-1],IV,'LineWidth',2,'Color',[0.5 0.5 0.5],'LineStyle','--','DisplayName','Invert elevation')
    set(axes1,'Linewidth',1,'FontSize',13,'TickDir','out','TickLength',[0.02 0.02]);if i==1;legend('Location','Northwest');ylabel('Elevation [m]');end
    title(TIT{1,i},'FontSize',18,'Color','b','VerticalAlignment','bottom');axes1.TitleHorizontalAlignment = 'left';


    axes1 = axes('Parent',figure1,...
        'Position',[0.1+(i-1)*0.45 0.16 0.35 0.32]);hold on;box on
    plot([0:1:xsize-1],Q2outfall(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName','Qout_{Free}');
    plot([0:1:xsize-1],Qinoutfall(1:xsize,i,1),'LineWidth',2,'Color','k','DisplayName','Qin_{Free}','LineStyle','--');

    plot([0:1:xsize-1],Q2outfall(1:xsize,i,2),'LineWidth',2,'Color','b','DisplayName','Qout_{Integrated}');
    plot([0:1:xsize-1],Qinoutfall(1:xsize,i,2),'LineWidth',2,'Color','b','DisplayName','Qin_{Integrated}','LineStyle','--');
    
    set(axes1,'Linewidth',1,'FontSize',13,'TickDir','out','TickLength',[0.02 0.02]);if i==1;legend('Location','Northwest');ylabel('Discharge [m^3/2]');end
    title(TIT{2,i},'FontSize',18,'Color','b','VerticalAlignment','bottom');axes1.TitleHorizontalAlignment = 'left';
end



end