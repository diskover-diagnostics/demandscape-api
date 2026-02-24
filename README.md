# demandscape-api
DemandScape is an API-first demand forecasting and commercial scenario simulation engine. Integrates with Salesforce, SAP, Snowflake, and RevOps platforms to predict demand, simulate pricing and promotion scenarios, and deliver forecast insights via REST API. Includes OpenAPI spec, Postman collection, and integration docs.

DemandScape provides demand forecasting and commercial scenario simulation via REST API.

DemandScape enables platforms, system integrators, and analytics providers to integrate forecasting directly into their existing user interfaces.

---

# Quickstart

Run your first forecast in 5 minutes:

[Quickstart Guide](./QUICKSTART.md)

---

# Base Endpoint

```
https://i3302d3uxvtjxwjm.us-east-1.aws.endpoints.huggingface.cloud
```

Method:

```
POST /
```

---

# Authentication

DemandScape uses two authentication layers.

Infrastructure authentication:

```
Authorization: Bearer HF_TOKEN
```

Partner authentication:

```
"x-api-key": "PARTNER_API_KEY"
```

---

# Documentation

Integration Guide:

./guides/integration-guide.md

Partner Pack:

./partner-pack/partner-pack.md

OpenAPI Specification:

./openapi.yaml

Postman Collection:

./postman/

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

postman/demandscape-postman-collection.json

and run:

Base Forecast

---

# Integration Time

Technical integration: a few hours

Typical production deployment: 1–4 weeks, depending on partner platform, UI implementation, and customer rollout.

---

# Architecture

See:

images/architecture-diagram.png

---

# Request Access

info@diskoverdiagnostics.com

---

# License

Proprietary – All rights reserved.

© 2026 Diskover Diagnostics

