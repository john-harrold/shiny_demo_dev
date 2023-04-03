# `shiny_demo_dev`

Docker container to demo Shiny apps using development versions. Note that this
container will only work on x86 (Intel or AMD) machines. So it will not work
on the new Apple Silicon (M1, etc.) computers.

```
docker build -t shiny --no-cache  https://raw.githubusercontent.com/john-harrold/shiny_demo_dev/main/Dockerfile
docker run --name shiny_dev --rm -p 3838:3838 shiny_dev &
```

Then open a web browser and point it to:
```
https://localhost:3838/
```
