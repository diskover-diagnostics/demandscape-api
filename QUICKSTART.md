
# Quickstart

## Step 1

Get API key.

## Step 2

Send POST request

curl https://demandscape-orchestrator.fly.dev/v1/infer \
-H "Authorization: Bearer PARTNER_API_KEY" \
-H "Content-Type: application/json" \
-d @example-multi-scenario.json

## Step 3

Receive forecast output.

Scenarios must be inside:

inputs.parameters.scenarios
