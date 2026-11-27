#!/usr/bin/env bash
# Behaviour test pre-script (ADR 0155 Vault scenarios). Prints a
# fingerprint of each Vault scenario secret this host-side script
# received, never the value.
set -euo pipefail
for name in JIRA_TOKEN OTEL_EXPORTER_OTLP_HEADERS OTEL_EXPORTER_OTLP_TRACES_HEADERS BEHAVIOUR_VAULT_RUNNER_SECRET; do
  value="${!name:-}"
  if [ -n "$value" ]; then
    fp=$(printf '%s%s' 'fullsend-bt-vault:' "$value" | sha256sum | cut -c1-16)
    echo "vault-fingerprint ${name}=${fp}"
  else
    echo "vault-fingerprint ${name} unset"
  fi
done
if [ -n "${FULLSEND_GITHUB_RUNNER_SECRETS:-}" ]; then
  echo "vault-bundle-visible-to-script"
fi

