FROM gcr.io/cloud-builders/go:debian as build

ENV GOPATH=/workspace
COPY src /workspace/src/

RUN go install app

FROM gcr.io/erik-playground/app

COPY --from=build /workspace/bin/app /bin/app
