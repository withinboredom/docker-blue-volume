#!/bin/bash

function waitForLock() {
	craft=$1
	session=$(curl -X PUT -d '{"Name": "sync"}' http://localhost:8500/v1/session/create)
	session_id=$(echo $session | jq --raw-output ".ID")

	got_lock="false"

	while [ "$got_lock" == "false" ]
	do
		sleep 3
		got_lock=$(curl -X PUT -d '[restarting]' http://localhost:8500/v1/kv/sync/$craft?aquire=$session_id)
	done
}

function killSession() {
	craft=$1
	session_id=$2
	curl -X PUT http://localhost:8500/v1/kv/sync/$craft?release=$session_id
}

# we might need to restart, lets get the data
read payload

echo $payload > /data/vol

echo $payload | jq --raw-output ".[].Payload" > /data/payload
echo "{\"me\": \"$VOL\"}" | jq --raw-output ".me | @base64" > /data/me

me=$(cat /data/me)
vol=$(cat /data/payload)

if [ "$me" == "$vol" ]
then

	waitForLock configure
	configure_id=$session_id

	touch /data/waiting_for_lock
	waitForLock restart
	restart_id=$session_id
	rm /data/waiting_for_lock
	touch /data/has_lock

	syncthing-cli restart

	killSession restart $restart_id
	killSession configure $configure_id
	rm /data/has_lock
	touch /data/restarted
fi