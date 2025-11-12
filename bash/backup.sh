#!/bin/bash


# Hacer copia de seguridad (backup) de un directorio especificado a una memoria USB.
# Además de los archivos, se debe almacenar un catálogo que contenga los nombres de los
# archivos y su fecha de última modificación.


#Variables de interes
typeset target
typeset device
typeset targetDirectoryName
typeset mountpoint


echo "Write the full path of the target directory"
read target

# Verifica la existencia del directorio
if [[ ! -d $target ]]; then
  echo The target directory does not exist
  exit 1
fi


echo "Write the full path of device"
read device

# Verifica que exista el dispositivo y que sea tipo bloque
if [[ ! -b $device ]]; then
  echo Block Device does not exist
  exit 1
fi


targetDirectoryName=$(basename $target)

mountPoint="/media/temporal"

if [[ ! -d $mountPoint ]]; then
  mkdir $mountPoint
  echo Mount point created in $mountPoint
fi

# Monta el dispositivo
if ( mount $device $mountPoint ); then
  echo The device was mounted succesfully
fi


if (cp -r $target $mountPoint); then
  echo The information was copied to the device
else
  echo The information could not be copied to the device
fi

# Se imprime usando el formato especial printf. man find indica que %t es la fecha de ultima modificacion
# %p Es el nombre del directorio
# \n es el salto


if (find $target -type f -printf '%P,%t \n' > $mountPoint/$targetDirectoryName/catalog.csv) ; then
  echo "The catalog was created sucessfuly"
else 
  echo "The catalog could not be created"
fi

# Desmonta el dispositivo
if (umount $device); then
  echo The device was unmounted sucessfuly
fi


# Elimina el punto de puntaje
if ( rm -r $mountPoint ); then
  echo $mountPoint directory removed 
else
  echo $mountPoint could not be removed
fi




