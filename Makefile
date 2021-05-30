
tests: 
    echo "Test"
  
sast: 
    echo "SAST"
 
build: 
    echo "build"

docker-publish:
    echo "docker-publish"

deploy:
    echo "deploy"

.PHONY: tests sast build docker-publish deploy
