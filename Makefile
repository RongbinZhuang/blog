SHELL=/bin/bash
include Makefile.var

all:pull
	@echo -e "\nDone"

pull:
	git pull $(REPO) $(BRANCH)

push:
	git add .
	git commit -m "naive"
	git push $(REPO) $(BRANCH)
	
include Makefile.ass
