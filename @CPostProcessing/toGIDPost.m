function toGIDPost(object,nnodepelem,ndofpn,ngaus,disp)
% Escribe el fichero de resultados
% filename es el nombre del arxivo de postproceso
% time es timeacio en el temps
% nnodepelem=2;
% ngaus = 1;
% dis: desplazamientos ( filas son nodos, columnas direccion x e y)
gtype = 'Linear';
res_file = strcat(object.filename,'_',num2str(object.time),'.flavia.res');
fid = fopen(res_file,'w');
job=1;
object.gidWriteHeaderPost(fid,gtype,ngaus,job)


% DISPLACEMENT
nameres = 'DISPLACEMENT';

u = reshape(disp, [], ndofpn) ;

object.gidWriteVField(fid,nameres,object.time,u);

fclose(fid);

end