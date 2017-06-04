function ML = MLocal( ro, A, L, alpha, theta, ux, uy, uz )

ML = ( ro*A*L/2 ) * [ alpha 1-alpha 0 0 0 0 ;
                      1-alpha alpha 0 0 0 0 ;
                      0 0 alpha 1-alpha 0 0 ;
                      0 0 1-alpha alpha 0 0 ;
                      0 0 0 0 alpha 1-alpha ;
                      0 0 0 0 1-alpha alpha ];

end

