MINIFIER=closure-compiler --language_in=ECMASCRIPT5
#MINIFIER=cat

DEPS=libav/libav-2.2.4.3.1-fat.js \
	noise-repellent/noise-repellent-m.js \
	web-streams-ponyfill.js \
	localforage.min.js

SRC=src/head.js \
	src/view.js \
	src/locale.js \
	src/serialize.js \
	src/db.js \
	src/track.js \
	src/filters.js \
	src/main.js \
	src/tail.js

all: ennuizel.js ennuizel.min.js $(DEPS)

ennuizel.js: $(SRC)
	cat $(SRC) | cat src/license.js - > $@

ennuizel.min.js: $(SRC)
	cat $(SRC) | $(MINIFIER) | cat src/license.js - > $@

libav/libav-1.2.4.1.3-fat.js:
	echo 'You must copy or link a "fat" build of libav.js to the libav/ directory.'
	false

web-streams-ponyfill.js:
	test -e node_modules/web-streams-polyfill/dist/ponyfill.js || npm install web-streams-polyfill
	cp node_modules/web-streams-polyfill/dist/ponyfill.js $@

localforage.min.js:
	test -e node_modules/localforage/dist/localforage.min.js || npm install localforage
	cp node_modules/localforage/dist/localforage.min.js .

clean:
	rm -f ennuizel.js ennuizel.min.js

distclean: clean
	rm -rf node_modules web-streams-ponyfill.js localforage.min.js
