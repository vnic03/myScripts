# AutoWall Changer

This script allows you to automatically change your desktop background at specified intervals. It supports multi-monitor setups and adjusts the backgrounds accordingly. 

## Requirements

- GNOME Desktop Environment
- `flatpak` installed

## Script Overview

### `background.sh`

This script shuffles and sets random backgrounds from specified directories for multi-monitor setups and fr.

### `stop.sh`

Stops the background.sh script and sets specfieed wallpapapers permant.
Creates STOP file that needs to be removed lik this:

```bash
rm /tmp/stop-r-b
```

## Customization

### Paths

You need to specify the directories where your wallpapers are located.

`background.sh`:

```bash
BACKGROUND_DIR_LEFT="$HOME/Bilder/Hintergründe/left"
BACKGROUND_DIR_RIGHT="$HOME/Bilder/Hintergründe/right_or_single"
```

`stop.sh`:
```bash
BACKGROUND_LEFT="your/image/path/here/left"
BACKGROUND_RIGHT="your/image/path/here/right"
BACKGROUND="your/image/path/here/single"
```

### Interval

The interval at which the backgrounds are changed can be adjusted. The default interval is 45 seconds. To change it, modify the sleep duration in random-background.sh:

```bash
sleep 45
```

## Usage

### Start the Script

To start the script, use the following command (and make sure Stop file is removed):

```bash
# Optional
rm /tmp/stop-r-b
nohup ./random-background.sh >/dev/null 2>&1 &
```

### Stop the Script
```bash
./stop.sh
```
#### Explanation of the Commands

```bash
nohup ./random-background.sh >/dev/null 2>&1 &
``` 
This command starts the random-background.sh script in the background, redirecting all output to /dev/null.

```bash
rm /tmp/stop-r-b
```
This command removes the stop file, which allows the script to run again when started.
