.PHONY: stow unstow restow clear

STOW_TARGET = $$HOME"/.config"
STOW_SOURCE = "./config"

generated = \

clear: unstow
	rm $(generated)

stow: $(generated)
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -S ./
unstow:
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -D ./
restow: $(generated)
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -R ./
