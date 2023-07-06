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

void parse_list() {
	auto content = readText("/etc/init/enabled/services.json");
	JSONValue j = parseJSON(content);
	auto num = j["number"].integer;
	for (int i = 0; i <= num; i++) {
		auto services = j["service"~num.to!string].str;
		writeln("Service №", num, ": ", services);
		num = num - num + 1;
	}
}