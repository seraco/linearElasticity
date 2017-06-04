function ToGiD_post(file_name,iter,nnodepelem,ndofpn,ngaus,disp)
% Escribe el fichero de resultados
% file_name es el nombre del arxivo de postproceso
% iter es iteracio en el temps
% nnodepelem=2;
% ngaus = 1;
% dis: desplazamientos ( filas son nodos, columnas direccion x e y)
gtype = 'Linear';
res_file = strcat(file_name,'_',num2str(iter),'.flavia.res');
fid = fopen(res_file,'w');
job=1;
gid_write_headerpost(fid,gtype,ngaus,job)


% DISPLACEMENT
nameres = 'DISPLACEMENT';

u = reshape(disp, [], ndofpn) ;

gid_write_vfield(fid,nameres,iter,u);

fclose(fid);

end
