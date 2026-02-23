import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;
import parse;
import services.autorun;
import core.stdc.stdlib;
import std.exception;
import std.array;
import core.sys.posix.sys.types;
import core.sys.posix.unistd;

pid_t waitpid(pid_t pid, int *status, int options);

void main()
{
    if (getpid() != 1) {
        writeln("Run as 1 process, aka init");
        exit(1);
    }
    writeln("Starting initialization!");
    exec_all();
    while (true)
    {
        if ("/etc/init/getty".exists) {
            auto p = spawnProcess([readText("/etc/init/getty"), "38400", "tty1"]);
        }
        else {
            auto p = spawnProcess(["getty", "38400", "tty1"]);
        }
        while (waitpid(-1, null, 1) > 0) {
            writeln("we're in waitpid!")
        }
        sleep(10);
    }
}