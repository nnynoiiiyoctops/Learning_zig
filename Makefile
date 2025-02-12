.PHONY: send get clear

send:
	rm *~ 
	git push origin master

get:
	git pull origin master

clear:
	rm *~
	git add .
