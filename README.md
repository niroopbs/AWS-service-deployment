## Overview

## Choosing the best solution:
1. I tried 3 types of deployment Strategies for the task
     * Deployment using Lambda function 
     * Blue-Green Deployment 
     * Elastic Beanstalk deployment 

I have followed the below documents for deployment. 

 https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/bluegreen-deployments.html

 https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/rolling-deployments.html

 https://aws.amazon.com/quickstart/architecture/blue-green-deployment/

 https://aws.amazon.com/blogs/startups/how-to-use-blue-green-deployement-on-aws/

Finally, I have deployed via the Blue-Green deployment solution, and the details are as follows. 

# I have used the Blue/Green Deployment strategy with AWS Terraform Code Deploy
Blue-green deployment reduces downtime and risk

we are shifting the traffic from one to another and if we discover a problem in the new deployment we can always switch to the previous version. 

## In this task I'm using the following Infra setup:
1. VPC
2. two private subnets with default route NAT gateway and I have launched the EC2 instance with the subnet. 
3. Also I have created the Application Load Balancer (ALB) in the public subnet with the default route to the Internal Gateway. 
4. For the ALB at least two subnets in two different Availability Zones
5. I have created the user data script once the EC2 machine Boots up. 

![alt text](https://github.com/[username]/[reponame]/blob/[branch]/image.jpg?raw=true)

 ## Blue/Green Deployments 
Amazon Web Services offers services that enable organizations to leverage the power of the cloud for their development and deployment needs. AWS Code Deploy makes it possible to automate the deployment of code to either Amazon EC2 or on-premises instances. AWS Code Deploy now supports blue/green deployments. In this blog post, I will discuss the benefits of blue/green deployments and show you how to perform one.

![Alt text](image.png)

## Steps to execute the script
1. terraform init
2. terraform fmt
3. terraform validate 
4. terraform plan
5. terraform apply 

this will ask to provide the traffic distribution as per the example green-80 so that it will route the traffic between Frank 20% and Carol 80% will be distributed. 

## run the cmd to show the output
for i in `seq 1 10`; do curl app-lb-606515966.us-east-2.elb.amazonaws.com; done

Change the LB name once it's deployed

![Alt text](output.jpg)

![AWS deployment network](https://github.com/niroopbs/AWS-service-deployment/assets/50316430/76a494e1-2013-4445-8587-8934785e6528)

