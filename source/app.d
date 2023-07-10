import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;
import parse;
import services.enable;
import services.start;
import services.disable;
import services.logging;
import services.autorun;
import services.stop;
import services.status;
import configure;
import services.poweroff;
import core.stdc.stdlib;

class NotEnoughException : Exception {
	this(string msg, string file = __FILE__, size_t line = __LINE__) {
		super(msg,file,line);
	}
}

void help() @safe {
	writeln("SystemDJ Init");
	writeln("For add service to autostart, run init enable <service>");
	writeln("For start service, run init start <service>");
	writeln("For remove service from autostart, run init disable <service>");
	writeln("For journal run init journal");
	writeln("For clear journal, run clearjr");
}

void main(string[] args) {
	switch (args[1]) {
		case "start":
			start(args[2]);
			break;
		case "enable":
			enable(args[2]);
			break;
		case "help":
			help();
			break;
		case "stop":
			kill_process(args[2]);
			break;
		case "disable":
			disable(args[2]);
			break;
		case "journal":
			read_log();
			break;
		case "clearjr":
			clear_log();
			break;
		case "autorun":
			exec_all();
			break;
		case "status":
			get_process_status(args[2]);
			break;
		case "conf":
			reconfigure_init();
			break;
		case "poweroff":
			stop_all();
			break;
		default:
			writeln("Sorry! No such command.");
	}
}