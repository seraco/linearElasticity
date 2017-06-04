function Yn1 = backwardEuler( tn, Yn, M, K, h )

options = optimoptions('fsolve','Display','none') ;

Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * CTemporalSolution.f( tn+h, Yn1, M, K ), Yn, options) ;

end