#!/bin/bash

set -e
set -u

get_licenses() {

  local force="${1:-false}"

  local license_server="https://repository-build.coremedia.com"
  local license_path="nexus/service/local/artifact/maven/redirect"
  local license_opts="g=com.coremedia.cms.license&a=development-license&v=17-SNAPSHOT&p=zip&r=snapshots.licenses"

  if [[ ! -z "${force}" ]] && [[ "${force}" = "true" ]]
  then
    [ -f files/cms.zip ] && rm -f files/cms.zip
    [ -f files/mls.zip ] && rm -f files/mls.zip
    [ -f files/rls.zip ] && rm -f files/rls.zip
  fi

  [ -f files/cms.zip ] || curl -L -o files/cms.zip  "${license_server}/${license_path}?${license_opts}&c=prod"
  [ -f files/mls.zip ] || curl -L -o files/mls.zip  "${license_server}/${license_path}?${license_opts}&c=pub"
  [ -f files/rls.zip ] || curl -L -o files/rls.zip  "${license_server}/${license_path}?${license_opts}&c=repl"
}

get_licenses "$@"
