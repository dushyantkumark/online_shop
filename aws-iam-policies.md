# IAM USER : codepipeline-user
## Policies:
![image](https://github.com/user-attachments/assets/8ff483ab-87d7-4e98-9672-1be794a2d1b9)

-- aws-based-parameter-store

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ssm:GetParameter",
            "Resource": [
                "arn:aws:ssm:ap-south-1:<account-id>:parameter/myapp/aws-account-id",
                "arn:aws:ssm:ap-south-1:<account-id>:parameter/myapp/aws-region",
                "arn:aws:ssm:ap-south-1:<account-id>:parameter/myapp/ecr-repository/name"
            ]
        }
    ]
}

-- ecr-authentication-token-policy

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer"
            ],
            "Resource": "*"
        }
    ]
}

# CODE BUILD ROLE : codebuild-aws-shop-project-service-role
## Policies:
![image](https://github.com/user-attachments/assets/a69a75ff-43c4-46ef-85f4-4c2b402b0d4f)

-- CodeBuildBasePolicy-aws-shop-project-ap-south-1

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-south-1:<account-id>:log-group:/aws/codebuild/aws-shop-project",
                "arn:aws:logs:ap-south-1:<account-id>:log-group:/aws/codebuild/aws-shop-project:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-south-1-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::my-codepipeline-artifacts-03",
                "arn:aws:s3:::my-codepipeline-artifacts-03/*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-south-1:<account-id>:report-group/aws-shop-project-*"
            ]
        }
    ]
}

# CODE DEPLOY ROLE : amazonec2roleforawscodedeploy_onlineshop 
## Policies :
![image](https://github.com/user-attachments/assets/9319da32-0b42-411d-a4cb-664410573389)

-- aws-custom-parameter
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ssm:GetParameter",
            "Resource": [
                "arn:aws:ssm:ap-south-1:<account-id>:parameter/myapp/aws-account-id",
                "arn:aws:ssm:ap-south-1:<account-id>:parameter/myapp/aws-region",
                "arn:aws:ssm:ap-south-1:<accout-id>:parameter/myapp/ecr-repository/name"
            ]
        }
    ]
}

# ATTACH ROLE TO EC2 : amazon-ssm-code-deploy-role 
## Policies :
![image](https://github.com/user-attachments/assets/6a3494ac-1065-4cd4-9858-2455a1afe3fa)

