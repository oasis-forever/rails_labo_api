# syntax = docker/dockerfile:experimental

# 1. Load Ruby image
FROM ruby:2.7.2

# 2. Install Node.js and Yarn
RUN apt-get update && apt-get install -y curl build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

# 3. Switch directory to /tmp
WORKDIR /tmp

# 4. Install bundler
RUN gem install bundler

# 6. Switch directory to /app
WORKDIR /app

# 7. Define path for gem install
RUN bundle config set path vendor/bundle

# 8. Define the commands when no command is assigned in execution
EXPOSE 5000
CMD ["bash"]
