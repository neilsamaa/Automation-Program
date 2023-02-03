#!/bin/bash
export PATH=/bin:/usr/bin:/usr/local/bin
DATE=`date +"%F"`

BACKUP_PATH='/home/mirza/backup'
INTERVAL=7   ## Number of days to keep local backup copy

#################################################################

echo "Backup started ..."

tar -czvf ${BACKUP_PATH}/surat_${DATE}.tar.gz -C /home/mirza folder

#Delete old files
find ${BACKUP_PATH} -type d -mtime +$INTERVAL -exec rm -r {} \;