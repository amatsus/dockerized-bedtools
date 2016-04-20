FROM docker.io/centos:7
MAINTAINER Akihiro Matsushima <amatsusbit@gmail.com>

ENV PATH=/opt/bedtools-2.25.0_centos7/bin:$PATH

RUN yum -y update && \
    yum -y install gcc-c++ libstdc++-static make zlib-devel zlib-static && \
    bash -c "tar zxf <(curl -L https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz) -C /tmp" && \
    cd /tmp/bedtools2 && \
    make install CPPFLAGS="-static-libstdc++" LIBS="/lib64/libz.a" \
        prefix=/opt/bedtools-2.25.0_centos7 && \
    rm -rf /tmp/bedtools2 && \
    curl -Lo /usr/local/bin/run_wrapper.py \
        https://raw.githubusercontent.com/gifford-lab/docker_signal_wrapper/master/run_wrapper.py && \
    chmod +x /usr/local/bin/run_wrapper.py

ENTRYPOINT [ "/usr/local/bin/run_wrapper.py", "/opt/bedtools-2.25.0_centos7/bin/bedtools" ]
CMD ["--help"]
