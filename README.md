SystemDJ Initialization System.

# Readme
SystemDJ is a simple init system that works with the /sbin/busybox init or any other which can execute second init after them

### Building and installing

SystemDJ written in D, so it's build system is [```dub```](https://github.com/dlang/dub). After build, you need to create ```/etc/init/enabled``` and ```/etc/init/disabled```. These directories needed by services.

### Commands set

- Show error journal:
```systemdjctl journal```

- Script for system's start(add this to /etc/inittab or something like this): 
```systemdjctl autorun```

- Start one from enabled services:
```systemdjctl start <service>```

- Stop one from started & running services:
```systemdjctl stop <service>```

- Add service from ```/etc/init/disabled/``` to ```/etc/init/enabled```:
```systemdjctl enable <service>```

- Remove service from ```/etc/init/enabled```
```systemdjctl disable <service>```

- Clear system logging journal:
```systemdjctl clearjr```

### What's working?

- [x] Autostarting services with other init first
- [x] Journaling
- [x] Starting services
- [x] Enabling services
- [x] Stopping services (paritally)
- [x] Disabling services (partially)

### Where it aim to be used?

In Underlevel OS, but it can be used in any Linux distribution(Android too because D supports it).
