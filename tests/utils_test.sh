#!/bin/bash

. ./tests/utils --source-only
. ./src/utils.sh --source-only

function suite
{
  suite_addTest "testHelp"
  suite_addTest "testSearch"
}

function testHelp
{
  HELP_OUTPUT=$(kworkflow-help | head -n 1)
  [[ $HELP_OUTPUT =~ Usage:\ kw.* ]]; assertTrue "Help text not displaying correctly." $?
}

SMP_PATH="./tests/samples/"
MSG_OUT="${SMP_PATH}search.txt:70:to apologize to the people that my personal behavior\
 hurt and possibly drove"
LOG_OUT="Initial commit"

function testSearch
{
  assertEquals "Expected an error message." "Expected path or 'log'" "$(search)"
  assertEquals "$MSG_OUT" "$MSG_OUT" "$(search apologize | grep ${SMP_PATH}search.txt)"
  assertEquals "$MSG_OUT" "$MSG_OUT" "$(search $SMP_PATH apologize | grep ${SMP_PATH}search.txt)"
  assertEquals "$LOG_OUT" "$LOG_OUT" "$(search log "$LOG_OUT" | awk '{print $2, $3}')"
}

invoke_shunit
