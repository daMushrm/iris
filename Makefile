# Makefile to install iris.sh into system bin path

SCRIPT = iris.sh
DEST_DIR = /usr/bin
EXECUTABLE= iris

all: install

install: $(SCRIPT)
	@echo "Installing $(SCRIPT) to $(DEST_DIR)..."
	sudo cp $(SCRIPT) $(DEST_DIR)/$(EXECUTABLE)
	@echo "Installation complete."

delete:
	sudo rm $(DEST_DIR)/$(EXECUTABLE)
	@echo "Deletion complete."

.PHONY: all install clean
