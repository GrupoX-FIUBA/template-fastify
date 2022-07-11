#!/bin/sh

datadog-agent run > /dev/null &
/opt/datadog-agent/embedded/bin/trace-agent --config=/etc/datadog-agent/datadog.yaml > /dev/null &
/opt/datadog-agent/embedded/bin/process-agent --config=/etc/datadog-agent/datadog.yaml > /dev/null &

DD_SERVICE="$APP_NAME" \
DD_ENV="prod" \
DD_LOGS_INJECTION=true \
npm run start
