provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_user" "myUser" {
  name = "Bob"
}

resource "aws_iam_policy" "customPolicy" {
  name = "Glacier_ec2_EFS"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
            {
                  "Sid": "VisualEditor0",
                  "Effect": "Allow",
                  "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeSecurityGroups",
                  "ec2:DescribeVolumes",
                  "ec2:CreateVolume",
                  "ec2:CreateSnapshot",
                  "ec2:DeleteVolume",
                  "ec2:DeleteSnapshot"
                  ],
                  "Resource": "*"
            }
      ]
}
EOF

}

resource "aws_iam_policy_attachment" "policyBind" {
  name       = "attachment"
  users      = [aws_iam_user.myUser.name]
  policy_arn = aws_iam_policy.customPolicy.arn
}
