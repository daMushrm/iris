# Makefile to install iris.sh into system bin path

SCRIPT = iris.sh
DEST_DIR = /usr/bin
EXECUTABLE= iris

all: install

install: $(SCRIPT)
	@echo "\033[1;33m[!] Installing iris...\033[0m"
	sudo cp $(SCRIPT) $(DEST_DIR)/$(EXECUTABLE)
	@echo "\033[32m[!] Installation complete.\033[0m"
	sh configure_iris.sh
delete:
	@echo "\033[1;33m[!] This will delete iris and auto start file. Are you sure you want to delete iris? [y/N]"
	@read ans; \
	if [ $$ans = "y" ]; then \
		sed -i '/iris/d' ~/.profile; \
		echo "\033[0;32m[!] Deleted successfully\033[0m"; \
	else \
		echo "\033[1;33m[!] Ignored.\033[0m"; \
	fi

.PHONY: all install clean
.PHONY: all delete install clean
