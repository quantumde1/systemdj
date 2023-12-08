module services.enable;

import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;

void enable(string service) {
	string[4] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
	status[2] = "[\033[0;33m WAIT \033[0m]";
	status[3] = "[\033[0;36m INFO \033[0m]";
	auto file = readText("/etc/init/disabled/"~service~".json");
    JSONValue pkgfile = parseJSON(file);
    auto deps = pkgfile["deps"].array;
	foreach (index, element; deps) {
		writeln(status[3], " Enabling service ", element.str);
		if ("/etc/init/disabled/"~element.str~".json".exists && !"/etc/init/enabled/"~element.str~".json".exists) {
			std.file.append("/etc/init/enabled/autostart", element.str~"\n");
			symlink("/etc/init/disabled/"~element.str~".json", "/etc/init/enabled/"~element.str~".json");
			if ("/etc/init/enabled/"~element.str~".json".exists) {
				writeln(status[0], " Successfully enabled ", element.str);
			}
			else if (!"/etc/init/enabled/"~element.str~".json".exists) {
				writeln(status[1], " Failed to enable ", service);
			}
		}
		else {
			writeln(status[1], " No such file or directory or service already enabled");
		}
	}
	writeln(status[3], " Enabling service ", service);
	if ("/etc/init/disabled"~service~".json".exists && !"/etc/init/enabled/"~service~".json".exists) {
		std.file.append("/etc/init/enabled/autostart", service~"\n");
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