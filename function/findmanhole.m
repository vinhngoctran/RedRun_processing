function idx = findmanhole(Surcharge,ToTalLatLong)
for i=1:numel(ToTalLatLong)
    Distn(i,1) = sqrt((ToTalLatLong{i}(1)-Surcharge(1))^2+(ToTalLatLong{i}(2)-Surcharge(2))^2);
end
idx = find(Distn == min(Distn));
end 