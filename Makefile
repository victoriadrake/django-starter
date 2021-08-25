SHELL := /bin/bash
.POSIX:

help: ## Show this help
		@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

make pyenv-install: ## Install Python 3.9 via pyenv, to manage multiple versions
		git clone https://github.com/pyenv/pyenv.git ~/.pyenv
		cd ~/.pyenv && src/configure && make -C src
		@echo "You'll need to configure your shell for Pyenv yourself: https://github.com/pyenv/pyenv#basic-github-checkout"
		@echo "I'd like to do it for you but it's too tricky! >_<"
		@echo "Afterwards do 'pyenv local 3.9.6'"

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
