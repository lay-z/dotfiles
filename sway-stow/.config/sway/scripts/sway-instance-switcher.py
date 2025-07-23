import argparse
from i3ipc import Connection, Con, CommandReply
import subprocess
import os
import shutil

pathlist = ["/home/layz/bin"]

os.environ["PATH"] += os.pathsep + os.pathsep.join(pathlist)


parser = argparse.ArgumentParser(description='Switch to running instance of program or create if it doesnt yet exist')
parser.add_argument('window_class', type=str,
                    help='class name of the program to switch too')

parser.add_argument('window_instance', type=str,
                    help='window instance of the program to switch too')

parser.add_argument('program', type=str,
                    help='application binary to launch if program instance is not running')

args = parser.parse_args()

def notify(title: str, body: str, urgency: str = "normal") -> str:
    return subprocess.check_output(['notify-send', title, body, "-u", urgency], encoding="UTF-8").strip('\n')

def urgent_notify(title: str, body: str) -> str:
    return notify(title, body, "critical")

def get_absolute_path(program: str) -> str | None:
    return shutil.which(program)

def main():
    sway = Connection()
    windows = sway.get_tree()
    window_classes = windows.find_classed(args.window_class)
    if window_classes:
        for window in window_classes:
            print(window.window_instance)
            if window.window_instance == args.window_instance:
                resp = window.command('focus')
                if not resp[0].success:
                    notify("Error", f"Failed to start {args.program}")
                return
                    

    # resp = sway.command(f"exec nothing")
    print(f"exec {args.program}")
    program = get_absolute_path(args.program) 
    if not program:
        urgent_notify("Error", "Could not find program in path. Is path configured correctly, or program installed?")
        return

    resp = sway.command(f"exec {program}")
    if resp:
        print(resp[0].success)
        print(resp[0].error)
        print(resp[0].ipc_data)
        if resp[0].success:
            notify("Success", f"Started {args.program}")
        else:
            urgent_notify("Failed", f"Could not start {args.program}. Error: {resp[0].error}")


if __name__ == "__main__":
    main()
