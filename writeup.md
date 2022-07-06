## Running the application
### 1. Place `Dockerfile` and `analyser.sh` in the same directory as project folder (This repository has *./proj* which is a bare Lumen project as an example)
### 2. Build Docker Image
- `docker build -t phpanalyser:0.1 --build-arg PROJECTDIR=<proj>.`
  - This will create a docker image containing the <proj> directory and placing *analyser.sh* inside that directory. Note that <proj> is the project directory. <proj> must be a Lumen project.
     
### 2. Run the Docker Image
- NORMAL RUN: `docker run phpanalyser:0.1`
  - This will run the image we just built. Running the image wil execute a series of tests on the *app* directory within `PROJECTDIR`:
    - parallel-lint
    - phpstan
    - phpcs
    - local-php-security-checker
    - phpcpd
  - There will also be a summary of the test results at the end of execution.
  - Once tests are finished executing, the container will stop.
- DEBUG RUN: `docker run -it phpanalyser:0.1 bash `
  - This will execute `bash` inside the container so you can inspect the filesystem, or run custom tests manually.
  - Typing `exit` will exit and stop the container

## Additional Information
- The Base Image used is `jakzal/phpqa:latest`(https://hub.docker.com/r/jakzal/phpqa/), which contains multiple analysis tools for PHP. To list available tools, type `php /tools/toolbox list-tools`