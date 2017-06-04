function Yn1 = forwardEuler( tn, Yn, M, K, h )

fn = CTemporalSolution.f(tn, Yn, M, K ) ;

Yn1 = Yn + h * fn ;

end

