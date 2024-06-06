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
	@echo "\033[1;33m[!] This will delete iris and auto start file. Are you sure you want to delete iris? [y/n]"
	@read ans; \
	if [ $$ans = "y" ]; then \
		make delete_iris; \
	fi
delete_iris:
	@echo "\033[1;33m[!] Deleting iris..."
	sudo rm $(DEST_DIR)/$(EXECUTABLE)
	@echo "\033[32m[!] Deletion complete.\033[0m"
	@echo "\033[1;33m[!] Deleting iris.desktop..."
	sudo rm $(SERVICE_FILE)
	@echo "\033[32m[!] Deletion complete.\033[0m"

.PHONY: all install clean
.PHONY: all delete install clean
