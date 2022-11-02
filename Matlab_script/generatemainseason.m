function generatemainseason(fl,vppname,vppnodata,vppid,vppfolder,outfolder)
%UNTITLED2 Summary of this function goes here
%% generate dominent season id (S1 or S2)

% import s1 TPROD
s1 = double(imread(fullfile(vppfolder,fl{vppid,1}))); % read s1 TPROD (double)
s1(s1==vppnodata(vppid))=nan; % set nan value

% import s2 TPROD
s2 = double(imread(fullfile(vppfolder,fl{vppid,2}))); % read s2 TPROD (double)
s2(s2==vppnodata(vppid))=nan; % set nan value

% combine s1 and s2 to a 3d matrix
s1_s2 = cat(3,s1,s2);

% determine where the max TPROD is, <dsid> represent the dominant season
[~,dsid] = max(s1_s2,[],3);

%% generate dominent seasons
for i = 1:length(vppname)
    % import s1
    vppfile1 = fullfile(vppfolder,fl{i,1});
    if ~isfile(vppfile1)
        continue
    end
    [vpp_s1,~] = geotiffread(vppfile1); % 

    % import s2
    vppfile1 = fullfile(vppfolder,fl{i,2});
    if ~isfile(vppfile2)
        continue
    end
    [vpp_s2,R] = geotiffread(vppfile1); % 
    info = geotiffinfo(vppfile1);

    % create vpp_dominant
    vpp_dominant = vpp_s1;
    % replace values if the dominant season is s2 (dsid == 2)
    vpp_dominant(dsid==2) = vpp_s2(dsid==2);

    % generate new output
    ouputfile = strrep(fl{i,1},'_s1_','_main_');
    % write the dominant to tiff
    geotiffwrite(fullfile(outfolder,ouputfile),vpp_dominant,R,...
        'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
end
end