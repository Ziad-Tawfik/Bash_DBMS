#!/bin/bash

case "$1" in
  start | up)
    echo "this is one"
    vagrant up
    ;;

    2) echo "this is 2"
    ;;

    3) ;;

  *)
    echo "Usage: $0 {start|stop|ssh}"
    ;;
esac