FROM ubuntu
RUN apt-get update
RUN apt-get install libgmp3-dev libcurl3 -y
ADD hackage-downloads-api /hackage-downloads-api
CMD /hackage-downloads-api
