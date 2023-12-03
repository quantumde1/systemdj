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
import core.thread;


void exec_all() {
    string[3] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
    status[2] = "[\033[0;33m WAIT \033[0m]";
    auto fileContents = readText("/etc/init/enabled/autostart");

    if (!fileContents.length) {
        writeln(status[1], " Unable to read the file.");
        return;
    }

    auto lines = fileContents.splitter("\n").array();
    lines.sort();

    foreach_reverse (line; lines)
    {
        auto serviceFilePath = "/etc/init/enabled/" ~ line ~ ".json";
        if (exists(serviceFilePath)) {
            int isFunctionFinished;
            while (1) {
                int x = parse_json(serviceFilePath);
                if (x == 0 || x == 1) {
                    break;
                }
            }
        } else {
            writeln(status[1], " Service file not found ", serviceFilePath);
        }
    }
}