module services.start;

import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;
import parse;
void start(string service) {
	auto path = "/etc/init/enabled/"~service~".json";
	string[2] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
	if (path.exists) {
		path.parse_json;
	}
	else {
		writeln(status[1]," No such file or directory");
	}
}