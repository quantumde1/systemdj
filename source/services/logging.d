module services.logging;

import std.file;
import std.stdio;

void read_log() @safe {
    auto content = readText("/var/log/init/log");
    writeln(content);
}

void clear_log() @safe {
    	auto path = "/var/log/init/log";
        path.remove;
		writeln("[\033[0;36m INFO \033[0m]", " Log removed");
}