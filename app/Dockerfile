FROM dilumn/baseimage-ruby-mysql:1.1.0
MAINTAINER Dilum Navanjana <dilumn@bbytes.sg>

ENV TZ Asia/Singapore

# Create app directory
RUN mkdir /app
WORKDIR /app

# Install gem dependency for app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

# install app
ADD . /app

# install app daemon
RUN mkdir /etc/service/thin
ADD ./docker-script/thin.sh /etc/service/thin/run
RUN chmod u+x /etc/service/thin/run

#update cron tasks
RUN whenever --update-crontab

ENTRYPOINT ["/sbin/my_init"]
