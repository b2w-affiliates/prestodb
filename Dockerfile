FROM java:8-jdk

RUN apt-get update -y
RUN apt-get install -y python-pip python-dev python3-dev


WORKDIR /opt/
RUN wget https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.149/presto-server-0.149.tar.gz
RUN tar -zxf presto-server-0.149.tar.gz

RUN mkdir data
RUN mkdir presto-server-0.149/etc
RUN mkdir presto-server-0.149/etc/catalog

RUN echo '\n\
node.environment = production\n\
node.id = ffffffff-ffff-ffff-ffff-ffffffffffff\n\
node.data-dir = data' > presto-server-0.149/etc/node.properties

RUN echo '-server\n\
-Xmx16G\n\
-XX:+UseG1GC\n\
-XX:G1HeapRegionSize=32M\n\
-XX:+UseGCOverheadLimit\n\
-XX:+ExplicitGCInvokesConcurrent\n\
-XX:+HeapDumpOnOutOfMemoryError\n\
-XX:OnOutOfMemoryError=kill -9 %p\n\
' > presto-server-0.149/etc/jvm.config

RUN echo '\n\
coordinator = true\n\
node-scheduler.include-coordinator = true\n\
http-server.http.port = 8080\n\
query.max-memory = 5GB\n\
query.max-memory-per-node = 1GB\n\
discovery-server.enabled = true\n\
discovery.uri = http://localhost:8080\n\
' > presto-server-0.149/etc/config.properties

# ENTRYPOINT ["./presto-server-0.149/bin/launcher", "run" ]
ENTRYPOINT ["bash" ]
