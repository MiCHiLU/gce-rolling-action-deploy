FROM scratch
ADD bin/main /
EXPOSE 8080
ENTRYPOINT ["/main"]
