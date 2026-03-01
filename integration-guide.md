# DemandScape Integration Guide

Version: 3.0  
Last Updated: March 2026  
Contact: info@diskoverdiagnostics.com

---

# Overview

DemandScape provides demand forecasting and commercial scenario simulation via REST API.

Partners send historical and planned commercial data to DemandScape.

DemandScape returns forecasts and scenario simulations ready for display in partner platform UI.

Typical integration time: **2–4 weeks**

---

# Base Endpoint

**Production**

```
https://demandscape-orchestrator.fly.dev/v1/infer
```

**Method**

```
POST /v1/infer
```

---

# Authentication

DemandScape uses a **single authentication layer**.

Include your partner API key as a Bearer token in the request header:

```
Authorization: Bearer PARTNER_API_KEY
```

Partners do **not** need a Hugging Face token. The Diskover Orchestrator (`demandscape-orchestrator.fly.dev`) handles all communication with the Hugging Face inference endpoint internally.

Each partner receives a unique API key.

Request access:

info@diskoverdiagnostics.com

## Architecture

```
Partner → Diskover Orchestrator (Fly.io) → Hugging Face → DeepAR Model → Response
```

---

# Request Structure

> **Important — data format**  
> `inputs.data` is **columnar** (a dict of arrays), not row-oriented.  
> Each key is a column name; each value is an array of values — one per time-step row.  
> All arrays must be the same length.

Example request body (2 historical months + 2 forecast months for one product-market series):

```json
{
  "inputs": {
    "data": {
      "month":                       ["2023-11", "2023-12", "2024-01", "2024-02"],
      "product_id":                  ["P001",    "P001",    "P001",    "P001"],
      "market_id":                   ["M001",    "M001",    "M001",    "M001"],
      "units_sold":                  [1100,      1200,      null,       null],
      "planned_price_index":         [1.0,        1.0,       1.0,       1.0],
      "planned_discount_pct":        [0,          0,         0,         0],
      "planned_promo_flag":          [0,          0,         0,         0],
      "planned_tender_flag":         [0,          0,         0,         0],
      "planned_supply_risk":         [0,          0,         0,         0],
      "planned_competitor_pressure": [0,          0,         0,         0],
      "planned_regulatory_event_flag":[0,         0,         0,         0]
    },
    "parameters": {
      "encoder_length": 12,
      "prediction_length": 6,
      "n_samples": 500,
      "quantiles": [0.1, 0.5, 0.9],
      "round_outputs": true,
      "scenarios": {
        "base": {},
        "price_up_10pct": { "planned_price_index": 1.1 }
      }
    }
  }
}
```

**Key rules:**

| Rule | Detail |
|------|--------|
| Historical rows | Set `units_sold` to the actual value |
| Forecast rows | Set `units_sold` to `null` — these are the months the model predicts |
| Minimum history | At least `encoder_length` rows (default 12) per product-market pair |
| Multiple series | Concatenate all series in the same arrays; the model groups by `product_id` + `market_id` |

---

# Required Input Fields

DemandScape requires time-series data per product and market.

| Field | Description | Example |
|------|-------------|---------|
| month | Time period | 2024-01 |
| product_id | Product identifier | P001 |
| market_id | Market identifier | M001 |
| units_sold | Historical units sold | 1200 |

For future periods:

```
units_sold = null
```

---

# Optional Planning Fields

These fields enable scenario simulation.

- planned_price_index
- planned_discount_pct
- planned_promo_flag
- planned_tender_flag
- planned_supply_risk
- planned_competitor_pressure
- planned_regulatory_event_flag

---

# Forecast Parameters

Required:

| Parameter | Description | Recommended |
|----------|-------------|-------------|
| encoder_length | Historical periods used | 12 |
| prediction_length | Forecast horizon | 6 |

Optional:

- n_samples
- quantiles

---

# Scenario Simulation

DemandScape supports multiple scenarios per request.

Example:

```json
"scenarios": {
  "price_up_5pct": {...},
  "growth_push": {...},
  "worst_case": {...}
}
```

DemandScape returns forecasts for each scenario.

---

# Response Structure

Example response:

```json
{
  "forecasts": [
    {
      "product_id": "P001",
      "market_id": "M001",
      "scenario": "base",
      "month": "2025-01",
      "point_mean": 1350,
      "p10": 1200,
      "p50": 1350,
      "p90": 1500,
      "confidence_score": 84,
      "confidence_label": "HIGH"
    }
  ]
}
```

---

# Integration Workflow

Typical integration process:

### Step 1 — Extract data

From:

- Salesforce
- SAP
- Snowflake
- Data warehouse

### Step 2 — Transform data

Convert to DemandScape input format.

### Step 3 — Call API

Send POST request.

### Step 4 — Store results

Recommended storage:

CRM custom object:

```
DemandScape_Forecast
```

or

Data warehouse table:

```
forecast_results
```

### Step 5 — Display results

Examples:

- CRM dashboard
- BI dashboard
- Forecast panel

---

# Rate Limits

Default:

```
10 requests per minute
100 requests per day
```

Custom limits available.

---

# Error Handling

| Code | Meaning |
|-----|--------|
| 401 | Invalid API key |
| 429 | Rate limit exceeded |
| 500 | Server error |

---

# Integration Example (cURL)

> Replace `PARTNER_API_KEY` with your credential.  
> The last `prediction_length` rows must have `units_sold: null`.

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
          "price_up_10pct": { "planned_price_index": 1.1 },
          "growth_push": { "planned_price_index": 0.95, "planned_discount_pct": 10, "planned_promo_flag": 1.0 }
        }
      }
    }
  }'
```

---

# Recommended Integration Platforms

DemandScape integrates with:

- Salesforce
- Power BI
- Tableau
- SAP
- Snowflake
- Databricks
- HubSpot

---

# Integration Support

Contact:

info@diskoverdiagnostics.com

---

# Integration Complete

DemandScape is now ready for production integration.
