module parse;

import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;
import std.datetime;
import core.time;

int parse_json(string filename) @safe {
	string[4] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
	status[2] = "[\033[0;33m WAIT \033[0m]";
	status[3] = "[\033[0;36m INFO \033[0m]";
	auto content = readText(filename);
	JSONValue j = parseJSON(content);
	auto respawn = j["respawn"].integer;
	respawn.to!int;
	auto name = j["name"].str;
	auto ps = executeShell(j["executable"].str);
	int x = 0;
	if (ps.status != 0) {
		writeln(status[2], " Waiting for start ", name);
		while (x < respawn) {
			x += 1;
			if (x == respawn) {
				auto ps_out = ps.output;
				writeln(status[1], " Error when starting process ", name);
				writeln(status[3], " Count of tries is ", x);
				writeln(status[3], " For logs, run init journal");
				SysTime dt = Clock.currTime();
				append("/var/log/init/log", status[3]~" service is "~filename~"\n");
				append("/var/log/init/log", status[3]~" "~dt.toString()~"\n");
				append("/var/log/init/log", ps_out~"\n");
				return 1;
			}
		}
	}
	else if (ps.status == 0) {
		writeln(status[0], " Successfully started ", name);
		return 0;
	}
	return 0;
}