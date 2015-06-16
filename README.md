Part of the Monk Suite

# Blue Volume

BV is an answer to distributed storage. Instead of using NFS, Ceph, or those other guys, this uses syncthing -- a bittorrent inspired file syncronizer.

# How to use it

Start up like any other image in this suite.

# Image Specific Environment variables

- SYNCTHING_VERSION: v0.11.8
 - read only; the version of syncthing in the image
- SYNCTHING_CLI_VERSION: unknown
 - read only; the version of the cli
- FILEWATCH_VERSION; v0.6.4
 - read only; the version of the inode watcher
- VOL; default
 - The name of the volume; must be unique per mount point
- STENDPOINT; "http://127.0.0.1:8080"
 - API Endpoint; should never have to change
- ALLOW_GLOBAL: "false"
 - If false, you'll need to start up withinboredom/blue-volume-discover
- VOL_LOCATION: "/data/Sync"
 - use in conjuction with --volume-from