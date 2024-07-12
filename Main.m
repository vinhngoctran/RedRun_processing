% READ DATA FROM MODEL OUTPUTS
clear all; close all; clc
addpath(genpath('function'));
load('Selected_KDET.mat');
Structture = ["KDETA_Run_","KDETB_Run_"]; % A = HR (homogenou rain); B = NR (no rain)
Scenario = ["None","Free","Int"];
Comments = ["RedRun_V1","RedRun_V2","RedRun_V3"];
Infile = ["RedRun_building_Sewer_V1_None","RedRun_building_Sewer_V2_Free","RedRun_building_Sewer_V3_Integrated"];
for i=2
    for j=1:14
        for k=1:3
            EventName = datestr(SelectedDate(1,j),'yyyymmdd')
            FolderName = [Structture{i},EventName,'_',Scenario{k}]
    	    Savename = ['Results/',Structture{i},EventName,'_',Scenario{k},'_OFM_.mat'];
    	    if exist(Savename)==0
                [vec0,ofm_timestep,node0,tri0,plt0,plt0_BASE,vor0,Qoutlet] = loadtribs([FolderName,'/Output']);
                for jjj=1:numel(vec0)
                    Inundation(:,jjj) = vec0(jjj).H;
                end
                MaxH = max(Inundation')';
                MaxH(MaxH<1e-3) = NaN;
                save(Savename,'vec0','ofm_timestep','node0','tri0','plt0','plt0_BASE','vor0','MaxH','Qoutlet','-v7.3');
                clearvars vec0 ofm_timestep node0 tri0 plt0 plt0_BASE vor0 Inundation MaxH Qoutlet
    	    end
    	    if k>1
                Savename = ['Results/',Structture{i},EventName,'_',Scenario{k},'_SFM_.mat'];
    	    	if exist(Savename)==0
                    [ToTalData15m,ToTalLatLong,Allmanholesim,OUTFALL] = readmanhole([FolderName,'/Output']);
                    save(Savename,'ToTalData15m','ToTalLatLong','Allmanholesim','OUTFALL','-v7.3');
                    clearvars ToTalData15m ToTalLatLong Allmanholesim OUTFALL
    	    	end
    	    end
        end
    end
end

%% EXPORT DATA TO FIGURE INPUT
% Export Hmax
clear all; close all; clc
addpath(genpath('function'));
load('Selected_KDET.mat');
Structture = ["KDETA_Run_","KDETB_Run_"];
Scenario = ["None","Free","Int"];
Comments = ["RedRun_V1","RedRun_V2","RedRun_V3"];
Infile = ["RedRun_building_Sewer_V1_None","RedRun_building_Sewer_V2_Free","RedRun_building_Sewer_V3_Integrated"];
IDout = ["OO1","OO3"];
load('Results\KDETA_Run_20090720_Free_SFM_.mat', 'ToTalLatLong','Allmanholesim');
load('Results\KDETA_Run_20090720_Free_OFM_.mat', 'tri0')
for i=1:size(tri0,2)
    CentXY(i,:) = [tri0(i).centX,tri0(i).centY,tri0(i).area];
end
Warren = shaperead("Map/SelectedArea_2.shp");
XX = Warren.X(1:end)';
YY = Warren.Y(1:end)';
[in,on] = inpolygon(CentXY(:,1),CentXY(:,2),XX,YY);
AREA = CentXY(in,3);
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    idy(i) = findclosest(ToTalLatLong{idx},CentXY(:,1:2));
end
for i=1:2
    for j=1:14
        for k=1:3
            EventName = datestr(SelectedDate(1,j),'yyyymmdd');
            FolderName = [Structture{i},EventName,'_',Scenario{k}];
            Savename = ['Results/',Structture{i},EventName,'_',Scenario{k},'_OFM_.mat'];
            load(Savename,'vec0');
            for jjj=1:numel(vec0)
                Inundation(:,jjj) = vec0(jjj).H;
                ETA(:,jjj) = vec0(jjj).eta;
            end
            N = size(Inundation,2);
            for l=1:2
                Houtfall2{j,i}(1:N,l,k) = Inundation(idy(l),:)';
                EtaOutfall{j,i}(1:N,l,k) = ETA(idy(l),:)';
            end
            [MaxH{j,i}(:,k), TimeMax{j,i}(:,k)] = max(Inundation,[],2);
            Inundation_W = Inundation(in,:);
            Inundation_W(Inundation_W<=0) = 0.001;
            DEPTH = [0 0.1 0.5 1 1.5 2 100000];
            for kk=1:size(Inundation_W,2)
                for jj = 1:numel(DEPTH)-1
                    idx = find(Inundation_W(:,kk)>DEPTH(jj) & Inundation_W(:,kk)<=DEPTH(jj+1));
                    AreaTimeMax0205{j,i}(kk,k,jj) = sum(AREA(idx,1))/1000000;
                end
            end
            clearvars Inundation ETA;
        end
    end
end
save('Results\Hmax_AreaTime.mat','MaxH',"TimeMax",'AreaTimeMax0205');
save('Results\H_outfall.mat','Houtfall2','EtaOutfall');

%% Export Water level at outfalls
clear all; close all; clc
addpath(genpath('function'));
load('Selected_KDET.mat');
Structture = ["KDETA_Run_","KDETB_Run_"];
Scenario = ["None","Free","Int"];
Comments = ["RedRun_V1","RedRun_V2","RedRun_V3"];
Infile = ["RedRun_building_Sewer_V1_None","RedRun_building_Sewer_V2_Free","RedRun_building_Sewer_V3_Integrated"];
IDout = ["OO1","OO3"];
InvertEle = [181, 183.5];
for i=1:2
    for j=1:14
        for k=2:3
            EventName = datestr(SelectedDate(1,j),'yyyymmdd');
            FolderName = [Structture{i},EventName,'_',Scenario{k}];
            Savename = ['Results/',Structture{i},EventName,'_',Scenario{k},'_SFM_.mat']
            load(Savename,'Allmanholesim','ToTalData15m');
            N = numel(ToTalData15m{1}.Data1);
            for l=1:2
                idx = find(Allmanholesim==IDout{l});
                Qinoutfall{j,i}(1:N,l,k-1) = ToTalData15m{idx}.Data1;
                Houtfall{j,i}(1:N,l,k-1) = ToTalData15m{idx}.Data2;
                Q2outfall{j,i}(1:N,l,k-1) = ToTalData15m{idx}.Data3;
            end
        end
    end
end
save('Results\Q_OutFall.mat','Qinoutfall','Houtfall','Q2outfall','InvertEle');

%% Read output from Scenario_3 storages
clear all; close all; clc
addpath(genpath('function'));

[vec0,ofm_timestep,node0,tri0,plt0,plt0_BASE,vor0,Qoutlet] = loadtribs('RedRun_Storage/Output');
for jjj=1:numel(vec0)
    Inundation(:,jjj) = vec0(jjj).H;
end
MaxH = max(Inundation')';
MaxH(MaxH<1e-3) = NaN;
save('Results/Scen_Storage_OFM.mat','vec0','ofm_timestep','node0','tri0','plt0','plt0_BASE','vor0','MaxH','Qoutlet','-v7.3');
clearvars vec0 ofm_timestep node0 tri0 plt0 plt0_BASE vor0 Inundation MaxH Qoutlet

[ToTalData15m,ToTalLatLong,Allmanholesim,OUTFALL] = readmanhole('RedRun_Storage/Output');
RainInvesting = readtable('RedRun_Storage\Output\Hyd\RedRun.storage','FileType','text');
RainInvesting = table2array(RainInvesting);
save('Results/Scen_Storage_SFM.mat','ToTalData15m','ToTalLatLong','Allmanholesim','OUTFALL','RainInvesting','-v7.3');

% extract data to plot - scenario
IDout = ["OO1","OO3"];
load('Results\KDETA_Run_20090720_Free_SFM_.mat', 'ToTalLatLong','Allmanholesim','ToTalData15m');
load('Results\KDETA_Run_20090720_Free_OFM_.mat', 'tri0')
load('Results/Scen_Storage_OFM.mat','vec0');

for i=1:size(tri0,2)
    CentXY(i,:) = [tri0(i).centX,tri0(i).centY,tri0(i).area];
end
Warren = shaperead("Map/SelectedArea_2.shp");
XX = Warren.X(1:end)';
YY = Warren.Y(1:end)';
[in,on] = inpolygon(CentXY(:,1),CentXY(:,2),XX,YY);
AREA = CentXY(in,3);
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    idy(i) = findclosest(ToTalLatLong{idx},CentXY(:,1:2));
end

for jjj=1:numel(vec0)
    Inundation(:,jjj) = vec0(jjj).H;
    ETA(:,jjj) = vec0(jjj).eta;
end
N = size(Inundation,2);
for l=1:2
    Houtfall2(1:N,l) = Inundation(idy(l),:)';
    EtaOutfall(1:N,l) = ETA(idy(l),:)';
end
[MaxH(:,1), TimeMax(:,1)] = max(Inundation,[],2);
Inundation_W = Inundation(in,:);
Inundation_W(Inundation_W<=0) = 0.001;
DEPTH = [0 0.1 0.5 1 1.5 2 100000];
for kk=1:size(Inundation_W,2)
    for jj = 1:numel(DEPTH)-1
        idx = find(Inundation_W(:,kk)>DEPTH(jj) & Inundation_W(:,kk)<=DEPTH(jj+1));
        AreaTimeMax0205(kk,jj) = sum(AREA(idx,1))/1000000;
    end
end
save('Results\Scen_Hmax_AreaTime.mat','MaxH',"TimeMax",'AreaTimeMax0205');
save('Results\Scen_H_outfall.mat','Houtfall2','EtaOutfall');


%% Read output from Scenario Zero: all water at outfall loss
clear all; close all; clc
addpath(genpath('function'));

[vec0,ofm_timestep,node0,tri0,plt0,plt0_BASE,vor0,Qoutlet] = loadtribs('KDET0_Run_20140811_FreeZero/Output');
for jjj=1:numel(vec0)
    Inundation(:,jjj) = vec0(jjj).H;
end
MaxH = max(Inundation')';
MaxH(MaxH<1e-3) = NaN;
save('Results/KDET0_Run_20140811_FreeZero_OFM.mat','vec0','ofm_timestep','node0','tri0','plt0','plt0_BASE','vor0','MaxH','Qoutlet','-v7.3');
clearvars vec0 ofm_timestep node0 tri0 plt0 plt0_BASE vor0 Inundation MaxH Qoutlet

[ToTalData15m,ToTalLatLong,Allmanholesim,OUTFALL] = readmanhole('KDET0_Run_20140811_FreeZero/Output');
% RainInvesting = readtable('RedRun_Storage\Output\Hyd\RedRun.storage','FileType','text');
% RainInvesting = table2array(RainInvesting);
save('Results/KDET0_Run_20140811_FreeZero_SFM.mat','ToTalData15m','ToTalLatLong','Allmanholesim','OUTFALL','-v7.3');

%% extract data to plot - Scenario Zero: all water at outfall loss
IDout = ["OO1","OO3"];
load('Results\KDETA_Run_20090720_Free_SFM_.mat', 'ToTalLatLong','Allmanholesim','ToTalData15m');
load('Results\KDETA_Run_20090720_Free_OFM_.mat', 'tri0')
load('Results/KDET0_Run_20140811_FreeZero_OFM.mat','vec0');

for i=1:size(tri0,2)
    CentXY(i,:) = [tri0(i).centX,tri0(i).centY,tri0(i).area];
end
Warren = shaperead("Map/SelectedArea_2.shp");
XX = Warren.X(1:end)';
YY = Warren.Y(1:end)';
[in,on] = inpolygon(CentXY(:,1),CentXY(:,2),XX,YY);
AREA = CentXY(in,3);
for i=1:2
    idx = find(Allmanholesim==IDout{i});
    idy(i) = findclosest(ToTalLatLong{idx},CentXY(:,1:2));
end

for jjj=1:numel(vec0)
    Inundation(:,jjj) = vec0(jjj).H;
    ETA(:,jjj) = vec0(jjj).eta;
end
N = size(Inundation,2);
for l=1:2
    Houtfall2(1:N,l) = Inundation(idy(l),:)';
    EtaOutfall(1:N,l) = ETA(idy(l),:)';
end
[MaxH(:,1), TimeMax(:,1)] = max(Inundation,[],2);
Inundation_W = Inundation(in,:);
Inundation_W(Inundation_W<=0) = 0.001;
DEPTH = [0 0.1 0.5 1 1.5 2 100000];
for kk=1:size(Inundation_W,2)
    for jj = 1:numel(DEPTH)-1
        idx = find(Inundation_W(:,kk)>DEPTH(jj) & Inundation_W(:,kk)<=DEPTH(jj+1));
        AreaTimeMax0205(kk,jj) = sum(AREA(idx,1))/1000000;
    end
end
save('Results\ScenFreeZero_Hmax_AreaTime.mat','MaxH',"TimeMax",'AreaTimeMax0205');
save('Results\ScenFreeZero_H_outfall.mat','Houtfall2','EtaOutfall');

%% Find closest location for observation points
clear all; close all; clc
load('Results\ObsDepth.mat');
load('Results/KDETA_Run_20140811_Int_OFM_.mat');
for i=1:size(tri0,2)
    CentXY(i,:) = [tri0(i).centX,tri0(i).centY,tri0(i).area];
end

Warren = shaperead("Map/Domain2.shp");
XX = Warren.X(1:end)';
YY = Warren.Y(1:end)';
[in,on] = inpolygon(ObsDepth(:,1),ObsDepth(:,2),XX,YY);
ObsDepth_R = ObsDepth;


for i=1:size(ObsDepth_R,1)
    idx(i) = findclosest(ObsDepth_R(i,1:2),CentXY(:,1:2));
end

for jjj=1:numel(vec0)
    Inundation(:,jjj) = vec0(jjj).H;
end
for l=1:size(ObsDepth_R,1)
    Inundation_eval(:,l) = Inundation(idx(l),:)';
end


%% Plot example
clear all; close all; clc
load('Results\Q_OutFall.mat','Qinoutfall','Houtfall','Q2outfall','InvertEle');
load('Results\H_outfall.mat','Houtfall2','EtaOutfall');
Event = 5;
Scen = 1;
InvertEle = [181, 183.5];

plothydrograph(InvertEle,Qinoutfall{Event,Scen},EtaOutfall{Event,Scen},Q2outfall{Event,Scen});


%% Plot example
% clear all; close all; clc
load Results\Hmax.mat;
load('Results\KDETA_Run_20090720_Free_OFM_.mat','node0','tri0');
Event = 5;
Scen = 1;
plotinundation(MaxH{Event,Scen},node0,tri0)

%% ====================================
% Figure plot
plot_studyarea_3;   % Figure 2
plot_waterlevel_3();    % Figure 3
plot_floodResponse4();  % Figure 4
