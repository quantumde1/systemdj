module services.supervisor;

import std.process;
import std.stdio;
import std.conv;
import core.sys.posix.unistd;
import core.sys.posix.sys.wait;

void supervisor(string[] args) {
    // Daemonize the process
    pid_t supervisor_pid = fork();
    if (supervisor_pid == -1) {
        writeln("Failed to fork.");
        return;
    } else if (supervisor_pid > 0) {
        // Exit the parent process
        return;
    }

    // Create a new session
    setsid();

    // Change the working directory to root
    chdir("/");

    // Redirect standard file descriptors
    File devNull = File("/dev/null", "r+");
    stdin = devNull;
    stdout = devNull;
    stderr = devNull;

    // Continue with the existing supervisor logic
    string command = args[0];
    string[] commandArgs = args[0..$];
    while (true) {
        pid_t pid = fork();
        if (pid == -1) {
            writeln("Failed to fork.");
            break;
        } else if (pid == 0) {
            // Child process
            execv(command, commandArgs);
            writeln("Failed to execute command.");
            _exit(1);
        } else {
            // Parent process
            int status;
            waitpid(pid, &status, 0);
            writeln("Child process terminated with status: ", status);

            if (WIFEXITED(status)) {
                int exitCode = WEXITSTATUS(status);
                writeln("Process exited with code: ", exitCode);
                if (exitCode == 0) {
                    // Normal exit, no need to restart
                    break;
                }
            }

            writeln("Restarting process...");
            sleep(1); // Prevent rapid restart loop
        }
    }
}