FROM elixir:1.13.0

# DISCLAIMER: https://hexdocs.pm/mix/Mix.Tasks.Release.html#module-deployments
# If you are building in macOS, you will get an error when trying to run the
# package in Linux.

# Workdir
RUN mkdir /app
COPY . /app
WORKDIR /app

# Expose PORT
EXPOSE 4000

# Copy the entrypoint script
ADD _build /opt/build/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

# Migrate and start package
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start"]
