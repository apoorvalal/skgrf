PYTHON := python
UV := uv

buildpre:
	$(PYTHON) buildpre.py

.PHONY: build
build:
	$(PYTHON) build.py clean
	$(PYTHON) build.py build_ext --inplace --force

clean:
	rm -rf build
	rm -rf dist


sdist: copy
	$(PYTHON) -m build --sdist

setup:
	git submodule init
	git submodule update
	$(PYTHON) buildpre.py
