import boto3
from datetime import datetime, timedelta, timezone

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    retention_days = 30
    cutoff_date = datetime.now(timezone.utc) - timedelta(days=retention_days)

    snapshots = ec2.describe_snapshots(OwnerIds=['self'])['Snapshots']

    deleted = []

    for snapshot in snapshots:
        start_time = snapshot['StartTime']
        snapshot_id = snapshot['SnapshotId']

        # Check tag to skip deletion
        tags = snapshot.get('Tags', [])
        keep = any(tag['Key'] == 'Keep' and tag['Value'] == 'True' for tag in tags)

        if start_time < cutoff_date and not keep:
            ec2.delete_snapshot(SnapshotId=snapshot_id)
            deleted.append(snapshot_id)

    return {
        "deleted_snapshots": deleted
    }