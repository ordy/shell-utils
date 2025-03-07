#!/bin/bash
cd /opt/spotify/Apps/xpui/
cp xpui.js xpui.js.bak # create the backup
sed -i 's/adsEnabled:\!0/adsEnabled:false/' xpui.js
