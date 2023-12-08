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
import services.poweroff;
import core.stdc.stdlib;

void help() {
	writeln("systemDJ initialization system.\n\nsystemdjctl [COMMAND] [ARGS]\n\ncommands: start stop enable disable journal clearjr autorun poweroff\n\nas arguments use service name");
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
		case "poweroff":
			stop_all();
			break;
		default:
			writeln("No such command, try help");
			break;
	}
}