function Yn1 = midPointImplicit( tn, Yn, M, K, h )

options = optimoptions('fsolve','Display','none') ;

Yn1 = fsolve(@(Yn1) Yn1 - Yn - h * CTemporalSolution.f( tn+0.5*h, 0.5*(Yn1+Yn), M, K ), Yn, options) ;

end

