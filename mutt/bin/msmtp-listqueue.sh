#!/usr/bin/env bash

QUEUEDIR=$HOME/.mutt/msmtp_queues

for i in $QUEUEDIR/*.mail; do
	egrep -s --colour -h '(^From:|^To:|^Subject:)' "$i" || echo "No mail in queue";
	echo " "
done
