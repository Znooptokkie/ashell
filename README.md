# Start-up

1. Navigate to the Quickshell folder
```bash
cd ~/.config/quickshell/ashell
```

2. Start Quickshell
```bash
quickshell -c ashell
```

# Set-up

## Old Service

1. See what service is running
```bash
systemctl --user list-units --type=service --state=running
```

2. Disable running service
```bash
systemctl --user disable --now oude-ashell.service
```

## New Service

1. Make a config file for **systemd** (See 'Settings')
```bash
nano ~/.config/systemd/user/ashell.service
```
2. Reload the Daemon
```bash
systemctl --user daemon-reload
```

3. Start the new service
```bash
systemctl --user enable --now ashell.service
```

# Settings

- ashell.service
```ini
[Unit]
Description=Ashell Quickshell config

[Service]
ExecStart=quickshell -c ashell
Restart=on-failure

[Install]
WantedBy=default.target
```