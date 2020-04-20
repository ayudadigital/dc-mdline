FROM node:13.12.0-stretch-slim

RUN npm install -g mdline

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/workspace"]
WORKDIR /workspace
ENTRYPOINT ["/entrypoint.sh"]
