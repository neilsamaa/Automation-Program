import os
from pathlib import Path
from datetime import datetime

DATE=datetime.now().strftime("%Y-%m-%d-%H%M%S")
# directory to save the backup
BACKUP_DIRECTORY='/home/mirza/backup' # Auto create new directory if path doesn't exist
# directory you want to backup
OBJECT_TO_BACKUP='/home/mirza folder' # Separate using whitespace for last directory you want to backup
# name of the backup file
FILENAME='surat'
BACKUP_FILENAME = FILENAME.replace(" ","_")
# max number of backup file (will be deleted if more than set)
MAX_BACKUP_FILE = 1

def tarfile():
    os.system(f'tar -czvf {BACKUP_DIRECTORY}/{BACKUP_FILENAME}_{DATE}.tar.gz -C {OBJECT_TO_BACKUP}')

backup_directory_path = Path(BACKUP_DIRECTORY)

if backup_directory_path.exists():
    print('Backup started...')
    tarfile()
    print(f'Backup file saved at {BACKUP_DIRECTORY}')
else:
    print('Backup path not found...')
    print('New directory created...')
    print('Backup started...')
    backup_directory_path.mkdir(parents=True, exist_ok=True)
    tarfile()
    print(f'Backup file saved at {BACKUP_DIRECTORY}')

existing_backups = [
    x for x in backup_directory_path.iterdir()
    if x.is_file() and x.suffix == '.gz' and x.name.startswith(BACKUP_FILENAME)]

oldest_to_newest_backup_by_name = list(sorted(existing_backups, key=lambda f: f.name))
if len(oldest_to_newest_backup_by_name) > MAX_BACKUP_FILE:
    print("Backup file exceeds the set limit, old files will be replaced!")
    while len(oldest_to_newest_backup_by_name) > MAX_BACKUP_FILE:
        backup_to_delete = oldest_to_newest_backup_by_name.pop(0)
        backup_to_delete.unlink()

# number of days to keep local backup copy
# INTERVAL=2
# Delete old files
# os.system(f'find {BACKUP_DIRECTORY} -type d -mtime +{INTERVAL} -exec rm -r '+'{} \;')