clear

%% vpp labels
% tile name
tilename = '33VUE';
% year
year = '2019';
% list of VPP name
% SOSD,EOSD,MAXD,SOSV,EOSV,MINV,MAXV,AMPL,LENGTH,LSLOPE,RSLOPE,SPROD,TPROD,QFLAG
vppname   = {'SOSD','EOSD','MAXD','SOSV','EOSV','MINV','MAXV','AMPL','LENGTH','LSLOPE','RSLOPE','SPROD','TPROD','QFLAG'};
% list of VPP nan value 
vppnodata = [  0   ,  0   ,  0   ,-32768,-32768,-32768,-32768,-32768,   0    ,-32768  ,-32768  ,65535  ,65535];
% VPP data folder
vppfolder = ['/Users/zhanzhangcai/Library/CloudStorage/OneDrive-LundUniversity/HR-VPP/HRVPP_data/','T',tilename,'_VPP/'];
% output folder
outfolder = ['/Users/zhanzhangcai/Library/CloudStorage/OneDrive-LundUniversity/HR-VPP/HRVPP_data/','T',tilename,'_VPP/'];

%% generate vpp file list
fl = cell(14,2); % 13vpp + 1 qflag; 2 seasons
for s = 1:2 % season
    for i = 1:length(vppname)
        vname = ['VPP_',year,'_S2_T',tilename,'-010m_V101_s',num2str(s),'_',vppname{i},'.tif'];
        if isfile(fullfile(vppfolder,vname))
            fl{i,s} = vname;
        end
    end
end

%% run main season generator
vppid = 13; % use TPROD to determine the main season
generatemainseason(fl,vppname,vppnodata,vppid,vppfolder,outfolder)