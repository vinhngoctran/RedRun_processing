function plot_scenario()
%%
close all
load('Results/Scen_Storage_SFM.mat');
ConnectStorage = readtable('RedRun_Storage/Input/Sewer/ConnectStorage.txt');

figure1 = figure('OuterPosition',[300 20 1200 1150]);
load('Selected_KDET.mat', 'SelectedDate');
axes1 = axes('Parent',figure1,...
    'Position',[0.3 0.3 0.52 0.25]);hold on;
for i=1:3
    plot(SelectedDate(:,Event),ToTalData15m{end-3+i}.Data3,"LineWidth",3,'DisplayName',['S',num2str(i)]);
end
legend('Location','northwest','Box','off');
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','Linewidth',1);
ylabel('Discharge [m^3/s]');ylim([0 45])
% title('c','FontSize',14);axes1.TitleHorizontalAlignment = 'left';



    Name = ['Figs/F_scen.pdf'];
%     exportgraphics(figure1, Name, 'ContentType', 'vector');
exportgraphics(figure1,"Figs/SM_Scen_outflow.jpeg",'Resolution',600);
end

