#!/usr/bin/env bash
LISTENING_DIRS=("after" "lua" "test")
CHANGE_REGEX="\.lua$"

WHITE_COLOR="\033[0;37m"
GREEN_COLOR="\033[0;32m"
RED_COLOR="\033[0;31m"
NO_COLOR="\033[0m"

run_test() {
  local full_file="$1"

  local file
  file=$(basename "$full_file")

  local dir
  dir=$(dirname "$full_file")
  
  pushd "$dir" > /dev/null || return
  lua "$file" -v | awk '{ gsub("^OK$", "\033[1;32m&\033[0m");
                          gsub("Ok$", "\033[1;32m&\033[0m");
                          gsub("^Failed tests:$", "\033[1;31m&\033[0m");
                          gsub("FAIL$", "\033[1;31m&\033[0m");
                          print }'

  popd > /dev/null || return
}

run_all_tests() {
  echo "Runnin tests..."
  find . -name "*_test.lua" | while read -r file; do {
    echo
    echo "Testing $file..."
    run_test "$file"
  }; done

  exit $?
}

listen() {
  echo "Listening..."
  when-changed -1 -r "${LISTENING_DIRS[@]}" -c "$0 %f"
}

print_usage() {
  echo "Usage: $0 [listen]"
}

on_change() {
  local full_file
  # shellcheck disable=SC2001
  full_file=$(echo "$1" | sed -E "s|(~)$||") # when-changed adds '~' to the filename.

  if ! echo "$full_file" | grep -E "$CHANGE_REGEX" > /dev/null; then
    exit 0
  fi

  local pwdp
  pwdp=$(pwd -P)

  local sed_expression="s|^$pwdp/||"
  local file
  file=$(echo "$full_file" | sed -E "$sed_expression")

  echo "File: $file"
  echo

  if echo "$file" | grep -E "^.+_test\.lua$" > /dev/null; then
    echo "Changed: $file. Running it."
    run_test "$file"
  else
    local base
    base=$(echo "$file" | sed -E "s|^(.+)\.lua$|\1|g")

    local dir
    dir=$(dirname "$file")

    local test_filename="${base}_test.lua"
    local test_file="test/$test_filename"

    if [[ -f "$test_file" ]]; then
      printf "${WHITE_COLOR}Changed: ${NO_COLOR}%s.\n" "$file"
      printf "${WHITE_COLOR}Running test: ${NO_COLOR}%s\n" "$test_file"
      run_test "$test_file"
    else
      echo "Test file: $test_file"
      echo "Changed: $file. No test found."
    fi
  fi

  exit 0
}

run() {
  if [[ $# == 0 ]]; then
    run_all_tests
  elif [[ $1 == "listen" ]]; then
    listen
  elif [[ $1 == "--help" ]]; then
    print_usage
    exit 1
  else
    on_change "$1"
  fi
}

run "$@"

