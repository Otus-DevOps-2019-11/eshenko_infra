#!/bin/bash
set -e

apt -y update
apt -y upgrade
apt install -y ruby-full ruby-bundler build-essential
