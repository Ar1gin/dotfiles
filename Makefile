.PHONY: stow unstow

STOW_PATH = $$HOME"/.config"

stow:
	stow -v -t $(STOW_PATH) -S ./
unstow:
	stow -v -t $(STOW_PATH) -D ./
restow:
	stow -v -t $(STOW_PATH) -R ./
