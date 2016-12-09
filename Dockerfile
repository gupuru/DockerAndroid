FROM ubuntu:14.04

MAINTAINER Kohei Niimi <kohei.niimi@gupuru.com>

RUN apt-get update -y && apt-get upgrade -y && apt-get install git-core build-essential zip curl python-pip python-software-properties apt-file lib32z1 lib32gcc1 -y
RUN apt-file update -y
RUN apt-get install software-properties-common -y
RUN apt-add-repository ppa:brightbox/ruby-ng -y && dpkg --add-architecture i386 && apt-get update -y && apt-get install libncurses5:i386 libstdc++6:i386 zlib1g:i386 ruby2.3 ruby2.3-dev -y

RUN \
  apt-get install -y software-properties-common curl && \
  add-apt-repository -y ppa:openjdk-r/ppa && \
  apt-get update && \
  apt-get install -y openjdk-8-jdk

RUN cd /usr/local/ && curl -L -O http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar xf android-sdk_r24.4.1-linux.tgz && \
    echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force --all --filter "tools" && \
    echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force --all --filter "platform-tools, build-tools-25.0.1, build-tools-24.0.3, build-tools-23.0.3, android-23, android-24, android-25" && \
    echo y | /usr/local/android-sdk-linux/tools/android update sdk --no-ui --force --all --filter "extra-google-google_play_services, extra-google-m2repository, extra-android-m2repository, extra-android-support, addon-google_apis-google-23, addon-google_apis-google-24, addon-google_apis-google-25"

RUN cd /usr/local/ && curl -L -O https://services.gradle.org/distributions/gradle-2.14.1-all.zip && unzip -o gradle-2.14.1-all.zip

RUN gem install fastlane

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV GRADLE_HOME /usr/local/gradle-2.14.1
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_NDK_HOME
ENV PATH $PATH:$GRADLE_HOME/bin

RUN rm -rf /usr/local/android-sdk_r24.4.1-linux.tgz
