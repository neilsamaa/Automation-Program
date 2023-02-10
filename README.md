# DevOps Tools
Automation Program Shell and Python

## Program List

| Name File | Type     | Input | Description                |
| :-------- | :------- | :------- |:------------------------- |
| backup.sh | `bash` | static | Backup to .tar.gz file with static path |
| docker-portainer.sh | `bash` | static | Install **docker** and **portainer** |
| install-selection.sh | `bash` | dynamic | Install **docker** and **portainer** with selection options|
| python-backup-zip.py | `python` | dynamic | Backup to .zip file with input path |
| python-backup.py | `python` | static | Backup to .tar.gz file with static path |

#### Notes
**static:** static is mean you must edit file for define path

**dynamic:** dynamic is mean you just need to input variable or path without edit file


## How to run program
#### Bash
Make sure bash file is executeable
```bash
chmod +x docker-portainer.sh
```
```bash
./docker-portainer.sh
```
#### Python
You can run using python or python3 (for example using python3)
```python
python3 python-backup.py
```

#### Automation
You can use automation backup using crontab with program static path.
First access crontab on your linux
```bash
crontab -e
```
Then add specific time for this program running, you can add script to end of line in crontab configuration.
In this example use every minute backup, you can custom your time using this web [Crontab](https://crontab.guru).
```bash
* * * * * python3 /home/mirza/python-backup.py
```
Now save the crontab and then your program will automaticaly running and backup your file.
