SHELL := /bin/bash
.POSIX:

help: ## Show this help
		@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

pyenv-install: ## Install Python via pyenv, to manage multiple versions
		git clone https://github.com/pyenv/pyenv.git ~/.pyenv
		cd ~/.pyenv && src/configure && make -C src
		@echo "Configuring your shell for Pyenv..."
		@echo '# Pyenv configuration (https://github.com/pyenv/pyenv#basic-github-checkout)' >> ~/.bashrc
		@echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> ~/.bashrc
		@echo 'command -v pyenv >/dev/null || export PATH="$$PYENV_ROOT/bin:$$PATH"' >> ~/.bashrc
		@echo 'eval "$$(pyenv init -)"' >> ~/.bashrc
		@echo "All done! To see available Python versions to install, do 'pyenv install --list'."
		@echo "If the Python installation fails, ensure you have Python dependencies and build tools installed: https://github.com/pyenv/pyenv/wiki#suggested-build-environment"

get-python-libs-debian: ## Install Python dependencies and build tools on Ubuntu/Debian/Mint
		sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev curl \
		libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
		@echo "To install dependencies with sudo apt, enter your password (it's not stored by this script)."

get-pip: ## Install pip in a Python environment with Python's 'ensurepip' module
		python -m ensurepip --upgrade
		python -m pip install --upgrade pip

get-pipenv: ## Pipenv is a dependency manager for Python projects
		pip install --user pipenv
		pip install --user --upgrade pipenv

get-django: ## Install Django using pipenv
		pipenv install Django

install: get-pipenv ## Install or update all dependencies
		pipenv install --dev
		pipenv run pre-commit install --install-hooks
		@echo "All done!"

pipshell: ## Start a shell in the virtual environment
		pipenv shell

db: ## Start the Docker Postgres container in background
		docker-compose -f docker-compose.yml up -d

db-shell: ## Start an interactive shell in the Postgres DB
		docker exec -it "$(CONTAINER)" bash

psql: ## Enter the DB with psql
		docker exec -it "$(CONTAINER)" psql -U "$(POSTGRES_USER)" "$(POSTGRES_DB)"

dev: db ## Run the Django development server
		@echo "Docker needs a second to finish ^_^*"
		sleep 2
		pipenv run python manage.py runserver --settings=app.settings.local

migrate: ## Make and perform Django migrations
		pipenv run python manage.py makemigrations
		pipenv run python manage.py migrate

test: ## Run tests in parallel, stop if one fails
	pipenv run python manage.py test --verbosity=0 --parallel --failfast
