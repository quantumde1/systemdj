import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;
import parse;
import services.autorun;
import services.poweroff;
import core.stdc.stdlib;
import std.exception;
import std.array;
import core.sys.posix.sys.types;
import core.sys.posix.unistd;

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
        auto p = spawnProcess("getty 38400 tty1");
        p.wait();
        writeln("getty exited, restarting...");
    }
}