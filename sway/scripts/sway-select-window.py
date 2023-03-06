import subprocess
from collections.abc import Iterable
import json


def trim(string: str, max_length: int):
    if max_length:
        return string[:max_length]+'...' if len(string) > max_length else string

class WindowDescriptor:
    _class: str
    instance: str
    title: str
    pid: int
    id: int
    focused: bool
    name: str

    def __init__(self: "WindowDescriptor", window: dict):
        self._class = window.get("window_properties", {}).get("class", "")
        self.instance = window.get("window_properties", {}).get("instance", "")
        self.title = window.get("window_properties", {}).get("title", "")
        self.pid = window.get("pid", 0)
        self.id = window.get("id", 0)
        self.focused = window.get("focused", False)
        self.name = window.get("name", "")

    def __repr__(self) -> str:
        return f"{{class: {self._class} instance: {self.instance} title: {self.title} pid: {self.pid} id: {self.id} focused: {self.focused} name: {self.name}}}"

    def to_wofi_output_str(self) -> str:
        return f"{trim(str(self.id), 7):<7}{trim(self._class, 15):<20}{trim(self.instance, 20):<20}{ trim(self.name, 20):<20}"


def flatten_array(arr):
    """
    Recursively flatten a nested array.
    """
    result = []
    for element in arr:
        if isinstance(element, list):
            result.extend(flatten_array(element))
        elif "nodes" in element and len(element["nodes"]) > 0:
            result.extend(flatten_array(element["nodes"]))
        else:
            result.append(element)
    return result


def wofi(options: Iterable[str]):
    '''Calls rofi in dmenu mode with the given selection options
   
        It returns the selection
    '''
    return subprocess.check_output(['wofi','-I', '-G', '-a', '-k', '/dev/null', '-d'],
            input='\n'.join(options), encoding='UTF-8').strip('\n')


def get_id(wofi_ouput: str) -> int:
    return int(wofi_ouput.split(' ')[0].strip())


def switch_to_window(id: int):
    return subprocess.run(f"swaymsg '[con_id={id}]' focus", shell=True)
#     

def main():
    result = subprocess.run("swaymsg -t get_tree", capture_output=True, shell=True)


    tree: dict = json.loads(result.stdout.decode('utf-8'))


    all_nodes = flatten_array(tree["nodes"])
    windows = list(map(lambda x: WindowDescriptor(x), all_nodes))

    output = map(lambda x: x.to_wofi_output_str(), filter(lambda x: x.name != "__i3_scratch", windows))

    new_window = wofi(output)

    print(switch_to_window(get_id(new_window)))

if __name__ == "__main__":
    main()
