#!/usr/bin/env python3
import subprocess
import re
import sys

def parse_slurp(slurp_str):
    """Parse slurp geometry string: WIDTHxHEIGHT+X+Y"""
    match = re.match(r'(\d+),(\d+)\W(\d+)x(\d+)', slurp_str)
    if not match:
        raise ValueError(f"Invalid slurp format: {slurp_str}")
    return map(int, match.groups())

def crop_video(input_file, output_file, slurp_geometry, fps=5):
    x, y, width, height  = parse_slurp(slurp_geometry)
    
    cmd = [
        'ffmpeg',
        '-i', input_file,
        '-vf', f'crop={width}:{height}:{x}:{y},fps={fps}',
        '-c:a', 'aac',
        '-b:a', '128k',
        output_file
    ]
    
    print(f"Executing: {' '.join(cmd)}")
    subprocess.run(cmd, check=True)

if __name__ == '__main__':
    if len(sys.argv) < 4:
        print("Usage: crop-video.sh <input> <output> <slurp_geometry>")
        print("Example: crop-video.sh input.mp4 output.mp4 1280x720 100x50")
        sys.exit(1)
    
    crop_video(sys.argv[1], sys.argv[2], sys.argv[3])
