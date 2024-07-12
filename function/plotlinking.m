function plotlinking(ConnectStorage,Allmanholesim,ToTalLatLong)
for i=1:size(ConnectStorage,1)
    idx = find(Allmanholesim==ConnectStorage.Var2{i});
    idy = find(Allmanholesim==ConnectStorage.Var3{i});

    plot([ToTalLatLong{idx}(1), ToTalLatLong{idy}(1)],[ToTalLatLong{idx}(2), ToTalLatLong{idy}(2)],'LineWidth',1,'Color','k');
end
end