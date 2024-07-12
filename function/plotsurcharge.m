function plotsurcharge(axes1,ToTalData15m,ToTalLatLong,Allmanholesim)
SN = 0;
for j=1:size(ToTalData15m,2)
    if sum(ToTalData15m{1,j}.Data3)>0 && contains(Allmanholesim{j},'M')
        l7 = scatter(ToTalLatLong{1,j}(1), ToTalLatLong{1,j}(2), 'o',...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',[0.6350 0.0780 0.1840],'SizeData',40,'DisplayName','Surcharged manhole');
    end
    if contains(Allmanholesim{j},'S') && SN <3
        l8 = scatter(ToTalLatLong{1,j}(1), ToTalLatLong{1,j}(2), 'square',...
            'MarkerEdgeColor','g',...
            'MarkerFaceColor','g','SizeData',100,'DisplayName','Surcharged manhole');
        SN=SN+1;
        text(ToTalLatLong{1,j}(1), ToTalLatLong{1,j}(2),['  S #',num2str(SN)],'Color','k','FontSize',14)
    end
end
end