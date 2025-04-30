#!/usr/bin/env fish

set -x PYENV_PYTHON "$HOME/.pyenv/versions/3.11.8/bin/python"
set -x PYTHONPATH "/opt/ros/humble/lib/python3.11/site-packages" $PYTHONPATH
set -x LD_LIBRARY_PATH "/opt/ros/humble/lib" $LD_LIBRARY_PATH
set -x PATH "/opt/ros/humble/bin" $PATH

exec $PYENV_PYTHON /opt/ros/humble/bin/ros2 $argv

