module services.status;
import std.stdio;
import std.process;

void get_process_status(string service) {
	string[4] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
	status[2] = "[\033[0;33m WAIT \033[0m]";
	status[3] = "[\033[0;36m INFO \033[0m]";
    auto run = execute(service);
    auto stat = run.status;
    writeln(status[3], " Getting status of ", service);
    writeln(status[3], " Service status is ", stat);
}