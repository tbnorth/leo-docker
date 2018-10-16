#!/bin/sh
/init &
# wait for guacamole to start before we continue
sleep 15
# insert default connection info. into guacamole DB
su postgres -c psql < /setup/setup.sql
su leouser -c "vncserver -geometry 1280x1024"
DISPLAY=:1 su leouser -c "cd && python3 /home/leouser/leo-editor/launchLeo.py"

