### Streaming Retention & Funnel Analytics


https://github.com/user-attachments/assets/381f1dab-e670-44ca-89b3-653525ab1c4a


## 📌 Project Context
This project analyzes a subscription-based streaming platform with a focus on **user retention, conversion funnel efficiency, and revenue performance**.

The goal was to build a **clear analytical pipeline** from raw operational data to business-ready dashboards, keeping core logic in SQL and using BI only for interpretation and storytelling.

---

## 🎯 Business Goals
- Understand how users move through the product lifecycle
- Measure short- and long-term retention (D1, D7, D30)
- Identify major drop-off points in the conversion funnel
- Connect user activity to revenue outcomes

---

## 🛠 Tools & Stack
- **PostgreSQL** — data cleaning, modeling, analytical marts  
- **DBeaver** — SQL development  
- **Power BI** — data model, DAX, dashboards  

---

## 🧱 Data Model Overview
The analytical model follows a star-schema approach.

**Dimensions**
- `dim_users`
- `dim_date`

**Facts**
- `fact_sessions`
- `fact_events`
- `fact_payments`

**Analytical marts**
- retention (daily & summary)
- user cohorts
- conversion funnel
  
**Data Structure**

<img width="1112" height="692" alt="image" src="https://github.com/user-attachments/assets/a9d32aab-2713-4772-b6ad-533845e9dd10" />

---

## 📊 Dashboard Structure

### Overview
Provides a high-level view of **product health and revenue performance**.
Includes:
- DAU / WAU / MAU — to track engagement scale
- Revenue KPIs — to measure monetization
- Revenue trends — to identify growth or seasonality
- Revenue by country and plan — to understand concentration and segmentation
  
---

### Cohort Retention
Focused on **product quality and long-term engagement**.
Includes:
- Cohort retention heatmap (D0–D30) — to compare cohort behavior over time
- Retention KPIs (D7, D30) — to summarize engagement quality
- Retention curves — to analyze retention decay patterns
  
---

### Conversion Funnel
Analyzes **user progression from signup to purchase**.
Includes:
- Funnel visualization — to show volume at each stage
- Conversion rates — to measure step efficiency
- User loss by stage — to identify the main bottlenecks
  
---

## 💡 Insights

- The largest user drop-off happens before trial activation, likely due to unclear early value proposition or friction in accessing the trial during initial sessions.

- Retention decreases sharply after the first week, suggesting users engage initially but fail to form a sustained usage habit after onboarding.

- Revenue is concentrated in a limited number of countries and subscription plans, indicating differences in market maturity, purchasing power, or content relevance.

- Conversion after trial is relatively strong, implying that users who experience the full product value are more likely to convert, making early engagement the primary growth lever.

---

## ✅ Summary
This project demonstrates an end-to-end **product analytics workflow**:
- SQL-first approach for business logic
- Clean analytical data model
- Retention and funnel analysis at user level
- BI used for interpretation, not computation

The focus is on **answering business questions**, not just building visualizations.

---

## 📎 Assets
- Power BI dashboard (`.pbix`)
- SQL scripts for transformations and marts
- Analytical data model
