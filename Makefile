
.PHONY: send get clear

send:
	git push origin master

get:
	git pull origin master

clear: tilda	
	git add .

tilda: *~
	rm *~
