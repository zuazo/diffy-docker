#!/bin/sh

CANDIDATE='http-candidate.herokuapp.com:9992'
PRIMARY='http-primary.herokuapp.com:9990'
SECONDARY='http-secondary.herokuapp.com:9991'

docker run -ti \
  -p 31900:31900 \
  -p 31149:31149 \
  zuazo/diffy \
    -candidate="$CANDIDATE" \
    -master.primary="$PRIMARY" \
    -master.secondary="$SECONDARY" \
    -service.protocol=http \
    -serviceName="My Service" \
    -proxy.port=:31900 \
    -admin.port=:31159 \
    -http.port=:31149 \
    -rootUrl=localhost:31149
