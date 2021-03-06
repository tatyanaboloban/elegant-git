#!/usr/bin/env bats -ex

load addons-common
load addons-read
load addons-cd
load addons-fake

setup() {
    fake-pass git clone
    fake-pass git "clone https://github.com/extsoft/elegant-git.git"
    fake-pass git "elegant configure --local"
}

teardown() {
    clean-fake
}

@test "'clone': raise an error if cloneable URL isn't set" {
  check git-elegant clone
  [[ "${lines[0]}" =~ "Cloneable URL is not set"  ]]
}

@test "'clone': clone the repo" {
  check git-elegant clone https://github.com/extsoft/elegant-git.git
  [ "$status" -eq 0 ]
}
