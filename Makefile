
all: build

build:
	stack build

test:
	stack test

ghcid:
	ghcid -c=stack ghci test/Spec.hs -T=main

