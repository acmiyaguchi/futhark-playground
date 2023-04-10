build:
	futhark literate --backend=cuda pi.fut
	mv pi.md README.md

sync:
	futhark pkg sync

clean:
	rm -rf pi.c pi pi-img
