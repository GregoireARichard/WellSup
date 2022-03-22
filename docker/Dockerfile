# Use the Ruby 2.7.1 image from Docker Hub
# as the base image (https://hub.docker.com/_/ruby)
FROM ruby:3.0.2

# Use a directory called /code in which to store
# this application's files. (The directory name
# is arbitrary and could have been anything.)
WORKDIR /wellsup

# Copy all the application's files into the /code
# directory.
COPY . /wellsup/

# Run bundle install to install the Ruby dependencies.
RUN bundle install

# Set "rails server -b 0.0.0.0" as the command to
# run when this container starts.
CMD ["rails", "server", "-b", "0.0.0.0"]