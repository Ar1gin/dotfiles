.PHONY: stow unstow restow clear

STOW_TARGET = $$HOME"/.config"
STOW_SOURCE = "./config"

generated = \
	config/nushell/zoxide.nu \
	config/quickshell/.qmlls.ini \

config/nushell/zoxide.nu:
	zoxide init nushell > config/nushell/zoxide.nu

config/quickshell/.qmlls.ini:
	touch config/quickshell/.qmlls.ini

clear: unstow
	rm $(generated)

stow: $(generated)
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -S ./
unstow:
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -D ./
restow: $(generated)
	stow -v -t $(STOW_TARGET) -d $(STOW_SOURCE) -R ./
