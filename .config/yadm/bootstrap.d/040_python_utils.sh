#!/bin/sh
pipx install pre-commit --force
pipx install --spec git+https://github.com/nabadger/gitlab-sync.git gitlab-sync --force
