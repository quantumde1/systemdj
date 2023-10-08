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
    auto ps = executeShell("/etc/init/enabled/autostart.sh");
    writeln(ps.output);
}