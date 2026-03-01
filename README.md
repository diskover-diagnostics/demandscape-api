# DemandScape API

DemandScape provides demand forecasting and commercial scenario simulation via REST API.

DemandScape is accessed securely via the Diskover Orchestrator layer.

Partners DO NOT need HuggingFace tokens.

---

# Base Endpoint

Production:

https://demandscape-orchestrator.fly.dev/v1/infer

Method:

POST

---

# Authentication

Single authentication layer:

Authorization header:

Authorization: Bearer PARTNER_API_KEY

Each partner receives a unique API key.

Request access:

info@diskoverdiagnostics.com

---

# Architecture

Partner Platform
↓
Diskover DemandScape Orchestrator (Fly.io)
↓
Hugging Face Inference Endpoint (internal)
↓
Forecast Engine

Partners never access HuggingFace directly.

---

# Quickstart

Run your first forecast:

See:

QUICKSTART.md

---

# Documentation

Integration Guide:

guides/integration-guide.md

Partner Pack:

partner-pack/partner-pack.md

OpenAPI Specification:

openapi.yaml

Postman Collection:

postman/

---

# What DemandScape Predicts

DemandScape forecasts:

• Units sold  
• Confidence intervals  
• Forecast risk indicators  

Across:

• Products  
• Markets  
• Scenarios  

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

# Integration Time

Typical integration time:

1–2 weeks

---

# Request Access

info@diskoverdiagnostics.com

---

# License

Copyright Diskover Diagnostics

All rights reserved.
