USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)
# change user and passwd if you use it

# Default prompt if none provided
PROMPT ?= 
FILE ?=

all: 
	 $(if $(FILE), \
		 docker run -it --rm -v ./:/usr/src/app -e GEMINI_API_KEY=AIzaSyB647F_VzNA0tT8kacPMLTbL62EWEChmyw gemini-app gemini -y -p "$$(cat $(FILE))", \
		 docker run -it --rm -v ./:/usr/src/app -e GEMINI_API_KEY=AIzaSyB647F_VzNA0tT8kacPMLTbL62EWEChmyw gemini-app gemini -y $(if $(PROMPT),-p "$(PROMPT)"))
	 #docker run -it --rm --name gemini-container2 -v $$PWD:/usr/src/app  --user `id -u`:`id -g`  gemini-app
build:
	 docker build --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) -t gemini-app .
sh: 
	 docker run -it --rm -v ./:/usr/src/app  -e GEMINI_API_KEY=AIzaSyB647F_VzNA0tT8kacPMLTbL62EWEChmyw gemini-app /bin/bash
