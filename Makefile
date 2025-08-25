USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)
# change user and passwd if you use it

# Default prompt if none provided
PROMPT ?= 
FILE ?=

all: 
	if [ ! -f gemini.key ]; then \
		echo "gemini.key 파일이 없습니다. vi로 파일을 만드세요."; \
		vi gemini.key; \
		echo "rerun make"; \
        exit;       \
	fi; \
	$(if $(FILE), \
		docker run -it --rm -v ./:/usr/src/app -e GEMINI_API_KEY="$(shell cat gemini.key)" gemini-app gemini --model gemini-2.5-flash -y -p "$$(cat $(FILE))", \
		docker run -it --rm -v ./:/usr/src/app -e GEMINI_API_KEY="$(shell cat gemini.key)" gemini-app gemini --model gemini-2.5-flash $(if $(PROMPT),-p "$(PROMPT)"))
build:
	docker build --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) -t gemini-app .
build-no-cache:
	docker build --no-cache --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) -t gemini-app .
sh: 
	docker run -it --rm -v ./:/usr/src/app  -e GEMINI_API_KEY="$(shell cat gemini.key)" gemini-app /bin/bash
