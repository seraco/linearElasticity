clear

Mesh = CMesh( 'mesh.msh' );

InitialData = CInitialData( 'initialData.txt', Mesh.nnode, Mesh.ndofpn );

LEMatrices = CLinearElasticityMatrices( Mesh, InitialData );

StaticSolution = CStaticSolution( InitialData, LEMatrices.K );

ModalSolution = CModalSolution( InitialData, LEMatrices, StaticSolution );

TemporalSolution = CTemporalSolution( InitialData, LEMatrices, StaticSolution );

OneModeSolution = COneModeSolution( 1, InitialData.t, LEMatrices, ModalSolution );