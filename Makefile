
tests:
	echo "Testing..."

sast:
	echo "Sasting..."

build:
	echo "Building..."

registry:
	echo "Registring..."

deploy:
	echo "Deploying..."

.PHONY: all help bootstrap check test coverage pylint mypy package clean
