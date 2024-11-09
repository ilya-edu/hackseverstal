# Severstal predict


## Poetry

This project uses poetry. It's a modern dependency management
tool.

To run the project use this set of commands:

```bash
poetry install
poetry run python -m severstal_predict
```

This will start the server on the configured host.

You can find swagger documentation at `/api/docs`.

You can read more about poetry here: https://python-poetry.org/

## Docker

You can start the project with docker using this command:

```bash
docker-compose -f deploy/docker-compose.yml --project-directory . up --build
```

If you want to develop in docker with autoreload add `-f deploy/docker-compose.dev.yml` to your docker command.
Like this:

```bash
docker-compose -f deploy/docker-compose.yml -f deploy/docker-compose.dev.yml --project-directory . up --build
```

This command exposes the web application on port 8000, mounts current directory and enables autoreload.

But you have to rebuild image every time you modify `poetry.lock` or `pyproject.toml` with this command:

```bash
docker-compose -f deploy/docker-compose.yml --project-directory . build
```

## Project structure

```bash
$ tree "severstal_predict"
├── deploy
│   ├── api  # Dockerfile for API.
│   └── worker  # Dockerfile for worker.
├── severstal_predict
│   ├── __main__.py  # Startup API. Starts uvicorn.
│   ├── conftest.py  # Fixtures for all tests.
│   ├── services  # Package for different external services such as RabbitMQ or Redis etc.
│   │   ├── rabbit  # RabbitMQ integration.
│   │   └── redis  # Redis integration.
│   ├── settings.py  # Main configuration settings for project.
│   ├── static  # Static content.
│   ├── tests  # Tests for API project.
│   └── web  # Package contains web server. Handlers, startup config.
│       ├── api  # Package with all handlers.
│       │   ├── docs  # Swagger docs.
│       │   ├── monitoring  # Healthcheck endpoint.
│       │   ├── predict  # Predict endpoints.
│       │   └── router.py  # Main router.
│       ├── application.py  # FastAPI application configuration.
│       └── lifetime.py  # Contains actions to perform on startup and shutdown.
└── worker
    ├── tests  # Tests for project.
    └── worker  # Tests for worker.
        ├── __main__.py  # Startup worker.
        └── data_processing.py  # Functions for prediction.
```

## Configuration

This application can be configured with environment variables.

You can create `.env` file in the root directory and place all
environment variables here.

All environment variables should start with "SEVERSTAL_PREDICT_" prefix.

For example if you see in your "severstal_predict/settings.py" a variable named like
`random_parameter`, you should provide the "SEVERSTAL_PREDICT_RANDOM_PARAMETER"
variable to configure the value. This behaviour can be changed by overriding `env_prefix` property
in `severstal_predict.settings.Settings.Config`.

An example of .env file:
```bash
SEVERSTAL_PREDICT_RELOAD="True"
SEVERSTAL_PREDICT_PORT="8000"
SEVERSTAL_PREDICT_ENVIRONMENT="dev"
```

You can read more about BaseSettings class here: https://pydantic-docs.helpmanual.io/usage/settings/

## Pre-commit

To install pre-commit simply run inside the shell:
```bash
pre-commit install
```

pre-commit is very useful to check your code before publishing it.
It's configured using .pre-commit-config.yaml file.

By default it runs:
* black (formats your code);
* mypy (validates types);
* isort (sorts imports in all files);
* flake8 (spots possibe bugs);


You can read more about pre-commit here: https://pre-commit.com/


## Running tests

If you want to run it in docker, simply run:

```bash
docker-compose -f deploy/docker-compose.yml -f deploy/docker-compose.dev.yml --project-directory . run --build --rm api pytest -vv .
docker-compose -f deploy/docker-compose.yml -f deploy/docker-compose.dev.yml --project-directory . down
```

For running tests on your local machine.


2. Run the pytest.
```bash
pytest -vv .
```
