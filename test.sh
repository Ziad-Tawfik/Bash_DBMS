#!/bin/bash
select test in "a" "b"; do
  case $test in
    "a")
      echo "this is one"
      vagrant up
      ;;

      "b") echo $test":"
      ;;

      "c") ;;

    *)
      echo "Usage: $0 {start|stop|ssh}"
      ;;
  esac
done