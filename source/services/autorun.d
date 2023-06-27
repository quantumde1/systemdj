module services.autorun;

import std.process;
import std.file;
import std.array;
import std.stdio;
import std.json;
import std.conv;
import std.algorithm;
import std.range;
import std.format;
import parse;

void exec_all() {
    writeln("[\033[0;36m INFO \033[0m]", " Starting services...");
    auto ps = executeShell();
    writeln(ps.output);
}

int pid_check() @safe {
    auto pid = thisProcessID();
    auto content = readText("/etc/init/conf/main.json");
	JSONValue j = parseJSON(content);
	auto distname = j["name"].str;
    auto pid_stat = 0;
    writeln("[\033[0;36m INFO \033[0m]", " Welcome to ", distname);
    pid_stat = 0;
    return pid_stat;
}