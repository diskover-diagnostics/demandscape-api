# DemandScape API Quickstart

Generate your first forecast in under 5 minutes.

DemandScape provides demand forecasting and scenario simulation via REST API.

---

# Step 1 — Get Credentials

You need:

## DemandScape Partner API Key

Used for authentication. Sent as a Bearer token in the `Authorization` header.

Format:

```
ds_partner_xxxxxxxxx
```

Partners do **not** need a Hugging Face token. The Diskover Orchestrator handles all communication with the AI model.

Request access:

info@diskoverdiagnostics.com

---

# Step 2 — Import Postman Collection

Download:

- demandscape-postman-collection.json
- demandscape-postman-environment.json

Open Postman → Import → Upload both files.

---

# Step 3 — Configure Environment

Select environment:

**DemandScape API – Production**

Set:

```
partner_api_key = your DemandScape API key
```

Base URL:

```
https://demandscape-orchestrator.fly.dev/v1/infer
```

---

# Step 4 — Run First Forecast

In Postman:

Select:

**1 – Base Forecast (single scenario)**

Click:

Send

---

# Step 5 — View Response

Example:

```json
{
  "forecasts": [
    {
      "product_id": "P001",
      "market_id": "M001",
      "scenario": "base",
      "point_mean": 450,
      "confidence_score": 84,
      "confidence_label": "HIGH"
    }
  ]
}
```

Success means integration is working.

---

# Step 6 — Run Scenario Simulation

Select:

**2 – Multi‑Scenario Forecast**

DemandScape will simulate:

- price changes
- discount changes
- promotion impact

---

# Step 7 — Run Strategic Scenarios

Select:

**3 – Strategic Scenarios Pack**

Simulates:

- growth strategy
- margin optimization
- worst case
- supply risk

---

# Step 8 — Production Integration Flow

Typical flow:

Extract data → Call DemandScape API → Store forecast → Display in dashboard

Data sources:

- Salesforce
- SAP
- Snowflake
- Data warehouse

---

# Step 9 — Test Using cURL

> `inputs.data` must be **columnar** — a dict of arrays, not a list of row objects.  
> The last `prediction_length` rows (default 6) must have `units_sold: null`.

```bash
curl https://demandscape-orchestrator.fly.dev/v1/infer \
  -H "Authorization: Bearer PARTNER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "inputs": {
      "data": {
        "month":                        ["2023-01","2023-02","2023-03","2023-04","2023-05","2023-06",
                                         "2023-07","2023-08","2023-09","2023-10","2023-11","2023-12",
                                         "2024-01","2024-02","2024-03","2024-04","2024-05","2024-06"],
        "product_id":                   ["P001","P001","P001","P001","P001","P001",
                                         "P001","P001","P001","P001","P001","P001",
                                         "P001","P001","P001","P001","P001","P001"],
        "market_id":                    ["M001","M001","M001","M001","M001","M001",
                                         "M001","M001","M001","M001","M001","M001",
                                         "M001","M001","M001","M001","M001","M001"],
        "units_sold":                   [320,340,310,360,350,380,
                                         370,400,390,420,410,440,
                                         null,null,null,null,null,null],
        "planned_price_index":          [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0],
        "planned_discount_pct":         [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_promo_flag":           [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_tender_flag":          [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_supply_risk":          [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_competitor_pressure":  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_regulatory_event_flag":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      },
      "parameters": {
        "encoder_length": 12,
        "prediction_length": 6,
        "n_samples": 500,
        "quantiles": [0.1, 0.5, 0.9],
        "round_outputs": true,
        "scenarios": { "base": {} }
      }
    }
  }'
```

---

# Step 9b — Multi-Scenario cURL Example

Run multiple named scenarios in a single request. DemandScape returns separate forecasts for each scenario.

```bash
curl https://demandscape-orchestrator.fly.dev/v1/infer \
  -H "Authorization: Bearer PARTNER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "inputs": {
      "data": {
        "month":                        ["2023-01","2023-02","2023-03","2023-04","2023-05","2023-06",
                                         "2023-07","2023-08","2023-09","2023-10","2023-11","2023-12",
                                         "2024-01","2024-02","2024-03","2024-04","2024-05","2024-06"],
        "product_id":                   ["P001","P001","P001","P001","P001","P001",
                                         "P001","P001","P001","P001","P001","P001",
                                         "P001","P001","P001","P001","P001","P001"],
        "market_id":                    ["M001","M001","M001","M001","M001","M001",
                                         "M001","M001","M001","M001","M001","M001",
                                         "M001","M001","M001","M001","M001","M001"],
        "units_sold":                   [320,340,310,360,350,380,
                                         370,400,390,420,410,440,
                                         null,null,null,null,null,null],
        "planned_price_index":          [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0],
        "planned_discount_pct":         [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_promo_flag":           [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_tender_flag":          [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_supply_risk":          [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_competitor_pressure":  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        "planned_regulatory_event_flag":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      },
      "parameters": {
        "encoder_length": 12,
        "prediction_length": 6,
        "n_samples": 500,
        "quantiles": [0.1, 0.5, 0.9],
        "round_outputs": true,
        "scenarios": {
          "base": {},
          "price_up_5pct":  { "planned_price_index": 1.05 },
          "price_up_10pct": { "planned_price_index": 1.10 },
          "discount_20pct": { "planned_discount_pct": 20 },
          "promo_on":       { "planned_promo_flag": 1.0 },
          "growth_push":    { "planned_price_index": 0.95, "planned_discount_pct": 10, "planned_promo_flag": 1.0 },
          "worst_case":     { "planned_price_index": 1.1, "planned_supply_risk": 1.0, "planned_competitor_pressure": 1.0 }
        }
      }
    }
  }'
```

Scenarios are defined inside `inputs.parameters.scenarios`. Each scenario name is a key, and each value is a dict of `planned_*` variable overrides applied only to forecast-horizon rows. The `base` scenario uses the input data as-is.

---

# Step 10 — Rate Limits

Default:

- 10 requests per minute
- 100 requests per day

---

# Step 11 — Common Errors

401 — Invalid API key

429 — Rate limit exceeded

---

# You're Ready

DemandScape is now ready to integrate with:

- Salesforce
- Power BI
- Tableau
- SAP
- Snowflake

---

# Support

info@diskoverdiagnostics.com

