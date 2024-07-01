.PHONY: stow unstow

STOW_TARGET = $$HOME"/.config"
STOW_SOURCE = "./config"

stow:
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -S ./
unstow:
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -D ./
restow:
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -R ./
