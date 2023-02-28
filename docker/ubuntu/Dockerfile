FROM ubuntu:bionic
SHELL ["/bin/bash", "-i", "-c"] 
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update
RUN apt-get install -y git wget build-essential autotools-dev automake bison byacc
RUN apt-get install -y libpcre3 libpcre3-dev
RUN ln -s /usr/lib/x86_64-linux-gnu/libpcre.so /usr/lib/x86_64-linux-gnu/libpcre.so.1
# ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/


ENV CONDA_DIR /opt/conda
RUN wget -nc -q https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
RUN chmod +x Anaconda3-2022.10-Linux-x86_64.sh
RUN ./Anaconda3-2022.10-Linux-x86_64.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN mkdir -p ~/opensim-workspace/swig-source || true
WORKDIR ~/opensim-workspace/swig-source
RUN wget -nc -q --show-progress https://github.com/swig/swig/archive/refs/tags/rel-4.0.2.tar.gz
RUN tar xzf rel-4.0.2.tar.gz
WORKDIR ./swig-rel-4.0.2
RUN ./autogen.sh && ./configure --prefix=$HOME/swig --disable-ccache
RUN make && make -j4 install  

RUN git clone https://github.com/opensim-org/conda-opensim conda-opensim
WORKDIR ./conda-opensim
RUN conda build ./opensim
RUN mkdir /root/artifacts/
RUN cp /opt/conda/conda-bld/linux-64/opensim-4.4-py37np120.tar.bz2 /opt/conda/conda-bld/linux-64/opensim-4.4-py38np120.tar.bz2 /opt/conda/conda-bld/linux-64/opensim-4.4-py39np120.tar.bz2 /root/artifacts/

