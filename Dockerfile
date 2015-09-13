FROM debian:jessie
MAINTAINER antoniorossi <antoniorossi@outlook.com>

# antoniorossi/dropbox-supervisor

# env to override for daemon user if needed
ENV USER_ID 1001
ENV GROUP_ID 1001
ENV USER_PASSWORD password
ENV HOME /dbox

# Create service account and set permissions.
RUN groupadd --gid $GROUP_ID dropbox
RUN useradd -m -d $HOME -c "Dropbox Daemon Account" -g dropbox --uid $USER_ID dropbox
RUN chpasswd dropbox:$PASSWORD # need a password for user

# Download & install required applications
RUN apt-get update && apt-get install -y \
	curl \
	python \
	supervisor

# Install Dropbox
RUN curl -k -L "https://www.dropbox.com/download?plat=lnx.x86_64" | tar -xzf - -C /
ADD https://www.dropbox.com/download?dl=packages/dropbox.py /dropbox.py
RUN chmod +x /dropbox.py
# Make the main folder ".dropbox-dist" easy visible
RUN mv /.dropbox-dist /dropbox-dist

# Perform image clean up.
RUN apt-get -qqy autoclean

# Copy executables
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY run_once.sh /run_once.sh
RUN chmod +x run_once.sh
COPY dropbox-monitor.sh /dropbox-monitor.sh
RUN chmod +x dropbox-monitor.sh

# expose for lansync: to enable must run with --net='host'
EXPOSE 17500
# expose supervisor http server
EXPOSE 8000

# enabling both ephemeral and static mapping of the volume
VOLUME $HOME

# run
CMD ["sh","-c","/usr/bin/supervisord"]
