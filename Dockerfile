FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /works
RUN apt-get update

# install C
RUN apt-get install -y wget gnupg1
RUN apt-get install musl-dev -y
RUN apt-get install build-essential -y
RUN apt-get install cmake -y 

# install boost
RUN apt-get install git -y
RUN apt install libboost-all-dev -y
RUN apt install aptitude -y
RUN aptitude search boost

# libtorrent 
RUN apt-get install ninja-build -y 
COPY ./res/libtorrent /works/libtorrent
WORKDIR /works/libtorrent/build
#RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=11 -G Ninja ..
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=14 -G Ninja ..
RUN ninja -j8
RUN ninja install


# mkdir build
# cd build
# cmake ..
# make
# make install


# install code-server
WORKDIR /works
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sSOL https://github.com/cdr/code-server/releases/download/v3.4.1/code-server_3.4.1_amd64.deb
RUN dpkg -i code-server_3.4.1_amd64.deb

## install vscode plugin
RUN code-server --install-extension Dart-Code.dart-code
RUN code-server --install-extension ms-vscode.cpptools

CMD ["code-server", "--auth","none", "--host","0.0.0.0","--port","8443", "/app"]