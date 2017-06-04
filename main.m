clear

Mesh = CMesh( 'mesh.msh' );

InitialData = CInitialData( 'initialData.txt', Mesh.nnode, Mesh.ndofpn );

LEMatrices = CLinearElasticityMatrices( Mesh, InitialData );

StaticSolution = CStaticSolution( Mesh, InitialData, LEMatrices.K );

ModalSolution = CModalSolution( Mesh, InitialData, LEMatrices, StaticSolution );

TemporalSolution = CTemporalSolution( Mesh, InitialData, LEMatrices, StaticSolution );

OneModeSolution = COneModeSolution( Mesh, InitialData, LEMatrices, ModalSolution );