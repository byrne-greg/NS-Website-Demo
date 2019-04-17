#!/bin/bash

SITE_HOME=`dirname "$0"`
SITE_HOME=`cd "$SITE_HOME" && pwd`

if [ "$#" -ne 0 ]; then
  TARGET=$@
fi

$ANT_HOME/bin/ant -listener org.apache.tools.ant.XmlLogger -f $SITE_HOME/bin/build.xml -Dbasedir $SITE_HOME $TARGET
