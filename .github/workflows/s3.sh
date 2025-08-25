name: solar system workflow

on:
    workflow_dispatch:
    push:
        branches:
            - feature-branchA
            - main

jobs:
    S3:
        name: Create S3
        runs-on: ubuntu-latest

        steps:
            - name: checkout repo
              uses: actions/checkout@v5

            - name: Configure AWS Credentials
              uses: aws-actions/configure-aws-credentials@v4.3.1
              with:
                aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
                aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
                aws-region: us-west-2            