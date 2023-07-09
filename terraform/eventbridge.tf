
# Create the EventBridge rule
resource "aws_cloudwatch_event_rule" "salesforce_events_rule" {
  name        = "salesforce-${var.environment}-CDC-events-to-s3"
  description = "EventBridge rule for collecting Salesforce events"

  event_pattern = <<PATTERN
{
  "source": ["aws.partner/salesforce.com"]
}
PATTERN
}

# Create the CloudWatch Logs group
resource "aws_cloudwatch_log_group" "salesforce_events_logs" {
  name = "salesforce-${var.environment}-CDC-event-logs"
}


# Create the IAM role for EventBridge
resource "aws_iam_role" "salesforce_events_role" {
  name = "salesforce-${var.environment}-events-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attach the necessary IAM policy to the role
resource "aws_iam_role_policy_attachment" "salesforce_events_policy_attachment" {
  role       = aws_iam_role.salesforce_events_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create the EventBridge target
resource "aws_cloudwatch_event_target" "salesforce_events_target" {
  rule      = aws_cloudwatch_event_rule.salesforce_events_rule.name
  target_id = "salesforce-${var.environment}-CDC-event-logs"
  arn       = aws_cloudwatch_log_group.salesforce_events_logs.arn
}

