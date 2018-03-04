#!/bin/sh

$@ &
pid=$!
read cmd
kill $pid
