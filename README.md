# DemandScape API - Superseded by the new Demandscape suite api - https://github.com/diskover-diagnostics/demandscape-suite-api

DemandScape provides demand forecasting and commercial scenario simulation via REST API.

DemandScape enables platforms, system integrators, and analytics providers to integrate forecasting directly into their existing user interfaces.

---

# Quickstart

Run your first forecast in 5 minutes:

[Quickstart Guide](./QUICKSTART.md)

---

# Base Endpoint

```
https://demandscape-orchestrator.fly.dev/v1/infer
```

Method:

```
POST /v1/infer
```

---

# Authentication

DemandScape uses a single authentication layer.

Partner API key as Bearer token:

```
Authorization: Bearer PARTNER_API_KEY
```

Partners do **not** need a Hugging Face token. All requests go through the Diskover Orchestrator.

---

# Documentation

Integration Guide:

./integration-guide.md

Partner Pack:

./partner-pack.md

OpenAPI Specification:

./openapi.yaml

Postman Collection:

./postman_collection.json

Sample Data:

./samples/

---

# What DemandScape Predicts

DemandScape forecasts:

• units sold  
• confidence intervals  
• forecast risk  

across:

• products  
• markets  
• scenarios  

---

# Supported Platforms

DemandScape integrates with:

• Salesforce  
• SAP  
• Snowflake  
• Power BI  
• Tableau  
• Databricks  
• HubSpot  

---

# Postman Quick Test

Import:

postman_collection.json

Set environment variable `partner_api_key` and run:

Run Forecast

---

# Integration Time

Typical integration time:

1–4 weeks

---

# Architecture

Partner → Diskover Orchestrator (Fly.io) → Hugging Face → DeepAR Model → Response

See:

demandscape_architecture_diagram.png

---

# Request Access

info@diskoverdiagnostics.com

---

# License

Copyright DemandScape

All rights reserved.
