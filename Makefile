help:
	@echo "available commands"
	@echo " - dev       : install dev environment"
	@echo " - clean     : clean temporary folders and files"
	@echo " - lint      : checks code style"
	@echo " - test      : runs all unit tests"
	@echo " - coverage  : runs coverage report"
	@echo " - doc       : creates documentation in html"

env:
	python -m pip install --upgrade pip
	pip install -r requirements-dev.txt

dev: env
	pre-commit install
	(command -v gitmoji >/dev/null && gitmoji -i) || echo Please install gitmoji-cli

clean:
	rm -rf `find . -type d -name .pytest_cache`
	rm -rf `find . -type d -name __pycache__`
	rm -rf `find . -type d -name .ipynb_checkpoints`
	rm -rf docs/_build
	rm -f .coverage

lint: clean
	flake8

test: clean
	python manage.py test

coverage: clean
	coverage run --source='.' manage.py test
	coverage report
