FROM 'phusion/passenger-ruby24'

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Text-to-speech stuff
RUN apt-get update
RUN apt-get install -y libttspico-utils
# Example usage: pico2wave -w=hello.wav "Hello my love, I heard a kiss from you"

# https://github.com/phusion/passenger-docker/issues/195
RUN apt-get install -y tzdata

# Converting tools
RUN apt-get install -y ffmpeg

## Setting up the App
# Nginx and Passenger are disabled by default
RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default
ADD ./docker_resources/say_anything.conf /etc/nginx/sites-enabled/say_anything.conf
ADD ./docker_resources/application_environment_variables.conf /etc/nginx/main.d/application_environment_variables.conf

# Move in app and set permissions
RUN mkdir /home/app/say_anything
ADD . /home/app/say_anything
RUN cd /home/app/say_anything && bundle install --without test development && rake assets:precompile
RUN touch /home/app/say_anything/log/production.log
RUN chown -R app /home/app/say_anything

# Clean up apt
RUN apt-get clean
