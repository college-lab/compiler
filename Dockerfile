FROM ubuntu:24.04

RUN apt update && \
    apt install -y flex bison build-essential && \
    apt clean

COPY . .

CMD ["/bin/bash"]
