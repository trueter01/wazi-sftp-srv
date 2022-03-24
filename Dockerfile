#RUN chgrp -R 0 /some/directory && \
#    chmod -R g=u /some/directory
#    ENTRYPOINT ["sleep", "100000000"]
    
FROM registry.access.redhat.com/ubi8/ubi:latest
ARG home=/home/sshuser
RUN yum -y update && \
    yum -y install openssh-server \
    openssh-clients && \
    /usr/bin/ssh-keygen -A && \
    groupadd sshgroup && \
    useradd -ms /bin/bash -g sshgroup sshuser && \
    echo 'sshuser:PASSWORD' | chpasswd && \
    mkdir $home/.ssh && \
    touch $home/.ssh/authorized_keys && \
    chown sshuser:sshgroup $home/.ssh/authorized_keys && \
    chmod 600 $home/.ssh/authorized_keys
EXPOSE 22
CMD /usr/sbin/sshd && sleep infinity
