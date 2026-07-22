-- Top cloud services by monthly cost
SELECT
  billing_month,
  cloud_provider,
  service_name,
  SUM(amortized_cost) AS total_cost
FROM cloud_cost_data
GROUP BY billing_month, cloud_provider, service_name
ORDER BY total_cost DESC;

-- Untagged spend by provider and owner
SELECT
  cloud_provider,
  owner,
  SUM(amortized_cost) AS untagged_cost
FROM cloud_cost_data
WHERE tag_status = 'untagged'
GROUP BY cloud_provider, owner
ORDER BY untagged_cost DESC;

-- Monthly cost by environment
SELECT
  billing_month,
  environment,
  SUM(amortized_cost) AS total_cost
FROM cloud_cost_data
GROUP BY billing_month, environment
ORDER BY billing_month, total_cost DESC;

-- Cost center showback view
SELECT
  billing_month,
  cost_center,
  SUM(amortized_cost) AS showback_cost
FROM cloud_cost_data
GROUP BY billing_month, cost_center
ORDER BY billing_month, showback_cost DESC;