# DemandScape API Quickstart

Generate your first forecast in under 5 minutes.

DemandScape is accessed via Diskover Orchestrator.

Partners DO NOT need HuggingFace tokens.

---

# Step 1 — Get Partner API Key

You need:

DemandScape Partner API Key

Format:

ds_partner_xxxxxxxxx

Request access:

info@diskoverdiagnostics.com

---

# Step 2 — Import Postman Collection

Download:

demandscape-postman-collection.json

Import into Postman.

---

# Step 3 — Configure Postman

Set:

partner_api_key = your partner key

Base URL:

https://demandscape-orchestrator.fly.dev/v1/infer

---

# Step 4 — Run First Forecast

Click:

Send

---

# Step 5 — Example Request

curl example:

```bash
curl https://demandscape-orchestrator.fly.dev/v1/infer \
  -H "Authorization: Bearer PARTNER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "inputs": {
      "data": {
        "month": ["2024-01","2024-02"],
        "product_id": ["P001","P001"],
        "market_id": ["M001","M001"],
        "units_sold": [100,null]
      },
      "parameters": {
        "prediction_length": 1
      }
    }
  }'
