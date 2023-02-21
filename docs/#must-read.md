Run multiple OS'ses on Win 10

links:
https://adamtheautomator.com/windows-subsystem-for-linux/
https://learn.microsoft.com/en-us/windows/wsl/wsl-config
https://endjin.com/blog/2021/11/setting-up-multiple-wsl-distribution-instances
https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-10#3-download-ubuntu

```
1 wsl --list --online
2 wsl --install -d Ubuntu-20.04
```

export path problem on Ybuntu (Windows WSL 2.0)

**sudo nano /etc/wsl.conf

[interop]
appendWindowsPath=false**

```wsl --terminate Ubuntu-20.04```

```wsl --install -d Ubuntu-20.04```

Drop OS:
1 wsl --list
2 wsl --unregister Ubuntu-20.04
3 RCM -> Apps -> Ubuntu -> Delete (https://pureinfotech.com/remove-linux-distro-wsl/)

nano usefull cmds:
Ctrl + 6 to set a mark.
Alt + T will delete all content in a file. 