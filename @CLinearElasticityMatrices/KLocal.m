function KL = KLocal( A, E, L, theta, ux, uy, uz )

K = ( A*E/L ) * [ 1 -1 0 0 0 0 ;
                      -1 1 0 0 0 0 ;
                      0 0 0 0 0 0 ;
                      0 0 0 0 0 0 ;
                      0 0 0 0 0 0 ;
                      0 0 0 0 0 0 ];

    R = [ cos(theta)+ux^2*(1-cos(theta))        0                                   ux*uy*(1-cos(theta))-uz*sin(theta)  0                                   ux*uz*(1-cos(theta))+uy*sin(theta)  0 ;
          0                                     cos(theta)+ux^2*(1-cos(theta))      0                                   ux*uy*(1-cos(theta))-uz*sin(theta)  0                                   ux*uz*(1-cos(theta))+uy*sin(theta) ;
          uy*ux*(1-cos(theta))+uz*sin(theta)    0                                   cos(theta)+uy^2*(1-cos(theta))      0                                   uy*uz*(1-cos(theta))-ux*sin(theta)  0 ;
          0                                     uy*ux*(1-cos(theta))+uz*sin(theta)  0                                   cos(theta)+uy^2*(1-cos(theta))      0                                   uy*uz*(1-cos(theta))-ux*sin(theta) ;
          uz*ux*(1-cos(theta))-uy*sin(theta)    0                                   uz*uy*(1-cos(theta))+ux*sin(theta)  0                                   cos(theta)+uz^2*(1-cos(theta))      0 ;
          0                                     uz*ux*(1-cos(theta))-uy*sin(theta)  0                                   uz*uy*(1-cos(theta))+ux*sin(theta)  0                                   cos(theta)+uz^2*(1-cos(theta)) ];
    
    KL = R' * K * R ;

end

