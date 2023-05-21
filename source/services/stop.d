module services.stop;

import std.stdio;
import std.process;

void kill_process(string service) {
    string[2] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
    auto killservice = spawnProcess(["/usr/bin/killall", service]);
    if (wait(killservice) != 0) {
        writeln(status[1], " Failed to stop service ", service);
    }
    else {
        writeln(status[0], " Successfully stoped ", service);
    }
}