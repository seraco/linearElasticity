function ToGID (file_name,istep,xnodes,conectivities,nnode,nelem,npnod)
% Construcción de malla postproceso
% file_name es el nombre del arxivo de postproceso
% istep es iteracio en el temps
% xnodes es la posicion de los nodos (filas el nodo, columnas direccion x e y)
% nnode=2;
% ngaus = 1;
% nelem: numero de elementos
% npnod : numero de nodos totales
% dis: desplazamientos ( filas son nodos, columnas direccion x e y)
% conectivities: conectividades (matriz T)


gtype = 'Linear';
msh_file = strcat(file_name,'_',num2str(istep),'.flavia.msh');
fid = fopen(msh_file,'w');

fprintf(fid,'MESH "WORKPIECE" dimension %2.0f  Elemtype %s   Nnode %2.0f \n \n',3,gtype,nnode);
fprintf(fid,'Coordinates \n');
for i = 1 : npnod
    fprintf(fid,'%6.0f %12.5d %12.5d %12.5d',i,xnodes(i,:));
    fprintf(fid,'\n');
end
fprintf(fid,'End Coordinates \n \n');
fprintf(fid,'Elements \n');

fprintf(fid,'%6.0f %6.0f %6.0f \n',[1:nelem;conectivities']);

fprintf(fid,'End elements \n \n');


fclose(fid);

end
