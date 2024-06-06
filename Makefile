# Makefile to install iris.sh into system bin path

SCRIPT = iris.sh
DEST_DIR = /usr/bin
EXECUTABLE= iris
SERVICE_FILE= ~/.config/autostart/iris.desktop

all: install

install: $(SCRIPT)
	@echo "\033[1;33m[!] Installing iris..."
	@echo "\033[1;30m" sudo cp $(SCRIPT) $(DEST_DIR)/$(EXECUTABLE)
	@echo "\033[32m[!] Installation complete.\033[0m"
delete:
	sudo rm $(DEST_DIR)/$(EXECUTABLE)
	@echo "Deletion complete."

.PHONY: all install clean
.PHONY: all delete install clean
