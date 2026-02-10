FROM ubuntu:latest
LABEL authors="waney"

ENTRYPOINT ["top", "-b"]