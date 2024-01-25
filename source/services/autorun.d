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
    string[3] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
    status[2] = "[\033[0;33m WAIT \033[0m]";
    auto fileContents = File("/etc/init/enabled/autostart");
    if ("/var/log/init/".exists) {
        writeln(status[0], " Log directory exists");
    }
    else {
        writeln(status[2], " Log directory not exists, creating first");
        mkdir("/var/log/init/");
    }
    foreach (line; fileContents.byLine())
    {
        auto serviceFilePath = "/etc/init/enabled/" ~ line ~ ".json";
        if (exists(serviceFilePath)) {
            parse_json(serviceFilePath.to!string);
        } else {
            writeln(status[1], " Service file not found ", serviceFilePath);
        }
    }
}