FROM java:8-jdk

RUN apt-get update && apt-get install -y --no-install-recommends \
                build-essential maven ssh fabric expect zookeeper \
                && rm -rf /var/lib/apt/lists/*

ADD . /nbase-arc
WORKDIR /nbase-arc

RUN make release && cp -r release/nbase-arc $HOME

RUN cd /root/nbase-arc/mgmt/config && sed -i "s/IP = None/IP = \"0.0.0.0\"/" conf_mnode.py \
        && sed -i "s/PORT = None/PORT = 1122/" conf_mnode.py \
        && sed -i "s/MGMT_CONS = 3/MGMT_CONS = 1/" conf_mnode.py \
        && sed -i "s/USERNAME = None/USERNAME = \"$(whoami)\"/" conf_mnode.py \
        && sed -i "s/v1.2.5/$(ls -l ~/nbase-arc/bin/ | tail -1 | awk -F'-' '{print $6"-"$7"-"$8}')/" conf_dnode.py
RUN /usr/share/zookeeper/bin/zkServer.sh start
RUN cd /root/nbase-arc/confmaster && ./confmaster-v1.2.5-16-g45fd2b8.sh
RUN /etc/init.d/ssh start && ssh-keygen -f /root/.ssh/id_rsa -N "" && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

ENTRYPOINT ["/nbase-arc/entrypoint.sh"]
CMD /bin/sh -c "while true; do sleep 1; done"

