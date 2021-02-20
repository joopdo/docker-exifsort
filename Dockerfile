FROM alpine:3.10.5
COPY ./exifsort /tmp/
WORKDIR /tmp/
MAINTAINER Joop D

ENV UC_VERSION=0.62
ENV INC_VERSION=0.500
ENV EXIFTOOL_VERSION=10.20
ENV FILEUTIL_VERSION=4.201720
ENV PBUILD=0.4231
ENV TNW_VERSION=1.04
RUN apk add --no-cache gcc make
RUN apk add --no-cache  perl-unicode-normalize make
RUN apk add --no-cache build-base
#RUN apk add --no-cache perl-image-exiftool make
RUN apk add --no-cache perl make
RUN apk add --no-cache perl-try-tiny make
RUN apk add --no-cache perl-mime-types make
RUN apk add --no-cache perl-dev
RUN apk add --no-cache sudo
RUN chmod +x /tmp/exifsort
RUN cd /tmp \

	&& wget https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/inc-latest-${INC_VERSION}.tar.gz \
        && tar -zxvf inc-latest-${INC_VERSION}.tar.gz \
        && cd inc-latest-${INC_VERSION} \
        && perl Makefile.PL \  
        && make install \
        && cd .. \        

        && wget https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-${PBUILD}.tar.gz \
        && tar -zxvf Module-Build-${PBUILD}.tar.gz \
        && cd Module-Build-${PBUILD} \
        && perl Build.PL \
        && ./Build \
        && ./Build test \
        && ./Build install \
	&& cd .. \

        && wget https://cpan.metacpan.org/authors/id/A/AD/ADAMK/Test-NoWarnings-${TNW_VERSION}.tar.gz \
        && tar -zxvf Test-NoWarnings-${TNW_VERSION}.tar.gz \
        && cd Test-NoWarnings-${TNW_VERSION} \
        && perl Makefile.PL \
        && make install \
        && cd .. \

        && wget https://cpan.metacpan.org/authors/id/C/CH/CHANSEN/Unicode-UTF8-${UC_VERSION}.tar.gz \
        && tar -zxvf Unicode-UTF8-${UC_VERSION}.tar.gz \                                  
        && cd Unicode-UTF8-${UC_VERSION} \                                                
        && perl Makefile.PL \                                                                 
        && make install \    
        && cd .. \

	&& wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
	&& tar -zxvf Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
	&& cd Image-ExifTool-${EXIFTOOL_VERSION} \
	&& perl Makefile.PL \
	&& make test \
	&& make install \
	&& cd .. \
	&& rm -rf Image-ExifTool-${EXIFTOOL_VERSION} \

        && wget https://cpan.metacpan.org/authors/id/T/TO/TOMMY/File-Util-${FILEUTIL_VERSION}.tar.gz \
        && tar -xzvf File-Util-${FILEUTIL_VERSION}.tar.gz \
        && cd File-Util-${FILEUTIL_VERSION} \
        && perl Build.PL \
        && perl Build \
        && perl Build test \
        && sudo perl Build install \
	&& cd .. 

VOLUME /tmp

WORKDIR /tmp

ENTRYPOINT ["/tmp/exifsort"]
