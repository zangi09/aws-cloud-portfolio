# AWS Native FinOps Tool Review

## Purpose

This review documents AWS-native tools used to support cloud cost visibility, anomaly detection, budgeting, rightsizing, and governance.

## Tools Reviewed

| AWS Tool | FinOps Purpose | What I Reviewed | Finding | Recommendation |
|---|---|---|---|---|
| Cost Explorer | Cost visibility and trend analysis | Spend by service, daily/monthly trends, forecast | Account showed $30.43 across 19 services | Continue monitoring by service and usage type |
| AWS Budgets | Budget control and alerting | Monthly budget and alert threshold concept | Budgeting supports early spend awareness | Create monthly actual and forecasted alerts |
| Cost Anomaly Detection | Detect abnormal spend patterns | Anomaly monitor and alert setup | Useful for unexpected service spikes | Configure service-level anomaly monitor |
| Cost Allocation Tags | Cost ownership and showback | Tag activation and governance readiness | Tags support owner/cost center reporting | Standardize tags for owner, environment, app, and cost center |
| Compute Optimizer | Rightsizing recommendations | Resource recommendation availability | Supports rightsizing for supported resources | Review recommendations before resizing |
| Trusted Advisor | Cost optimization checks | Cost optimization dashboard/checks | Support-plan dependent visibility | Use as another validation source |
| Data Exports / CUR | Detailed billing data layer | CUR/data export concept | Enables SQL-based billing analysis | Export billing data to S3 for Athena/QuickSight analysis |

## Key Takeaway

AWS-native FinOps tooling supports different parts of the operating model. Cost Explorer helps analyze spend, Budgets and Anomaly Detection support alerting, Cost Allocation Tags support ownership and showback, Compute Optimizer and Trusted Advisor support optimization, and CUR/Data Exports support deeper SQL-based cost analysis.