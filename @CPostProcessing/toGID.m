function toGID (object,xpoints,T,nnodepelem,nelem,nnode)
% Construcción de malla postproceso
% filename es el nombre del arxivo de postproceso
% istep es iteracio en el temps
% xpoints es la posicion de los nodos (filas el nodo, columnas direccion x e y)
% nnodepelem=2;
% ngaus = 1;
% nelem: numero de elementos
% nnode : numero de nodos totales
% dis: desplazamientos ( filas son nodos, columnas direccion x e y)
% T: conectividades (matriz T)


gtype = 'Linear';
msh_file = strcat(object.filename,'_',num2str(object.time),'.flavia.msh');
fid = fopen(msh_file,'w');

fprintf(fid,'MESH "WORKPIECE" dimension %2.0f  Elemtype %s   Nnode %2.0f \n \n',3,gtype,nnodepelem);
fprintf(fid,'Coordinates \n');
for i = 1 : nnode
    fprintf(fid,'%6.0f %12.5d %12.5d %12.5d',i,xpoints(i,:));
    fprintf(fid,'\n');
end
fprintf(fid,'End Coordinates \n \n');
fprintf(fid,'Elements \n');

fprintf(fid,'%6.0f %6.0f %6.0f \n',[1:nelem;T']);

fprintf(fid,'End elements \n \n');


fclose(fid);

end

