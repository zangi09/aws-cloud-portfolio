import pandas as pd

def load_cost_data(file_path: str) -> pd.DataFrame:
    """Load sample multi-cloud cost data from CSV."""
    return pd.read_csv(file_path)

def validate_required_columns(df: pd.DataFrame) -> None:
    """Validate required FinOps reporting fields."""
    required_columns = [
        "billing_month",
        "cloud_provider",
        "service_name",
        "environment",
        "cost_center",
        "owner",
        "amortized_cost",
        "tag_status",
    ]

    missing_columns = [column for column in required_columns if column not in df.columns]

    if missing_columns:
        raise ValueError(f"Missing required columns: {missing_columns}")

def summarize_monthly_cost(df: pd.DataFrame) -> pd.DataFrame:
    """Aggregate cost by month, provider, and service."""
    return (
        df.groupby(["billing_month", "cloud_provider", "service_name"])["amortized_cost"]
        .sum()
        .reset_index()
        .sort_values("amortized_cost", ascending=False)
    )

def identify_untagged_spend(df: pd.DataFrame) -> pd.DataFrame:
    """Identify untagged cloud spend for governance follow-up."""
    return (
        df[df["tag_status"] == "untagged"]
        .groupby(["cloud_provider", "owner", "service_name"])["amortized_cost"]
        .sum()
        .reset_index()
        .sort_values("amortized_cost", ascending=False)
    )

if __name__ == "__main__":
    cost_data = load_cost_data("sample-cost-data.csv")
    validate_required_columns(cost_data)

    monthly_summary = summarize_monthly_cost(cost_data)
    untagged_spend = identify_untagged_spend(cost_data)

    print("Monthly Cost Summary")
    print(monthly_summary)

    print("\nUntagged Spend")
    print(untagged_spend)
    