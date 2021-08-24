# Django Starter

<img src="./app/static/app/img/logo.png" width="150px" align="right"/>

Go from a new environment to starting a Django project before your coffee cools!

I put all my Django best practices into this starter repository so you can start building right away.

This will help you:

- Run tests and [Django Security Check](https://github.com/victoriadrake/django-security-check) via GitHub Actions
- Work faster with a [self-documenting Makefile](https://victoria.dev/blog/how-to-create-a-self-documenting-makefile/) tailored to Django
- Format files before committing with [pre-commit](.pre-commit-config.yaml)
- Get Python 3.9, Pip, Pipenv, and Django installed in a new environment
- Work with a .gitignore tailored to Python and Django development
- Set up and link a Docker Postgres database

## Usage

### 1. Clone this repository

```sh
git clone https://github.com/victoriadrake/django-starter
```

### 2. Set your environment variables

```sh
./env-setup.sh
```

(It's always a good idea to read scripts before running them! If you don't, well, thanks for the Bitcoin.)

### 3. Install dependencies

Do `make install` to install dependencies in a virtual environment.

If you'd like help installing just Django via Pipenv, run `./django-setup.sh`.

### 4. Profit!!!

You can now do `make dev` to see a pretty welcome page at `http://localhost:8000/` and test that everything's working properly.

Start building! If you're new to Django, check out their [great tutorials](https://docs.djangoproject.com/en/3.2/intro/).

Run `make help` to see what else I've got set up for you.

## What and why

Over the years I've been developing with Django, I've built up a suite of developer tools, practices that help make programmers more efficient, and lots of little tips and ideas that make building with Django easier.

I've [written about a lot of these](https://victoria.dev/tags/django/), and wanted to make it easier for you to use them too!

### Automation

You can take advantage of automation to relieve developers of having to remember to run linting, tests, and other routine actions. The use of pre-commit and flows like GitHub Actions can help to keep your codebase consistent, tested, and easier to develop.

- This [pre-commit configuration](.pre-commit-config.yaml) helps to format code and documentation, and even check for accidentally committed credentials!
- I've included GitHub Actions for [running your test suite](.github/workflows/ci.yml) and [Django Security Check](.github/workflows/django-security-check.yml) on pull requests.

### Settings and environments

Instead of the default `settings.py`, I use a settings directory with separate files for local and production environment settings. This helps avoid misconfiguration mishaps!

You can pass the settings file as an argument, for example when running the development server:

```sh
python manage.py runserver --settings=app.settings.local
```

The Makefile command `make dev` uses this. Speaking of...

### A super helpful Makefile

Imagine having a super helpful, project-specific CLI that neatly remembers all your typical development actions for you. For example, instead of typing...

```sh
pipenv run coverage run python manage.py test app --verbosity=0 --parallel --failfast
```

You can just do:

```sh
make test
```

Isn't that better? I think so! Check out the [self-documenting Makefile](Makefile) to see how it makes other everyday actions easier. (Why's it self-documenting? Just type `make help` and see.)

## Contributing

Have something to add? Feel free to open a pull request!
