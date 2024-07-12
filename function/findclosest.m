function ID_select = findclosest(ID_LATLON,XYAll)
Distance = sqrt((ID_LATLON(1)-XYAll(:,1)).^2+(ID_LATLON(2)-XYAll(:,2)).^2);
idx = find(Distance==min(Distance));
ID_select = idx(1);
end