classdef CPostProcessing
    %CMesh
    %   Brief: Main class for post processing operations
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    properties
        filename
        time
    end
    
    methods
        function object = CPostProcessing(filename, time)
            if nargin > 0
                if ~exist('data', 'dir')
                    mkdir('data');
                end
                object.filename = filename;
                object.time = time;
            end
        end
        toGID( object, xpoints, T, nnodepelem, nelem, nnode );
        toGIDPost( object, nnodepelem, ndofpn, ngaus, disp );
    end
    methods (Static)
        gidWriteVField( fid,nameres,time,vfield );
        gidWriteHeaderPost( fid,gtype,ngaus,job );
    end
    
end

