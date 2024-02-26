#!/bin/bash

layout_poetry() {
	MANIFEST="${MANIFEST:-pyproject.toml}"
	PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -d. -f1-2)

	if [[ ! -f "$MANIFEST" ]]; then
		log_status "No pyproject.toml found. Executing \`poetry init\` to create a \`$MANIFEST\` first."
		poetry init --python ^"$PYTHON_VERSION"
	fi

	if [[ -d ".venv" ]]; then
		VIRTUALENV="$(pwd)/.venv"
	else
		VIRTUALENV=$(
			poetry env info --path 2>/dev/null
			true
		)
	fi

	if [[ -z $VIRTUALENV || ! -d $VIRTUALENV ]]; then
		log_status "No virtual environment exists. Executing \`poetry install\` to create one."
		poetry install
		VIRTUALENV=$(poetry env info --path)
	fi

	PATH_add "$VIRTUALENV/bin"
	export POETRY_ACTIVE=1
	export VIRTUALENV
}
