cloud-dev
===
Scripts for building containerized code-server development workflow.

## Usage
1. Build the image: `docker build . -t cloud-dev`
2. Run `docker run -itd -p <local_addr>:<local_port>:9000 -v <project_dir>:/workspace/ cloud-dev`
3. Start coding

## Extend build environment
You can use Dockerfile `FROM` to build upon this image.

## LICENSE
GPL-3.0