classdef CMesh
    %CMesh
    %   Brief: Main class used to read a mesh and obtain mesh data
    %   Author: S.Ramon
    %   Version: 0.0.1
    
    properties
        xpoints
        T
        filename
    end
    properties (Dependent)
        nelem
        nnode
        ndofpn
        nnodepelem
    end
    
    methods
        function object = CMesh(filename)
            if nargin > 0
                object.filename = filename;
                [object.xpoints, object.T] = object.readMesh( filename );
            end
        end
        function result = get.nelem( object )
            result = size(object.T,1);
        end
        function result = get.nnode( object )
            result = size(object.xpoints,1);
        end
        function result = get.ndofpn( object )
            result = size(object.xpoints,2);
        end
        function result = get.nnodepelem( object )
            result = size(object.T,2);
        end
    end
    methods (Static)
        [xpoints, T] = readMesh( filename );
    end
    
end

