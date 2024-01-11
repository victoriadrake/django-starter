#!/bin/bash
#
# Django Starter set up script
#

echo
echo "I'll help you get Django ready! Let's start the set up! ^_^"
echo

echo "Checking for Python version..."
pyver=$(python -c 'import sys; version=sys.version_info[:3]; print("{0}.{1}".format(*version))')
if [[ "$pyver" != "3.12" ]]; then
  echo "You don't appear to have Python 3.12.x installed. Run 'make pyenv-install' if you'd like help with this." && exit 1
else
  echo "Ok, Python 3.12 found."
fi
echo

echo "Checking pip..."
pipver=$(pip -V)
if [[ -z "$pipver" ]]; then
  echo "I need pip in order to continue! Run 'make get-pip' if you'd like help with this." && exit 1
else
  echo "Ok, pip is installed!"
fi
echo

echo "Installing Django for you in a virtual environment..."
make get-pip
make get-pipenv
make get-django
echo

echo "Ok, you have Django now! ヽ(' ∇' )ノ"
echo "Run 'make install' if you want to get all the dependencies in the Pipfile."
