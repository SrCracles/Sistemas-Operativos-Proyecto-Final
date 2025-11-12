#!/bin/bash
#Cantidad de memoria libre y cantidad del espacio de swap en uso (en bytes y porcentaje).

# apropos -a memory free => free sirve para mostrar datos de la memoria
# man free => -b indica que la informacion debe ser desplegada en bytes
# man free => El aparatado de interes para el administrador de data centers es available. (Memoria para programas)

# El registro FNR indica el numero actual de la linea 
free -b | awk '
BEGIN{i=0;
totalMemory;
totalSwap;
freeMemory;
usedSwap;}

{
  if(FNR==2){
    totalMemory=$2;
    freeMemory=$7;
  }
}

{
  if(FNR==3){
    totalSwap=$2;
    usedSwap=$3;
  }
}


END{
  print"Total Memory: "totalMemory" bytes";
  print"Free Memory: "freeMemory" bytes";
  print"Free Memory: " (freeMemory/totalMemory)*100 " %";
  print"Total swap: "totalSwap" bytes";
  print"Used swap: "usedSwap" bytes";
  print"Used swap: "(usedSwap/totalSwap)*100" %";
}  
'
