#!/usr/bin/env python3
import os

CONFIG_DIR_FILENAME = ".config_dir"

# files (links, actually) inside (real) config_dir will point to (git) repo_dir's files
def handle_subdir(repo_dir, config_dir):
    subdirs = [f.name for f in os.scandir(repo_dir) if f.is_dir()]
    files = [f.name for f in os.scandir(repo_dir) if f.is_file() and f.name != CONFIG_DIR_FILENAME]

    for subdir in subdirs:
        config_subdir, repo_subdir = os.path.join(config_dir, subdir), os.path.join(repo_dir, subdir)
        if not os.path.exists(config_subdir):
            os.makedirs(config_subdir)

        handle_subdir(repo_subdir, config_subdir)

    for file in files:
        if not os.path.exists(os.path.join(config_dir, file)):
            os.symlink(os.path.join(repo_dir, file), os.path.join(config_dir, file))

def main():
    subdirs = [f.path for f in os.scandir(os.getcwd()) if f.is_dir()]

    for subdir in subdirs:
        CONFIG_DIR_FILEPATH = os.path.join(subdir, CONFIG_DIR_FILENAME)
        if not os.path.isfile(CONFIG_DIR_FILEPATH):
            continue

        with open(CONFIG_DIR_FILEPATH, 'r') as f:
             config_dir = f.readline()

        # remove trailing newline
        config_dir = config_dir[:-1]
        # resolve bash variables
        config_dir = os.path.expandvars(config_dir)

        if not os.path.exists(config_dir):
            os.makedirs(config_dir)

        handle_subdir(subdir, config_dir)

if __name__ == '__main__':
    main()
