classdef COneModeSolution
    %CMesh
    %   Brief: Main class used to calculate the temporal solution of a mode
    %   Author: S.Ramon
    %   Version: 0.0.1
    %   Todo: Set totalEnergy as dependent property
    
    properties
        potentialEnergy
        kineticEnergy
        totalEnergy
        t
    end
    
    methods
        function object = COneModeSolution( mode, t, LEMatrices, ModalSolution )
            if nargin > 0
                X = ModalSolution.X;
                w = ModalSolution.w;
                object.potentialEnergy = zeros(1, size(t,2));
                object.kineticEnergy = zeros(1, size(t,2));
                object.totalEnergy = zeros(1, size(t,2));
                object.t = t;
                M = LEMatrices.M;
                K = LEMatrices.K;

                for j = 1:size(t,2)

%                     filename = strcat('data/problema7_mode_', num2str(i)) ;
% 
%                     ToGID ( filename, t(j), xpoints(:,1:3), T, nnodepelem, nelem, nnode );

                    x = X(:,mode)*sin(w(mode)*t(j));
                    v = X(:,mode)*w(mode)*cos(w(mode)*t(j));

%                     ToGiD_post( filename, t(j), nnodepelem, ndofpn, 1, modes' );

                    object.potentialEnergy(j) = 0.5*x'*K*x;
                    object.kineticEnergy(j) = 0.5*v'*M*v;
                    object.totalEnergy(j) = object.potentialEnergy(j) + object.kineticEnergy(j);

                end
            end
        end
        function plotEnergy( object )
            figure
            o = object;
            plot(o.t,o.potentialEnergy,o.t,o.kineticEnergy,o.t,o.totalEnergy);
            title('Total Energy')
            xlabel('t[s]')
            ylabel('Energy[W]')
            legend('Potential','Kinetic','Total')
        end
    end
    
end

