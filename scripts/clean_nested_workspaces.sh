#!/usr/bin/env bash

set -eu -o pipefail
# -e: exits if a command fails
# -u: errors if an variable is referenced before being set
# -o pipefail: causes a pipeline to produce a failure return code if any command errors

export DRY_RUN="${DRY_RUN:-false}"

export DEBUG="${DEBUG:-true}"
export QUIET="${QUIET:-false}"
export VERBOSE="${VERBOSE:-true}"

function log() {
  local loglevel="${1}"
  local msg="${2:-}"
  local insert_loglevel="${3:-true}"
  local insert_time="${4:-false}"

  if [[ "${insert_loglevel}" == "true" ]]; then
    msg="${loglevel}: ${msg}"
  else
    msg="${msg}"
  fi

  if [[ "${insert_time}" == "true" ]]; then
    msg="[$(date +"%Y-%m-%d %H:%M:%S")] ${msg}"
  else
    msg="${msg}"
  fi

  echo "${msg}"
}

function log_info() {
  [[ "${QUIET}" != "true" ]] && log "INFO " "${*}"
}

function log_debug() {
  [[ "${DEBUG}" == "true" ]] && log "DEBUG" "${*}"
}

function log_trace() {
  [[ "${VERBOSE}" == "true" ]] && log "TRACE" "${*}"
}

function log_and_run() {
  log_debug "$ ${*}"
  "${@}"
}

function log_separator() {
  echo
  echo "--------------------------------------------------------------------------------"
  echo
}

function ensure_dir_exists() {
  local dir="${1}"
  if [[ ! -d "${dir}" ]]; then
    log_info "Creating directory '${dir}'"
    mkdir -p "${dir}"
  else
    log_trace "Directory '${dir}' already exists"
  fi
}

function clean_nested_workspaces() {
  readonly workspaceRoots=("e2e" "examples" "packages" ".")
  for workspaceRoot in "${workspaceRoots[@]}"; do
    ensure_dir_exists "${workspaceRoot}"
    log_debug "Cleaning nested workspaces in '${workspaceRoot}'"

    workspaceFiles=($(find ./"${workspaceRoot}" -maxdepth 3 -type f -name WORKSPACE* -prune))
    for workspaceFile in "${workspaceFiles[@]}"; do
      workspaceDir=$(dirname "${workspaceFile}")
      log_separator
      log_info "Cleaning '${workspaceDir}'"
      pushd "${workspaceDir}" || log_debug "Skip '${workspaceDir}' (not exists)"

      if [[ "${DRY_RUN}" == "true" ]]; then
        log_debug "(dry-run) skip cleaning '${workspaceDir}'"
      else
        log_and_run rm -rf "$(find . -maxdepth 1 -type d -name node_modules -prune)"
        log_and_run bazel clean --expunge
      fi

      popd
    done
  done
}

clean_nested_workspaces "$@"
