.PHONY: up
up: build
	sudo containerlab deploy --reconfigure --topo topology.clab.yaml

.PHONY: down
down:
	sudo containerlab destroy -c --topo topology.clab.yaml

.PHONY: graph
graph:
	containerlab graph --drawio --drawio-args="--theme nokia_modern" -t topology.clab.yaml
	drawio -x -f svg -o topology.clab.svg topology.clab.drawio

.PHONY: build
build:
	docker build -t frr-nft:latest .
