.PHONY: test compile_and_test build run dev shell

compile:
	swig -c++ -python -py3 BV.i
	python3 setup.py install

test:
	python3 -m pytest tests/

compile_and_test: compile
	make test

# Build the Docker environment
build:
	docker build -t openmined/pybv .

# Run the source code inside the Docker environment
run:
	docker run -i -t openmined/pybv make test

# Run *my* source code with the Docker environment
dev:
	docker run -i -t -v "$(PWD):/PyBV" openmined/pybv make compile_and_test

# Open a shell inside the Docker environment, for debugging
shell:
	docker run -i -t -v "$(PWD):/PyBV" openmined/pybv sh
