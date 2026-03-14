#!/usr/bin/env bash

set -euo pipefail

DRY_RUN_MESSAGE='post-setup placeholder: configure remaining manual steps'
MANUAL_STEPS_NOTICE='NOTICE: no automated post-setup actions were run; manual post-setup steps are still required.'

if [ "${DRY_RUN:-0}" = "1" ]; then
  printf '%s\n' "$DRY_RUN_MESSAGE"
  exit 0
fi

printf '%s\n' "$MANUAL_STEPS_NOTICE"
exit 0
