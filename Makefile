.PHONY: update
update:
	nix flake update

.PHONY: home
home:
	home-manager switch --flake .
