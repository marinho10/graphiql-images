#!/bin/sh
set -e

# Run the migration first using the custom release task
/opt/build/prod/rel/graphiql_images/bin/graphiql_images eval "GraphiQLImages.Release.migrate"

# Launch the OTP release and replace the caller as Process #1 in the container
exec /opt/build/prod/rel/graphiql_images/bin/graphiql_images "$@"
