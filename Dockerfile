FROM oznu/guacamole

RUN apt-get update \
 && apt-get install -y xterm git python3 python3-pyqt4 dwm tightvncserver \
 && groupadd leouser \
 && useradd -g leouser leouser \
 && mkdir /home/leouser \
 && chown leouser.leouser /home/leouser

USER leouser
ENV USER leouser
RUN echo only1234\\nonly1234 | vncpasswd \
 && git clone --depth 1 https://github.com/leo-editor/leo-editor.git /home/leouser/leo-editor
USER root

COPY setup.sql setup.sh /setup/
RUN chmod +x /setup/setup.sh
# calls original entry point
ENTRYPOINT ["/setup/setup.sh"]

