#!/bin/bash
##TouchOneClick xinput list && xinput list-props 12|grep Tapping && xinput set-prop 12 342 1

TID=$(xinput list|grep Touchpad|awk '{print $6}'|cut -f 2 -d "=")
TPROP=$(xinput list-props 12|grep Tapping\ Enabled\ \(|awk '{print $4}'|cut  -f 1 -d :|tr -d '('|tr -d ')')
echo xinput set-prop $TID $TPROP 1
xinput set-prop $TID $TPROP 1
