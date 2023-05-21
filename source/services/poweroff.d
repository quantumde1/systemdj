module services.poweroff;
 
 
 
import std.stdio;
import std.file;
import std.process;

void stop_all() {
    string[4] status;
    status[0] = "[\033[0;32m  OK  \033[0m]";
    status[1] = "[\033[0;31mFAILED\033[0m]";
    status[2] = "[\033[0;33m WAIT \033[0m]";
    status[3] = "[\033[0;36m INFO \033[0m]";
    writeln(status[3], " Shutdown PC now!");
    auto x = executeShell("/etc/init/enabled/poweroff.sh");
    writeln(x.output);
}