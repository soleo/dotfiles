# Hacking for Arduino running on Mac OS El Capitan

## Step 1: Enter Recovery mode  by restarting your computer and holding down Command+R until the Apple logo appears on your screen.

## Step 2: Disble SIP for unsigned driver
```
csrutil enable --without kext
```