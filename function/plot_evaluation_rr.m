function plot_evaluation_rr()
%%
load('Selected_KDET.mat');
load('Results/Validation.mat','Inundation_eval','ObsDepth_R')
close all;
GT = readgeotable("Map/Domain_RedRun.shp");
CC = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E","#77AC30","#4DBEEE"];
figure1 = figure('OuterPosition',[300 20 1200 800]);
axes1 = geoaxes('Parent',figure1,...
    'Position',[0.1 0.15 0.3 0.6]);hold on;
geoplot(GT);
geobasemap streets

OBS = readgeotable("Map/Obs.shp");
for i=1:size(OBS,1)
    ll{i}=geoplot(OBS(i,:),'Marker','o','MarkerSize',10,'MarkerFaceColor',CC(i),'MarkerEdgeColor',CC(i),'DisplayName',['Location ',num2str(i)]);
end
legend1 = legend([ll{1} ll{2} ll{3}  ll{4} ll{5} ll{6}]);
k=0;
for i=1:2
    for j=1:3
        k=k+1;
        POSS(k,:) = [0.45+(j-1)*0.18 0.49-(i-1)*0.34 0.15 0.26];
    end
end
for i=1:6
    axes1 = axes('Parent',figure1,...
    'Position',POSS(i,:));hold on;
    plot(SelectedDate(2:end,5),Inundation_eval(:,i),"Color",'r','LineWidth',1,'DisplayName','Simulation');
    ciplot([ObsDepth_R(i,3) ObsDepth_R(i,3)]*0.8,[ObsDepth_R(i,3) ObsDepth_R(i,3)]*1.2,[SelectedDate(2,5), SelectedDate(end,5)],[0.3 0.3 0.3]);
%     plot([SelectedDate(2,5), SelectedDate(end,5)],[ObsDepth_R(i,3) ObsDepth_R(i,3)],"Color",[0 0 0 0.5],'LineWidth',20,'DisplayName','Flood mark');
    ylim([0 1.5])
    set(axes1,'FontSize',10,'TickDir','out','TickLength',[0.01 0.01],'layer','top','LineWidth',1.5);
    title(['Location ',num2str(i)],'FontSize',14);axes1.TitleHorizontalAlignment = 'left';
    if i==3
        legend(["Simulation","Flood mark"])
    end
    if i==1||i==4
        ylabel('Inundation depth [m]')
    end
end
% exportgraphics(figure1,"Figs/FM5.jpeg",'Resolution',600)
end