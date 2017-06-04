classdef COneModeSolution < CBaseSolution
    %CMesh
    %   Brief: Main class used to calculate the temporal solution of a mode
    %   Author: S.Ramon
    %   Version: 0.0.1
    %   Todo: Set totalEnergy as dependent property
    
    methods
        function object = COneModeSolution( Mesh, InitialData, LEMatrices, ModalSolution )
            if nargin > 0
                xpoints = Mesh.xpoints;
                T = Mesh.T;
                nnodepelem = Mesh.nnodepelem;
                nelem = Mesh.nelem;
                nnode = Mesh.nnode;
                ndofpn = Mesh.ndofpn;
                postProcessing = InitialData.OneModePost;
                mode = InitialData.ModePost;
                t = InitialData.t;
                object.t = t;
                X = ModalSolution.X;
                w = ModalSolution.w;
                object.potentialEnergy = zeros(1, size(t,2));
                object.kineticEnergy = zeros(1, size(t,2));
                M = LEMatrices.M;
                K = LEMatrices.K;

                for j = 1:size(t,2)

                    if postProcessing
                        
                        filename = strcat('data/', num2str(mode), 'Mode');
                        PostProcessing = CPostProcessing(filename, t(j)) ;

                        PostProcessing.toGID ( xpoints(:,1:3), T, nnodepelem, nelem, nnode );
                        PostProcessing.toGIDPost( nnodepelem, ndofpn, 1, X(:,mode)' );
                        
                    end

                    x = X(:,mode)*sin(w(mode)*t(j));
                    v = X(:,mode)*w(mode)*cos(w(mode)*t(j));

                    object.potentialEnergy(j) = 0.5*x'*K*x;
                    object.kineticEnergy(j) = 0.5*v'*M*v;

                end
            end
        end
    end
    
end

