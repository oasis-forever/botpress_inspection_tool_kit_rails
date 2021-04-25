# syntax = docker/dockerfile:experimental

# 1. Load Ruby image
FROM ruby:3.0.1

# 2. Install required packages
RUN apt-get update && apt-get install -y curl build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN apt-get update && apt-get install -y google-chrome-stable
RUN apt-get update && apt-get install -y libvips libvips-dev

# 3. Switch directory to /tmp
WORKDIR /tmp

# 4. Install bundler
RUN gem install bundler

# 6. Switch directory to /app
WORKDIR /app

# 7. Define path for gem install
RUN bundle config set path vendor/bundle

# 8. Define the commands when no command is assigned in execution
EXPOSE 3000
CMD ["bash"]
