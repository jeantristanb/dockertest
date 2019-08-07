FROM ubuntu:18.04
ENV PYTHONNOUSERSITE 1 
ENV plinksrc "plink_linux_x86_64_20190617.zip"
ENV gwamasrc "GWAMA_v2.2.2.zip"
ENV metalsrc "generic-metal-2011-03-25.tar.gz"
ENV mrmegasrc "MR-MEGA_v0.1.5.zip"
RUN apt update &&  apt install -y wget gcc g++ unzip make zlib1g-dev vim default-jre python3 python3-pip #zlib-dev
RUN wget http://s3.amazonaws.com/plink1-assets/$plinksrc && unzip $plinksrc -d /usr/local/bin/ && \
rm $plinksrc /usr/local/bin/toy.ped /usr/local/bin/toy.map /usr/local/bin/LICENSE && \
chmod a+x /usr/local/bin/plink
## GWAMMA installation 
RUN mkdir /usr/local/src/gwama && wget http://www.geenivaramu.ee/tools/$gwamasrc && unzip $gwamasrc -d /usr/local/src/gwama/ && \
cd usr/local/src/gwama/ && make  && mv GWAMA /usr/local/bin/ && rm /$gwamasrc 
## Metal installation
RUN mkdir /usr/local/src/METAL && cd /usr/local/src/METAL && wget http://csg.sph.umich.edu/abecasis/metal/download/$metalsrc && tar -xzf $metalsrc  && cd generic-metal/ && make all && cp executables/metal /usr/local/bin/
## MR-MEGA installation
RUN mkdir /usr/local/src/MRMEGA/ && cd /usr/local/src/MRMEGA/ && wget http://www.geenivaramu.ee/tools/$mrmegasrc && unzip $mrmegasrc && make &&cp MR-MEGA /usr/local/bin/
RUN cd /usr/local/bin/ && wget http://genetics.cs.ucla.edu/meta_jemdoc/repository/2.0.1/Metasoft.zip && unzip  Metasoft.zip  
RUN pip3 install numpy scipy matplotlib pandas scikit-learn==0.19.1 sympy nose 
