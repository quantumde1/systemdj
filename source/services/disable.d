module services.disable;

import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;

void disable(string service) @safe {
    string[4] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
	status[2] = "[\033[0;33m WAIT \033[0m]";
	status[3] = "[\033[0;36m INFO \033[0m]";
    writeln(status[3], " Disabling service ", service);
    auto path = "/etc/init/enabled/"~service~".json";
    path.remove;
    if (!path.exists) {
        writeln(status[0], " Successfully disabled ", service);
    }
    if (path.exists) {
        writeln(status[1] , " Failed to disable ", service);
    }
}