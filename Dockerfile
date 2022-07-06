FROM jakzal/phpqa:latest
ARG PROJECTDIR
WORKDIR /home/proj
RUN apt update && apt install jq -y 
#jq for json parsing
COPY ${PROJECTDIR} .
RUN composer update
COPY analyser.sh .
CMD ["/bin/bash","analyser.sh"]