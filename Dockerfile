
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y gcc make jq diffutils

WORKDIR /app

COPY . .

RUN make clean && make check

ENTRYPOINT ["./build/wordcount"]
  
