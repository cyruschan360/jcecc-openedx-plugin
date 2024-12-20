# -------------------------------------------------------------------------
# build a package for PyPi
# -------------------------------------------------------------------------
.PHONY: build
.PHONY: requirements

report:
	cloc $(git ls-files)

build:
	python3 -m pip install --upgrade setuptools wheel twine
	python3 -m pip install --upgrade build

	if [ -d "./build" ]; then sudo rm -r build; fi
	if [ -d "./dist" ]; then sudo rm -r dist; fi
	if [ -d "./jcecc-openedx-plugin.egg-info" ]; then sudo rm -r jcecc-openedx-plugin.egg-info; fi

	python3 -m build --sdist ./
	python3 -m build --wheel ./

	python3 -m pip install --upgrade twine
	twine check dist/*


# -------------------------------------------------------------------------
# upload to PyPi Test
# https:// ?????
# -------------------------------------------------------------------------
release-test:
	make build
	twine upload --skip-existing --repository testpypi dist/*


# -------------------------------------------------------------------------
# upload to PyPi
# https://pypi.org/project/django-memberpress-client/
# -------------------------------------------------------------------------
release-prod:
	make build
	twine upload --skip-existing dist/*
