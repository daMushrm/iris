# Makefile to install iris.sh into system bin path

SCRIPT = iris.sh
DEST_DIR = /usr/bin
EXECUTABLE= iris
SERVICE_FILE= ~/.config/autostart/iris.desktop

all: install

install: $(SCRIPT)
	@echo "Installing $(SCRIPT) to $(DEST_DIR)..."
	sudo cp $(SCRIPT) $(DEST_DIR)/$(EXECUTABLE)
	@echo "\033[32mInstallation complete.\033[0m"
	@echo "Do you want to run \033[33miris remind\033[0m on startup? (y/n): "
	@read  choice; \
	if [ "$$choice" = "y" ]; then \
		echo "Creating iris.desktop file..."; \
		echo "[Desktop Entry] " | sudo tee $(SERVICE_FILE); \
		echo "Version=1.0" | sudo tee -a $(SERVICE_FILE); \
		echo "Comment=Run iris at startup" | sudo tee -a $(SERVICE_FILE); \
		echo "Exec=/usr/bin/iris remind" | sudo tee -a $(SERVICE_FILE); \
		echo "Terminal=false" | sudo tee -a $(SERVICE_FILE); \
		echo "Type=Application" | sudo tee -a $(SERVICE_FILE); \
		echo "Categories=Utility;" | sudo tee -a $(SERVICE_FILE); \
		echo "\033[32mIris is enabled to run at startup, beginning from next login.\033[0"; \
	else \
		echo "Skipping startup configuration."; \
	fi
delete:
	sudo rm $(DEST_DIR)/$(EXECUTABLE)
	@echo "Deletion complete."

.PHONY: all install clean
.PHONY: all delete install clean
