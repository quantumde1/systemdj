module services.enable;

import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;

void enable(string service) @safe {
	string[4] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
	status[2] = "[\033[0;33m WAIT \033[0m]";
	status[3] = "[\033[0;36m INFO \033[0m]";
	writeln(status[3], " Enabling service ", service);
	if ("/etc/init/disabled"~service~".json".exists) {
		std.file.append("/etc/init/enabled/autostart.sh", "systemdjctl start "~service~"\n");
		std.file.append("/etc/init/enabled/poweroff.sh", "systemdjctl stop "~service~"\n");
		symlink("/etc/init/disabled/"~service~".json", "/etc/init/enabled/"~service~".json");
		if ("/etc/init/enabled/"~service~".json".exists) {
			writeln(status[0], " Successfully enabled ", service);
		}
		else if (!"/etc/init/enabled/"~service~".json".exists) {
			writeln(status[1], " Failed to enable ", service);
		}
	}
	else {
		writeln(status[1], " No such file or directory");
	}
}
