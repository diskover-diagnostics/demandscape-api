# DemandScape Partner Pack

Version: 1.0  
Last Updated: February 2026  
Contact: info@diskoverdiagnostics.com

---

# Overview

DemandScape is an API-first demand forecasting and commercial scenario simulation engine designed for integration into CRM, ERP, RevOps, and analytics platforms.

DemandScape enables partners to provide advanced forecasting capabilities without building models internally.

---

# What DemandScape Provides

DemandScape delivers:

Demand forecasts  
Price impact simulation  
Discount optimization analysis  
Promotion planning insights  
Supply and competitor risk analysis  

---

# Forecast Outputs

DemandScape predicts:

Future units sold  
Confidence intervals  
Forecast risk indicators  

Forecasts are generated across combinations of:

Product  
Market  
Scenario  

Example output fields:

point_mean  
p10, p50, p90  
confidence_score  
confidence_label  
requires_review  

These outputs are designed for platform dashboards.

---

# Scenario Simulation

DemandScape allows partners to simulate commercial strategies.

Supported scenarios include:

Price increase or decrease  
Discount changes  
Promotion activation  
Tender wins  
Supply risk  
Competitor pressure  

Multiple scenarios can be submitted in a single request.

DemandScape returns forecasts for each scenario.

---

# Integration Architecture

Typical partner integration:

Customer Platform  
(Salesforce, SAP, Snowflake, Power BI)

↓

Partner Integration Layer  
(API connector / ETL)

↓

DemandScape API

↓

Forecast Results

↓

Displayed in Partner Platform UI

DemandScape integrates without disrupting existing workflows.

---

# API Overview

DemandScape uses REST API.

Base URL:

https://i3302d3uxvtjxwjm.us-east-1.aws.endpoints.huggingface.cloud

Authentication:

Authorization: Bearer HF_TOKEN

Partner API key included in request body:

"x-api-key": "PARTNER_API_KEY"

---

# Input Requirements

Required fields:

month  
product_id  
market_id  
units_sold  

Optional planning fields:

planned_price_index  
planned_discount_pct  
planned_promo_flag  
planned_tender_flag  
planned_supply_risk  
planned_competitor_pressure  
planned_regulatory_event_flag  

**Data format — columnar (dict of arrays)**

`inputs.data` is a dict where each key is a column and each value is an array of values — one per time-step row. This is different from row-oriented (list of objects) format.

Example:

```json
{
  "x-api-key": "PARTNER_API_KEY",
  "inputs": {
    "data": {
      "month":        ["2023-11", "2023-12", "2024-01", "2024-02"],
      "product_id":   ["P001",    "P001",    "P001",    "P001"],
      "market_id":    ["M001",    "M001",    "M001",    "M001"],
      "units_sold":   [1100,      1200,      null,      null]
    },
    "parameters": {
      "encoder_length": 12,
      "prediction_length": 6,
      "scenarios": { "base": {} }
    }
  }
}
```

Rules:

- All arrays must be the same length
- Provide at least 12 historical rows per product-market pair (`encoder_length`)
- Set `units_sold = null` for the last `prediction_length` rows (forecast horizon)
- Multiple product-market series are concatenated into the same arrays

---

# Integration Timeline

Typical integration time:

2–4 weeks

Steps:

Extract data  
Call API  
Store results  
Display forecasts  

---

# Sandbox Access

Sandbox access includes:

API key  
Sample dataset  
Postman collection  
Example scenarios  

Request access:

info@diskoverdiagnostics.com

---

# Supported Platforms

DemandScape integrates with:

Salesforce  
SAP  
Power BI  
Tableau  
Snowflake  
Databricks  
HubSpot  
Custom enterprise platforms  

---

# Security

DemandScape provides:

Encrypted communication  
Tenant isolation  
Secure authentication  

DemandScape does not require personally identifiable information.

---

# Partner Benefits

Partners can:

Add forecasting capabilities immediately  
Increase platform value  
Offer scenario planning features  
Avoid building forecasting models  

DemandScape provides intelligence. Partners provide UI.

---

# Demo Video

https://youtu.be/nXTGkbKHJpM

---

# Contact

info@diskoverdiagnostics.com

---

# Next Steps

Review:

Integration Guide  
Quickstart Guide  
OpenAPI Specification  
Postman Collection  

Request sandbox access to begin integration.