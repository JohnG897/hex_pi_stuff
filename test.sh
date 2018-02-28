#!/bin/bash
$log_file="test.txt"
echo The thing is starting
echo testing | tee $log_file
echo The thing has finished
