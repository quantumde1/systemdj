module configure;

import std.json;
import std.stdio;
import std.file;

void reconfigure_init() {
    string[4] status;
	status[0] = "[\033[0;32m  OK  \033[0m] ";
	status[1] = "[\033[0;31mFAILED\033[0m] ";
	status[2] = "[\033[0;33m WAIT \033[0m] ";
	status[3] = "[\033[0;36m INFO \033[0m] ";
	auto content = readText("/etc/init/conf/main.json");
	JSONValue j = parseJSON(content);
	auto loglevel = j["loglevel"].integer;
    auto parallel = j["parallel"].boolean;
    auto os = j["name"].str;
    writeln(status[3], "Config is:");
    writeln(status[3], "Loglevel is ", loglevel);
    writeln(status[3], "Parallel is ", parallel);
    writeln(status[3], "System name is ", os);
    
}