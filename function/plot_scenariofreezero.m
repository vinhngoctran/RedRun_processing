
close all
for i=1:3
    if i==1
        POSS(i,:) = [0.05+(i-1)*0.28 0.355 0.25 0.395];
    else
        POSS(i,:) = [0.05+(i-1)*0.28 0.3 0.25 0.45];
    end
end
figure1 = figure('OuterPosition',[300 20 1200 1150]);
load('E:\Clinton\RedRun_structure\Results\KDETB_Run_20210827_Int_SFM_.mat', 'ToTalLatLong','Allmanholesim');
load('Results/KDET0_Run_20140811_FreeZero_SFM.mat');
axes1 = axes('Parent',figure1,...
    'Position',POSS(2,:));hold on;box on
load('Results/KDET0_Run_20140811_FreeZero_OFM.mat','node0','tri0','MaxH');
plotinundation_single2(MaxH,node0,tri0,axes1,POSS(2,:));
plotsurcharge2(axes1,ToTalData15m,ToTalLatLong,Allmanholesim);
xlim([3.317*10^5 3.344*10^5]);ylim([4.7063 4.7101]*10^6);

set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[]);
title('a','FontSize',14);axes1.TitleHorizontalAlignment = 'left';

Event = 5;
% load('Results/Scen_Storage_OFM.mat','MaxH');
MaxH_scen = MaxH;
load Results\Hmax.mat;
axes1 = axes('Parent',figure1,...
    'Position',POSS(3,:));hold on;box on
plotinundation_different2(MaxH_scen-MaxH{Event,1}(:,3),node0,tri0,axes1,[0.57 0.5 0.25 0.35]);
xlim([3.317*10^5 3.344*10^5]);ylim([4.7063 4.7101]*10^6);
set(axes1,'FontSize',12,'TickDir','out','TickLength',[0.01 0.01],'layer','top','XTick',[],'YTick',[]);
title('b','FontSize',14);axes1.TitleHorizontalAlignment = 'left';


Name = ['Figs/F_scen_freezero.pdf'];
exportgraphics(figure1, Name, 'ContentType', 'vector');
exportgraphics(figure1,"Figs/F_scen_freezero.jpeg",'Resolution',600);