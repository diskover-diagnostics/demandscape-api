#!/bin/bash

API_KEY="YOUR_PARTNER_API_KEY"

curl -X POST "https://demandscape-orchestrator.fly.dev/v1/infer" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
  "inputs": {
    "data": {
      "month": [
        "2023-01","2023-02","2023-03","2023-04","2023-05","2023-06",
        "2023-07","2023-08","2023-09","2023-10","2023-11","2023-12",
        "2024-01","2024-02","2024-03","2024-04","2024-05","2024-06"
      ],
      "product_id": [
        "P001","P001","P001","P001","P001","P001",
        "P001","P001","P001","P001","P001","P001",
        "P001","P001","P001","P001","P001","P001"
      ],
      "market_id": [
        "US","US","US","US","US","US",
        "US","US","US","US","US","US",
        "US","US","US","US","US","US"
      ],
      "units_sold": [
        320,340,310,360,350,380,
        370,400,390,420,410,440,
        null,null,null,null,null,null
      ]
    },

    "parameters": {
      "encoder_length": 12,
      "prediction_length": 6,

      "scenarios": {
        "base": {},

        "price_up_5pct": {
          "planned_price_index": 1.05
        },

        "price_down_10pct": {
          "planned_price_index": 0.9
        },

        "discount_10pct": {
          "planned_discount_pct": 10
        },

        "promo_on": {
          "planned_promo_flag": 1.0
        },

        "growth_push": {
          "planned_price_index": 0.95,
          "planned_discount_pct": 10,
          "planned_promo_flag": 1.0
        },

        "worst_case": {
          "planned_price_index": 1.1,
          "planned_supply_risk": 1.0,
          "planned_competitor_pressure": 1.0
        }
      }
    }
  }
}'
