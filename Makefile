config:
	@echo "Run ./configure instead!"

install: config
	./install.sh

clean:
	rm -f .config
