
# DemandScape Forecast API

DemandScape provides AI-powered demand forecasting and scenario simulation.

## Base URL

POST https://demandscape-orchestrator.fly.dev/v1/infer

## Authentication

Authorization: Bearer PARTNER_API_KEY

Partners DO NOT need Hugging Face tokens.

---

## Architecture

Partner → Diskover Orchestrator → Hugging Face → DeepAR Model → Response

---

## Multi‑Scenario Support

Scenarios must be provided inside:

inputs.parameters.scenarios

Example:

"parameters": {
  "encoder_length": 12,
  "prediction_length": 6,
  "scenarios": {
    "base": {},
    "price_up_5pct": {
      "planned_price_index": 1.05
    }
  }
}

---

## Support

info@diskoverdiagnostics.com
