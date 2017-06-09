classdef CBaseSolution
    %CMesh
    %   Brief: Base class for time solutions
    %   Author: S.Ramon
    %   Version: 0.0.1

    properties
        potentialEnergy
        kineticEnergy
        t
    end
    properties (Dependent)
        totalEnergy
    end

    methods
        function result = get.totalEnergy( object )
            result = object.potentialEnergy + object.kineticEnergy;
        end
        function plotEnergy( object )
            figure
            o = object;
            plot(o.t,o.potentialEnergy,o.t,o.kineticEnergy,o.t,o.totalEnergy);
            title('Energy')
            xlabel('t[s]')
            ylabel('Energy[J]')
            legend('Potential','Kinetic','Total')
        end
        function plotError( object, ModalSolution )
            figure
            o = object;
            error = abs(o.totalEnergy-ModalSolution.totalEnergy)./ModalSolution.totalEnergy;
            plot(o.t,error);
            title('Error')
            xlabel('t[s]')
            ylabel('Error')
        end
    end

end
