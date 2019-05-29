FROM land007/debian:latest

MAINTAINER Jia Yiqiu <jiayiqiu@eyecool.cn>

RUN apt-get install -y libfontconfig1 libfreetype6 libice6 libsm6
ADD codemeter_6.70.3152.500_amd64.deb /tmp
RUN dpkg -i /tmp/codemeter_6.70.3152.500_amd64.deb && rm -f /tmp/codemeter_6.70.3152.500_amd64.deb
RUN service codemeter start && service codemeter status && cmu -l

ADD netcert.sh /
RUN sed -i 's/\r$//' /netcert.sh
RUN chmod a+x /netcert.sh

ENV CodeMeter_Server 192.168.86.8

RUN echo $(date "+%Y-%m-%d_%H:%M:%S") >> /.image_times
RUN echo $(date "+%Y-%m-%d_%H:%M:%S") > /.image_time
RUN echo "land007/debian-codemeter" >> /.image_names
RUN echo "land007/debian-codemeter" > /.image_name

#CMD /netcert.sh; /etc/init.d/ssh start; bash
RUN echo "/netcert.sh" >> /start.sh

#docker stop debian-codemeter ; docker rm debian-codemeter ; docker run -it -p 20122:20022  -e "CodeMeter_Server=192.168.86.8" --privileged --name debian-codemeter land007/debian-codemeter:latest
#docker stop debian-codemeter ; docker rm debian-codemeter ; docker run -it -p 20122:20022 -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 -p 3004:3004 -p 3005:3005 -p 3006:3006 -p 3007:3007 -p 3008:3008 -p 3009:3009  -e "CodeMeter_Server=192.168.86.8" --privileged --name debian-codemeter land007/debian-codemeter:latest
