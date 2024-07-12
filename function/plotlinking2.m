function plotlinking2(ConnectStorage,Allmanholesim,ToTalLatLong)
for i=1:size(ConnectStorage,1)
    idx = find(Allmanholesim==ConnectStorage.Var2{i});
    idy = find(Allmanholesim==ConnectStorage.Var3{i});
    
    scatter([ToTalLatLong{idx}(1), ToTalLatLong{idx}(2)],[ToTalLatLong{idy}(1), ToTalLatLong{idy}(2)], 'o',...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',[0 0.4470 0.7410],'SizeData',80,'DisplayName','Surcharged manhole');

end
end