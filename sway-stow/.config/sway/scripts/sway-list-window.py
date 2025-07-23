#!/bin/python3
# This script gets the list of all current windows and shows them on wofi
# The selected window get's focused.
import subprocess
from collections.abc import Iterable

from i3ipc import Connection, Con

def format_str(s: str, amount: int) -> str:
    resp = f'{s[:amount]:<{amount}}'
    return resp


def window_descriptor(window: Con) -> str:
    '''Returns a descriptor string that describes the window to display to the user'''
    window_instance = f'{ window.window_instance if window.window_instance is not None else ""}'
    window_class = f'{ window.window_class if window.window_class is not None else ""}'
    desc = f'{format_str(window_class, 15)} {format_str(window_instance, 15)} {format_str(window.name,30)}'
    # print(len(desc))
    return desc

def get_windows(conn: Connection) -> dict[str,Con]:
    '''Given a sway connection object, return the current windows infromation
    return: Dictionary with window id as key'''
    containers = conn.get_tree().descendants()
    containers = filter(lambda x: x.type in ['con', 'floating_con'], containers)
    windows: list[Con] = []

    for con in containers:
        print(type(con))
        # con.window_instance
        windows.append(window_crawl(con))

    return {window_descriptor(w): w for w in windows}
    
def window_crawl(con: Con) -> Con:
    '''Recursively get containers without descendants e.g windows'''
    # TODO: This function is unneccesary the library provides two functions
    # leaves() and scratchpad() that could accomplish this.
    for x in con.descendants():
        return window_crawl(x)
    return con

def wofi(options: Iterable[str]):
    '''Calls wofi in dmenu mode with the given selection options
   
        It returns the selection
    '''
    return subprocess.check_output(['wofi','-i', '-k', '/dev/null', '-d'],
            input='\n'.join(options), encoding='UTF-8').strip('\n')

def rofi(options: Iterable[str]):
    '''Calls rofi in dmenu mode with the given selection options
   
        It returns the selection
    '''
    return subprocess.check_output(['rofi','-dmenu', '-markup-rows'],
            input='\n'.join(options), encoding='UTF-8').strip('\n')

if __name__ == "__main__":
    sway = Connection()
    windows = get_windows(sway)
    for key in windows.keys():
        print(key)
    # print()
    result = rofi(windows.keys())
    window = windows[result]
    window.command('focus')
