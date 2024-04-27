# Ubuntu Shortcut Script #

### This script can help you to create a short in Ubuntu or any ubuntu based OS with single-line command to execute with ###

# Installation Process #

## OPTION 1 - Setup and Calling the script from terminal ##

1. Install the script - [One Time Thing]
```/bin/bash <path to file location>/install.sh```


2. Call the script 
```pyusc '<name>' '<command>' '<key_combination>'```

>Example ```pyusc 'open gedit' 'gedit' '<Alt>7'```

## OPTION 2 - Direct Script Execute

1. Copy the following code in a file and save it as ```<whatever_name>.py``` or directly download or clone the ```set_customshortcut.py```



```shell
#!/usr/bin/env python3
import subprocess
import sys

# defining keys & strings to be used
key = "org.gnome.settings-daemon.plugins.media-keys custom-keybindings"
subkey1 = key.replace(" ", ".")[:-1]+":"
item_s = "/"+key.replace(" ", "/").replace(".", "/")+"/"
firstname = "custom"
# get the current list of custom shortcuts
get = lambda cmd: subprocess.check_output(["/bin/bash", "-c", cmd]).decode("utf-8")
array_str = get("gsettings get "+key)
# in case the array was empty, remove the annotation hints
command_result = array_str.lstrip("@as")
current = eval(command_result)
# make sure the additional keybinding mention is no duplicate
n = 1
while True:
    new = item_s+firstname+str(n)+"/"
    if new in current:
        n = n+1
    else:
        break
# add the new keybinding to the list
current.append(new)
# create the shortcut, set the name, command and shortcut key
cmd0 = 'gsettings set '+key+' "'+str(current)+'"'
cmd1 = 'gsettings set '+subkey1+new+" name '"+sys.argv[1]+"'"
cmd2 = 'gsettings set '+subkey1+new+" command '"+sys.argv[2]+"'"
cmd3 = 'gsettings set '+subkey1+new+" binding '"+sys.argv[3]+"'"

for cmd in [cmd0, cmd1, cmd2, cmd3]:
    subprocess.call(["/bin/bash", "-c", cmd])
```

2. The script can be used to set a new shortcut key combination from the command line. It can be used with the command (assuming the key combination is available):
```python3 /path/to/script.py '<name>' '<command>' '<key_combination>'```

>Example: ```python3 /path/to/script.py 'open gedit' 'gedit' '<Alt>7'```

### Some of the mostly used key mentions (found experimentally, looking into the changes the GUI way made into the binding value): ###
```shell
Super key:                 <Super>
Control key:               <Primary> or <Control>
Alt key:                   <Alt>
Shift key:                 <Shift>
numbers:                   1 (just the number)
Spacebar:                  space
Slash key:                 slash
Asterisk key:              asterisk (so it would need `<Shift>` as well)
Ampersand key:             ampersand (so it would need <Shift> as well)

a few numpad keys:
Numpad divide key (`/`):   KP_Divide
Numpad multiply (Asterisk):KP_Multiply
Numpad number key(s):      KP_1
Numpad `-`:                KP_Subtract
```

