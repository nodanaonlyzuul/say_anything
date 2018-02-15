# Say Anything

An excuse to Dockerize a simple text-to-speech web site.

WAV created by [pico2wave](http://manpages.ubuntu.com/manpages/trusty/man1/pico2wave.1.html),
then turned into an MP3 with ffmpeg.

## Building & Running Locally as a Docker Image

1.  `cp ./config/.env.example ./config/.env` and fill in values
1.  `docker build .`
1.  `docker run --env-file ./docker_resources/.env -p 80:80 [IMAGE]`
