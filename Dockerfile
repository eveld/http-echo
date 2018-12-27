FROM gcr.io/cloud-builders/go:debian as build

ENV GOPATH=/workspace
COPY src /workspace/src/

RUN go install app

FROM debian

COPY --from=build /workspace/bin/app /bin/app
ENTRYPOINT "/bin/app"
