# Say Anything

An excuse to:

* Dockerize a simple text-to-speech web site.
* Use Docker in development without sacrificing hot reloading.

WAVs are created by [pico2wave](http://manpages.ubuntu.com/manpages/trusty/man1/pico2wave.1.html), then turned into an MP3 with ffmpeg.

## Building a Docker Image

### For Local Development

1.  `cp ./config/.env.example ./config/.env` and fill in values
1.  `docker build --no-cache -f Dockerfile-local -t say_anything:local .`
1.  `docker run --env-file ./docker_resources/.env -p 3000:3000 -i -v $(pwd):/home/app/say_anything -t say_anything:local`
1.  Open a browser and go to http://localhost:3000

### For Production

1.  `cp ./config/.env.example ./config/.env` and fill in values
1.  `docker build --no-cache -f Dockerfile .`
1.  `docker run --env-file ./docker_resources/.env -p 80:80 [IMAGE]`
1.  To test locally, open a browser and go to http://localhost.
