function [ToTalData15m,ToTalLatLong,Allmanholesim,OUTFALL] = readmanhole(Filename)

copyfile([Filename,'/Sewer/RedRun.inout'],[Filename,'/Sewer/RedRuntext.txt']);
Rsewer = readtable([Filename,'/Sewer/RedRuntext.txt']);
Allmanhole = string(Rsewer.ManholeID);
IDout = ["OO1","OO3"];
Allmanholesim = unique(Allmanhole);
for j=1:numel(Allmanholesim)
    idx = find(string(Rsewer.ManholeID)==Allmanholesim{j});
    Time = datetime(Rsewer.Year(idx),Rsewer.Month(idx),Rsewer.Day(idx),Rsewer.Hour(idx),Rsewer.Minute(idx),Rsewer.Second(idx)-1);
    ToTalLatLong{j} = [Rsewer.X_Coordinate(idx(1)) Rsewer.Y_Coordinate(idx(1))];
    Data = [Rsewer.Inflow(idx) Rsewer.Hydraulic_head(idx) Rsewer.Surcharge(idx)];
    TimeData = array2timetable(Data,'RowTimes',Time);
    ToTalData15m{j} = retime(TimeData,'regular','mean','TimeStep',minutes(15));
end
for j=1:2
    idx = find(string(Rsewer.ManholeID)==IDout{j});
    Time = datetime(Rsewer.Year(idx),Rsewer.Month(idx),Rsewer.Day(idx),Rsewer.Hour(idx),Rsewer.Minute(idx),Rsewer.Second(idx)-1);
    Data = [Rsewer.Inflow(idx) Rsewer.Hydraulic_head(idx) Rsewer.Surcharge(idx)];
    TimeData = array2timetable(Data,'RowTimes',Time);
    OUTFALL{j} = retime(TimeData,'regular','mean','TimeStep',minutes(15));
    OUTFALL{j}.Data2(1) = OUTFALL{j}.Data2(2);
end
end