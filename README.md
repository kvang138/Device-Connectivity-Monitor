# 🕵️💻⌨️🖱️📋Device Connectivity Monitor
Ever wonder what devices are connecting to (or disconnecting from) your computer—especially when you're not around?
Now you don't have to guess. Device Connectivity Monitor tracks USB and other hardware device connection and disconnection events in real time, logging them to a database for later review.

## 📖Introduction
This project was created to monitor and log potentially unknown device connectivity events, saving the details in a database so you can review them later.
The PowerShell script uses modern CIM (Common Information Model) queries—instead of the older WMI (Windows Management Instrumentation)—to detect device connection events reliably and efficiently.
Now, when you step away from your computer, you can later check whether any devices were plugged in or removed while you were gone.

Currently, it uses Microsoft SQL Server as the backend database for log storage. However, the script can be easily modified to support other databases such as SQLite, MySQL, PostgreSQL, Oracle, and more.

## 🚀Usage
```
powershell -ExecutionPolicy ByPass -File "device connectivity monitor.ps1" -ConnectionString <base64-encoded-database-connection-string>
```
## Languages/Tools
- PowerShell
- Microsoft SQL Server (backend database)

## Screenshots
![Device Connectivity Monitor](https://github.com/kvang138/Device-Connectivity-Monitor/blob/main/Screenshots/Device-Connectivity-Monitor.png)
