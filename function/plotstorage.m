function plotstorage(axes1,ToTalData15m,ToTalLatLong,Allmanholesim)
SN = 0;
NAME = ["S1","S2","S3"];
for j=1:size(ToTalData15m,2)
    if contains(Allmanholesim{j},'S') && SN <3
        l8 = scatter(ToTalLatLong{1,j}(1), ToTalLatLong{1,j}(2), 'square',...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',[0 0.4470 0.7410],'SizeData',200,'DisplayName','Surcharged manhole');
        SN=SN+1;
        text(ToTalLatLong{1,j}(1)+100, ToTalLatLong{1,j}(2),NAME{SN},'Color','k','FontSize',14,'FontWeight','bold')
    end
end
end