module services.disable;

import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;
import std.array;

void removeStringFromFile(string filePath, string stringToRemove) {
    auto fileContent = cast(string)read(filePath);
    fileContent = fileContent.replace(stringToRemove, "");
    std.file.write(filePath, fileContent);
}

void disable(string service) {
    string[4] status;
	status[0] = "[\033[0;32m  OK  \033[0m]";
	status[1] = "[\033[0;31mFAILED\033[0m]";
	status[2] = "[\033[0;33m WAIT \033[0m]";
	status[3] = "[\033[0;36m INFO \033[0m]";
    writeln(status[3], " Disabling service ", service);
    auto path = "/etc/init/enabled/"~service~".json";
    path.remove;
    removeStringFromFile("/etc/init/enabled/autostart.sh", "systemdjctl start "~service~"\n");
    if (!path.exists) {
        writeln(status[0], " Successfully disabled ", service);
    }
    if (path.exists) {
        writeln(status[1] , " Failed to disable ", service);
    }
}