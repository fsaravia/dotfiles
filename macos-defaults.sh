#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "usage: $0 [--check]" >&2
}

mode="apply"

if [[ "$#" -gt 1 ]]; then
  usage
  exit 2
fi

if [[ "$#" -eq 1 ]]; then
  if [[ "$1" != "--check" ]]; then
    usage
    exit 2
  fi

  mode="check"
fi

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "macos-defaults.sh requires macOS" >&2
  exit 1
fi

if [[ "$(uname -m)" != "arm64" ]]; then
  echo "macos-defaults.sh requires Apple Silicon" >&2
  exit 1
fi

macos_version="$(sw_vers -productVersion)"
macos_major="${macos_version%%.*}"

if [[ "$macos_major" != "26" ]]; then
  echo "macos-defaults.sh requires macOS 26; found $macos_version" >&2
  exit 1
fi

drift=0
finder_changed=0
dock_changed=0

apply_default() {
  local domain="$1"
  local key="$2"
  local type="$3"
  local value="$4"
  local restart_target="${5:-}"
  local expected="$value"
  local expected_type
  local current="<missing>"
  local current_type="missing"

  case "$type" in
    bool)
      expected_type="Type is boolean"
      if [[ "$value" == "true" ]]; then
        expected="1"
      else
        expected="0"
      fi
      ;;
    int)
      expected_type="Type is integer"
      ;;
    string)
      expected_type="Type is string"
      ;;
    *)
      echo "unsupported defaults type: $type" >&2
      exit 1
      ;;
  esac

  if ! current_type="$(defaults read-type "$domain" "$key" 2>/dev/null)" \
    || ! current="$(defaults read "$domain" "$key" 2>/dev/null)"; then
    current="<missing>"
    current_type="missing"
  fi

  if [[ "$current_type" == "$expected_type" && "$current" == "$expected" ]]; then
    return
  fi

  drift=1
  printf '%s %s: %s (%s) -> %s (%s)\n' \
    "$domain" "$key" "$current" "$current_type" "$expected" "$expected_type"

  if [[ "$mode" == "check" ]]; then
    return
  fi

  defaults write "$domain" "$key" "-$type" "$value"

  case "$restart_target" in
    Finder)
      finder_changed=1
      ;;
    Dock)
      dock_changed=1
      ;;
  esac
}

# General UI and typing
apply_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true
apply_default NSGlobalDomain PMPrintingExpandedStateForPrint bool true
apply_default NSGlobalDomain AppleKeyboardUIMode int 2
apply_default NSGlobalDomain NSAutomaticCapitalizationEnabled bool false
apply_default NSGlobalDomain NSAutomaticDashSubstitutionEnabled bool false
apply_default NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled bool false
apply_default NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled bool false
apply_default NSGlobalDomain NSAutomaticSpellingCorrectionEnabled bool false

# Screen lock
apply_default com.apple.screensaver askForPassword int 1
apply_default com.apple.screensaver askForPasswordDelay int 0

# Finder
apply_default com.apple.finder ShowPathbar bool true Finder
apply_default com.apple.finder ShowStatusBar bool true Finder
apply_default com.apple.finder FXDefaultSearchScope string SCcf Finder
apply_default com.apple.finder FXPreferredViewStyle string Nlsv Finder
apply_default com.apple.finder _FXSortFoldersFirst bool true Finder
apply_default com.apple.desktopservices DSDontWriteNetworkStores bool true

# Dock
apply_default com.apple.dock autohide bool true Dock
apply_default com.apple.dock mineffect string scale Dock
apply_default com.apple.dock show-recents bool false Dock

if [[ "$mode" == "check" ]]; then
  if [[ "$drift" -ne 0 ]]; then
    exit 1
  fi

  echo "macOS defaults are current."
  exit 0
fi

if [[ "$finder_changed" -eq 1 ]] && pgrep -x Finder >/dev/null; then
  killall Finder
fi

if [[ "$dock_changed" -eq 1 ]] && pgrep -x Dock >/dev/null; then
  killall Dock
fi

if [[ "$drift" -eq 0 ]]; then
  echo "macOS defaults are current."
else
  echo "Applied macOS defaults. Some settings may require a logout or restart."
fi
