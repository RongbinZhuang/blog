SHELL=/bin/bash

GITSSH				:= git@github.com:
COUNT 				:= RongbinZhuang
REPO 				:= $(notdir $(CURDIR))
BRANCH 				:= master
GITURL 				:= git@github.com:RongbinZhuang/blog.git

all:startFlag pull
	@echo -e "\nDone"

pull:
	git pull $(REPO) $(BRANCH)

push:startFlag
	git add .
	git commit -m "naive"
	git push $(REPO) $(BRANCH)
	
include Makefile.ass
