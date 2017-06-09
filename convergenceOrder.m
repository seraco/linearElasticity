clear

Mesh = CMesh( 'mesh.msh' );

InitialData = CInitialData( 'initialData.txt', Mesh.nnode, Mesh.ndofpn );

LEProblem = CLinearElasticityProblem( Mesh, InitialData );

StaticSolution = CStaticSolution( Mesh, InitialData, LEProblem.K );

iInitial = 100;
iIncrement = 100;
iFinal = 2000;

error = zeros(1, (iFinal-iInitial)/iIncrement+1);
timeStep = zeros(1, (iFinal-iInitial)/iIncrement+1);

for i=iInitial:iIncrement:iFinal
    
    j = (i - iInitial)/iIncrement + 1;
    
    InitialData.t = linspace(0, 30, i);
    
    ModalSolution = CModalSolution( Mesh, InitialData, LEProblem, StaticSolution );

    TemporalSolution = CTemporalSolution( Mesh, InitialData, LEProblem, StaticSolution );
    
    error(j) = max(abs(TemporalSolution.totalEnergy-ModalSolution.totalEnergy)./ModalSolution.totalEnergy);
%     error(j) = abs(TemporalSolution.totalEnergy(1)-ModalSolution.totalEnergy(1))/ModalSolution.totalEnergy(1);
    timeStep(j) = InitialData.t(2) - InitialData.t(1);
    
end

figure
plot(log(timeStep),log(error));
title('Error')
xlabel('h[s]')
ylabel('Error')

p = polyfit(log(timeStep),log(error),1);