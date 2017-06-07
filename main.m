clear

Mesh = CMesh( 'mesh.msh' );

InitialData = CInitialData( 'initialData.txt', Mesh.nnode, Mesh.ndofpn );

LEProblem = CLinearElasticityProblem( Mesh, InitialData );

StaticSolution = CStaticSolution( Mesh, InitialData, LEProblem.K );

ModalSolution = CModalSolution( Mesh, InitialData, LEProblem, StaticSolution );

TemporalSolution = CTemporalSolution( Mesh, InitialData, LEProblem, StaticSolution );

OneModeSolution = COneModeSolution( Mesh, InitialData, LEProblem, ModalSolution );