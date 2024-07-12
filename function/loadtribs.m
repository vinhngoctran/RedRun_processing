function [vec0,ofm_timestep,node0,tri0,plt0,plt0_BASE,vor0, Qoutlet] = loadtribs(Folder)
header = 'RedRun';	ofm_timestep = 0.1;    % REF TO 0.1

%% READ streamflow at outlet
% ftri = sprintf([Folder,'/Hyd/%s.Qoutlet'], header);
Qoutlet= load([Folder,'/Hyd/RedRun.Qoutlet']);

%% READ NODE FILE
fnode = sprintf([Folder,'/Voronoi/%s.nodes'], header);

node0 = struct('nodenum', {}, 'coordX', {}, 'coordY', {});
fnodeID = fopen(fnode, 'r');
fgetl(fnodeID);                     % READ DUMMY LINE
linenum = str2num(fgetl(fnodeID));	% READ NODE NUMBER

for line = 1:linenum
    strline = fgetl(fnodeID);       % GET LINE STRING
    ctnline = str2num(strline);     % CONVERT CONTENT TO VECTOR
    node0(line).nodenum = line - 1;
    node0(line).coordX = ctnline(1);
    node0(line).coordY = ctnline(2);
end
fclose(fnodeID);
%clearvars -except node0 header ofm_timestep Folder

%% READ TRI FILE
ftri = sprintf([Folder,'/Voronoi/%s.tri'], header);

tri0 = struct('trinum', {}, 'vertices', {}, 'centX', {}, 'centY', {}, 'area', {});
ftriID = fopen(ftri, 'r');
fgetl(ftriID);                      % READ DUMMY LINE
trinum = str2num(fgetl(ftriID));    % READ TRI NUMBER

for line = 1:trinum
    strline = fgetl(ftriID);        % GET LINE STRING
    ctnline = str2num(strline);     % CONVERT CONTENT TO VECTOR
    tri0(line).trinum = line;
    vert = ctnline(1:3);            % CURRENT TRI VERTICE #
    tri0(line).vertices = vert;
    coordXs = [node0(vert+1).coordX];
    coordYs = [node0(vert+1).coordY];
    polytri = polyshape(coordXs, coordYs);
    polyarea = area(polytri);
    [centX, centY] = centroid(polytri);     % centroid of tri
    tri0(line).centX = centX;
    tri0(line).centY = centY;
    tri0(line).area = polyarea;
end
fclose(ftriID);
%clearvars -except node0 tri0 trinum header ofm_timestep Folder

%% LOAD VECTOR MATRIX
fvec = sprintf([Folder,'/Hyd/%s.Voleta'], header);
Tvec = readtable(fvec, 'FileType','text', 'Format','%u%f%f%f%f%f%f%f');
Tvec.Properties.VariableNames = {'Time', 'eta', 'u', 'v', 'h', 'rho*ushear', 'DZ(0)', 'DZ(1)'};
Tvec.uh = Tvec.u .* Tvec.h;     Tvec.vh = Tvec.v .* Tvec.h;     % flowrate
Tvec.mag = sqrt(Tvec.u .^ 2 + Tvec.v .^ 2);     % magnitude
%clearvars -except node0 tri0 Tvec trinum header ofm_timestep Folder

%% LOAD PLT FILE
fplt = sprintf([Folder,'/Hyd/%s.plt'], header);
fpltID = fopen(fplt, 'r');  fgetl(fpltID); fgetl(fpltID);	% SKIP HEADER = 2 lines
nodenum = length(node0);        % TOTAL NODE NUMBER
% READ BASE INFO
plt0_BASE = struct("E", {}, "N", {}, "Z", {}, "eta", {}, "u", {}, "v", {}, "vmag", {}, "h", {});
for line = 1:nodenum
    strline = fgetl(fpltID);        % GET LINE STRING
    ctnline = str2num(strline);     % CONVERT CONTENT TO VECTOR
    plt0_BASE(line).E = ctnline(1);     plt0_BASE(line).N = ctnline(2);
    plt0_BASE(line).Z = ctnline(3);     plt0_BASE(line).eta = ctnline(4);
end
% SKIP TRI BASE INFO
for line = 1:length(tri0)
    fgetl(fpltID);        % GET LINE STRING
end
% GET TIME SPLIT NODE DATA
plt0 = struct("Tlbl", {}, "Data", {});      ti = 0;
while ~feof(fpltID)
    ti = ti + 1;        % TIME RECORDING LABEL
    plt0(ti).Tlbl = ti;    fgetl(fpltID);fgetl(fpltID);     % SKIP HEADER = 2 lines
    plt_data = [];
    for line = 1:nodenum
        strline = fgetl(fpltID);        % GET LINE STRING
        ctnline = str2num(strline);     % CONVERT CONTENT TO VECTOR
        plt_data = [plt_data; ctnline]; % CONCATE DATA BY NODES
    end
    plt0(ti).Data = plt_data(:, 1);     % GET ETA
end
fclose(fpltID);
%clearvars -except node0 tri0 Tvec plt0 plt0_BASE trinum header ofm_timestep Folder


%% READ VORONOI CELLS
svor = fileread(sprintf([Folder,'/Voronoi/%s_voi'], header));
svor = split(svor, 'END');      % SPLIT CELLS
vor0 = struct('ID',{}, 'XData',{}, 'YData',{}, 'XCentroid',{}, 'YCentroid',{});

for vornum = 1:length(svor)-2
    vorID = str2double(extractBefore(svor{vornum}, ','));
    vorCoords = extractAfter(svor{vornum}, ',');
    vorCoords = textscan(vorCoords, '%f,%f');
    vorX = vorCoords{1};    vorY = vorCoords{2};
    vor0(vornum).ID = vorID;
    vor0(vornum).XData = vorX(2:end);    vor0(vornum).YData = vorY(2:end);
    vor0(vornum).XCentroid = vorX(1);    vor0(vornum).YCentroid = vorY(1);
end
%clearvars svor vornum vorID vorCoords vorX vorY Folder

%% SPLIT BY TIME STAMP
times = unique(Tvec.Time);
vec0 = struct('time',{}, 'X',{}, 'Y',{}, 'eta',{},'U',{}, 'V',{}, 'Mag',{}, 'H', {});
for tid = 1:length(times)
    vec0(tid).time = double(times(tid)) ./ 36000 * (ofm_timestep / 0.1);   % CONVERT TO HOUR
    tX = [tri0.centX];     vec0(tid).X = tX(:);
    tY = [tri0.centY];     vec0(tid).Y = tY(:);
    begid = trinum * (tid - 1) + 1;
    endid = trinum * tid;
    teta = Tvec(begid:endid, 'eta');	teta = table2array(teta);   vec0(tid).eta = teta(:);
    tU = Tvec(begid:endid, 'uh');	tU = table2array(tU);   vec0(tid).U = tU(:);
    tV = Tvec(begid:endid, 'vh');	tV = table2array(tV);   vec0(tid).V = tV(:);
    tMag = Tvec(begid:endid, 'mag');tMag = table2array(tMag);   vec0(tid).Mag = tMag(:);
    tH = Tvec(begid:endid, 'h');    tH = table2array(tH);   vec0(tid).H = tH(:);
end

end