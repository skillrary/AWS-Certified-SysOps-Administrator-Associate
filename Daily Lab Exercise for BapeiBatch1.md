Table of contents
=================
- [Day1:](#day1)
    + [Commands Used](#commands-used)
- [Day2](#day2)
   * [Create instance profile](#create-instance-profile)
   * [Add role to instance profile](#add-role-to-instance-profile)
   * [Remove role from instance profile](#remove-role-from-instance-profile)
   * [Delete instance profile](#delete-instance-profile)
- [Day3](#day3)
  * [Exercise 1: Create Custom VPC and test Bastion Host and Nat Gateway](#exercise-1--create-custom-vpc-and-test-bastion-host-and-nat-gateway)
  * [Exercise 2: Create Custom Metric](#exercise-2--create-custom-metric)
  * [Exercise 3: Install Unified Cloudwatch Agend for EC2](#exercise-3--install-unified-cloudwatch-agend-for-ec2)
    + [Commands used: Day3](#commands-used-day3)
- [Day 4:](#day-4)
  * [Exercise 1: Create and invoke a serverless Lambda function using Amazon SNS](#exercise-1--create-and-invoke-a-serverless-lambda-function-using-amazon-sns)
  * [Exercise 2: Configured Lambda function to run on a scheduled event](#exercise-2--configured-lambda-function-to-run-on-a-scheduled-event)
- [Day 5:](#day-5)
  * [Exercise 1: Create an Application Load Balancer (ALB)](#exercise-1--create-an-application-load-balancer--alb)
  * [Exercise 2: Enable Path based Routing](#exercise-2--enable-path-based-routing)
  * [Exercise 3: Enable Sticky Sessions on ELB](#exercise-3--enable-sticky-sessions-on-elb)
  * [Exercise 4: Create ASG](#exercise-4--create-asg)
  * [Exercise 5: Add scaling policy and cause scaling events](#exercise-5--add-scaling-policy-and-cause-scaling-events)
- [Day 6:](#day-6)   
  * [Exercise 1: Creating and resizing Amazon EBS volumes](#exercise-1-creating-and-resizing-amazon-ebs-volumes)
  * [Exercise 2: Create a snapshot and AMI](#exercise-2-create-a-snapshot-and-ami)
  * [Exercise 3: Create an encrypted Volume and create a snapshot either encrypted or unencrypted with a custom key](#exercise-3-create-an-encrypted-volume-and-create-a-snapshot-either-encrypted-or-unencrypted-with-a-custom-key)
  * [Exercise 4: Creating and mounting EFS filesystem](#exercise-4-creating-and-mounting-efs-filesystem)
- [Day 7:](#day-7)   
  * [Exercise 1: Create Systme Manager Configuration](#exercise-1-create-systme-manager-configuration)
  * [Exercise 2: Create Tags and Resource Group](#exercise-2-create-tags-and-resource-group)
  * [Exercise 3: Systems Manager Automation](#exercise-3-systems-manager-automation)
  * [Exercise 4: System Manager Run Command](#exercise-4-system-manager-run-command)
- [Day 8:](#day-8)   
  * [Exercise 1: Configure Patching in Systems Manager](#exercise-1-configure-patching-in-systems-manager)
  * [Exercise 2: Configure Custom Compliance Rule](#exercise-2-configure-custom-compliance-rule)
  * [Exercise 3: Use Secure Shell](#exercise-3-use-secure-shell)
  * [Exercise 4: Create Parameters using Parameter Store](#exercise-4-create-parameters-using-parameter-store)
  * [Exercise 5: Use Lambda Function to retrieve data from Parameter store](#exercise-5-use-lambda-function-to-retrieve-data-from-parameter-store)
  * [Exercise 6: Create a ElasticBeanstalk Enviromment](#exercise-6-create-a-elasticbeanstalk-enviromment)
- [Day 9:](#day-9)   
  * [Exercise 1: Beanstalk Swap URL's](#exercise-1-beanstalk-swap-urls)
  * [Exercies 2: Add a custom domain name for Beanstalk application](#exercies-2-add-a-custom-domain-name-for-beanstalk-application)
  * [Exercise 3: Create Worker tier](#exercise-3-create-worker-tier)
  * [Exercise 4: Created a Multie Tier HA application](#exercise-4-created-a-multie-tier-ha-application)
- [Day 10:](#day-10)   
  * [Exercise 1: Create and Update Stacks](#exercise-1-create-and-update-stacks)
  * [Exercise 2: Mapping and Parameters](#exercise-2-mapping-and-parameters)
  * [Exercise 3: Create stack with parameters](#exercise-3-create-stack-with-parameters)
  * [Exercise 4: Change sets and Drift Detection](#exercise-4-change-sets-and-drift-detection)
  * [Exercise 5: Create Stack with user data](#exercise-5-create-stack-with-user-data)  
  * [Exercise 6: Rollback and Stack creation failures](#exercise-6-rollback-and-stack-creation-failures)

# Day1:                                                
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)
   1. Create a Policy for SysOperations -- Used existing policy for SystemAdministration    
   2. Create a group for SysOps
   3. Create a User and assign the group

   4. Install AWS CLI

   5. Create EC2 Instance with Shutdown as Terminate. Try to terminate the instance from Management Console, Login to EC2 instance from command prompt and execute shutdown command as root. Test the behaviour. 

### Commands Used
      1. sudo su - -->Change the user to root
      2. shutdown --> use this command to shutdown from server

# Day2  
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)
1. Change Instance Type from t2.micro to any instance and test
2. Know where to choose/create Spot, Reserved, Dedicated hosts and Savings Plan. 
3. Know where configure Dedicated host/instance


4. Create EC2 instance, stop and start the instance and recognize release of public IP from the instance.
   Create Elastic IP and associate it with EC2 instance. Stop and Start to check if IP gets released.
  

5. Create 2 EC2 Instances, Create One Elastic IP and Elastic Network Interface. 
   Associate Elastic IP with ENI
   Attach the ENI to one of the EC2 Instance
   Shutdown the one with ENI
   Detach ENI from the stopped EC2 and associate it with the one which in running state
   
6a. Create an EC2 instance
   Create a secret key
   Use aws configure to apply the key
   execute following commands


         ssh -i "XXXX.pem" YYYYYYY.compute-1.amazonaws.com

         aws s3 ls
         aws s3 ls s3://yourbucketname

         clear

         cd ~/.aws
         ls -ltr
         cat config
         cat credentials
         rm -rf credentials
 
   Try accessing aws s3 ls and this would not work

6b. Create a role and attache S3Readonly policy to the role
    Attach the new role to the EC2 instance and then try to execute the following command
        aws s3 ls

7. Create an instance profile from the command line, this would not work as aws cli is not configured.
   Execute aws configure
   Enter AccessID and Secret key
   Now execute following command to create instance profile and add a role to it
   ###### Create instance profile
      aws iam create-instance-profile --instance-profile-name mytestinstanceprofile
   ###### Add role to instance profile
      aws iam add-role-to-instance-profile --role-name S3ReadOnly --instance-profile-name mytestinstanceprofile
   
   Once done use the command to delete the role from instance profile and also delete instance profile
   ###### Remove role from instance profile
      aws iam remove-role-from-instance-profile --role-name S3ReadOnly --instance-profile-name mytestinstanceprofile
   ###### Delete instance profile
      aws iam delete-instance-profile --instance-profile-name mytestinstanceprofile
      
      
   
# Day3 
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)
## Exercise 1: Create Custom VPC and test Bastion Host and Nat Gateway

1. Create a VPC with the configuration as per the link(github https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/custom-vpc.txt) provided
2. Create Ec2 instance in both Public and Private Subnet
3. SSH to EC2 instance in Private subnet from EC2 in Public subnet (Copy PEM file to Public EC2 instance and then try to SSH)
4. Try accessing google.com from the command prompt using the ping utility
   ping google.com
   You will see that it is not accessible.

5. Create a NAT gateway and map the id in the private route table
6. Try pinging google again to test if a private EC2 instance is able to access the internet


## Exercise 2: Create Custom Metric
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/aws-cli-put-metric-data.sh
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/mem.sh

1. Created Custom Metric. Use the above link to do the same.
2. Execute the command the following command
      aws cloudwatch put-metric-data --metric-name MyBytes --namespace MyNameSpace --unit Bytes --value 231434333 --dimensions InstanceId=1-23456789,InstanceType=m1.small
3. Goto Cloudwatch and see if it has created a new namespace 
4. Now create a new EC2 instance and create mem.sh file with the following 2 lines.

  ```
      USEDMEMORY=$(free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }')

      aws cloudwatch put-metric-data --metric-name memory-usage --dimensions Instance=i-0542ea1e32c310c93  --namespace "EC2-Mem" --value $USEDMEMORY
```

5. Save the file and create a crontab entry using the following command
      crontab -e
6. Add the line below to crontab entry 
       */1 * * * * /home/ec2-user/mem.sh
7. Save it and test if the entry is intact in crontab
      crontab -l
9. Exectue steps from github url to put some load or stress on the system. Execute the following commands one after the other.

      sudo amazon-linux-extras install epel -y
      sudo yum install stress-ng -y
      stress-ng --vm 10 -c 10 --vm-bytes 80% --vm-method all --verify -t 60m -v

   Now wait for the data to be published to CloudWatch

10. Verify if you see all the data in CloudWatch
11. Create an alarm for memory utilization and trigger an email through SNS topic
12. In this instance standard monitoring create another alarm for CPU utilization. Also configure action to be performed. Choose to termiante the instance.
13. Verify if the instance gets terminated

## Exercise 3: Install Unified Cloudwatch Agent for EC2
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/cloudwatch-agent-windows-install.sh

1. Create a new Windows environment. Choose free tier windows 2019 base/ (Make sure to disable IE security from Server Management on Windows)
2. Download Cloudwatch Agent from the url below and install, 
https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi
3. Configure Cloudwatch agent using Cloudwatch Agent wizard under Amazon directory in Program files under c drive. 
4. Execute the following line from windows powershell
      & "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -s -c file:"C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json"

5. Go back to the Cloudwatch console and wait for metrics to be shown

### Commands used: Day3
    1  aws s3 ls
    2  aws configure
    3  clear
    4  aws s3 ls
    5  aws s3 ls s3://srbapeitest
    6  cd ~/.aws
    7  ls -ltr
    8  cat config
    9  cat credentials
    10  ls -ltr
    11  rm -rf credentials
    12  ls -ltr
    13  aws s3 ls
    14  aws s3 ls
    15  exit
    16  free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }'
    17  free -m
    18  free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }'
    19  exit
    20  ls -ltr
    21  ./mem.sh
    22  crontab -e
    23  crontab -l

# Day 4:  
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)

## Exercise 1: Create and invoke a serverless Lambda function using Amazon SNS

   1. Create a Lambda Function and copy the code from the link below,  
      https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/AWS%20Lambda/write-to-cloudwatch-logs.js
   2. Create an SNS topic and configure the target or subscriber. Use the Lambda function created above
   3. Check if Lamdba function has the trigger from step 2. 
   4. Publish a message on the SNS topic created
   5. On the Lambda console go to Monitoring for the Lambda function created. Click on Monitor logs in Cloudwatch. Check if the published message is available in Cloudwatch logs



## Exercise 2: Configured Lambda function to run on a scheduled event

   1. Create a Lambda Function and copy the code from the link below,  
      https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/AWS%20Lambda/scheduled-execution.js
   2. Create an SNS topic and configure the target or subscriber. Use the Lambda function created above
   3. Check if Lamdba function has the trigger from step 2. 
   4. On the Lambda console go to Monitoring for the Lambda function created. Click on Monitor logs in Cloudwatch. Check if the published message is available in Cloudwatch logs



# Day 5:    
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)

## Exercise 1: Create an Application Load Balancer (ALB)

   1. Create an S3 bucket and upload all the files from the link below,
   https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/tree/main/Elastic%20Load%20Balancing%20and%20Auto%20Scaling/Website
   2. Create 2 ec2 instnace in differnt subnet and all the following user data,
   
```
       #!/bin/bash
       yum update -y
       yum install httpd -y
       systemctl start httpd
       systemctl enable httpd
       cd /var/www/html
       aws s3 cp s3://skillrary-lab-bapei-elb/names.csv ./
       aws s3 cp s3://skillrary-lab-bapei-elb/index.txt ./
       EC2NAME=`cat ./names.csv|sort -R|head -n 1|xargs`
       sed "s/INSTANCEID/$EC2NAME/" index.txt > index.html
```  
     
   make sure you assign S3Readonly role to each of these instances.

   3. Create a new LB configuration with a new Template Group



## Exercise 2: Enable Path based Routing

   1. Create a new ec2 instance add the code below for user data section,
```
   #!/bin/bash
   yum update -y
   yum install httpd -y
   systemctl start httpd
   systemctl enable httpd
   cd /var/www/html
   aws s3 cp s3://skillrary-lab-bapei-elb/names.csv ./
   aws s3 cp s3://skillrary-lab-bapei-elb/index.txt ./
   EC2NAME=`cat ./names.csv|sort -R|head -n 1|xargs`
   sed "s/INSTANCEID/$EC2NAME/" index.txt > index.html
   cp index.html orders.html
```
   2. Create a new target group and add the ec2 instance created above

   3. Go to ELB configuration and edit the listener rule
      Add a new rule, choose the path and add the necessary details and save


## Exercise 3: Enable Sticky Sessions on ELB

   1. Get to ELB attributes and enable sticky session


## Exercise 4: Create ASG

   1. Create a new ASG under Autoscaling Group Console
   
          a. Give it a name 
          b. Click on Create a launch template, as we do not have a launch template.   
          c. Enter all the details for Launch Template like Name, AMI, Instance Type, Select Key Pair, Security Group, Role with S3 access, and in advance details add User data details with the link below. 

          https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Elastic%20Load%20Balancing%20and%20Auto%20Scaling/user-data-to-create-index-html-with-names.sh 

          d. Once the launch template is created, go back to step 1 to create a ASG 
          e. Adhere to launch template, choose subnets 
          f. Application Load Balancer select the right template group 
          g. Configure group size and scaling policies add desired, minimum and maximum capacity 
          h. Review the configuration and create ASG.  

   This will launch the instances in EC2. 

## Exercise 5: Add scaling policy and cause scaling events

   1. Goto ASG console
   2. Click on the ASG created earlier
   3. Goto Automatic Scaling and choose Dynamic Scaling and, create a Scaling policy
   4. Select Policy type as Target tracking scaling, Average CPU to 50 and create the policy
   5. Go back to details of ASG and increase the maximum capacity for ASG to atleast 6

   6. Terminate one of the EC2 instances, this should create a new instance
   7. Monitor Activity under ASG created and Target Group to see new instance is added to the target group as well
   8. Generate load on each EC2 instance by getting inside the instance and executing the commands for stressing the servers with the link below,
   https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Elastic%20Load%20Balancing%20and%20Auto%20Scaling/generate-load-on-asg.sh

   Monitor the systems to see more instances created.

   Make sure you delete all the instances and configurations created till now. 


# Day 6:   
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)

## Exercise 1: Creating and resizing Amazon EBS volumes

   1. Launch a windows 2019 base free tier instance
   2. Create a new volume with IO1 volume type in the same AZ of the windows instance launched in step1
   3. Once the volume is available go ahead and attach it to the instance created in step1
   4. Login to windows instance created in step1 and open Disk Management utility(create and format hard disk partitions)
   5. Right click on the hardisk name and click on online, righ click again and choose initialize the disk and finally create the volume
   6. Come back to EC2 console and choose the volume created in step2 and click on actions and choose modify volume, increase the size
   7. Refresh the diskmanagement under the OS and you will be able to see the extra space allocated
   8. Right Click on the disk and extend the partition


## Exercise 2: Create a snapshot and AMI

   1. Shutdown the instance created in Exercise1, Step1. 
   2. Goto Volumes and choose the primary volume and create a snapshot
   3. Goto snapshots and create an image out of the snapshot
   4. Goto AMI console and launch an instance on a separate AZ using the AMI created

Clear all the instances, snapshots, AMI created from Exercise1 and Exercise2


## Exercise 3: Create an encrypted Volume and create a snapshot either encrypted or unencrypted with a custom key

   1. Create a new encrypted volume with a custom key, you will have to go to KMS Service to create a new key
   2. Once the volument is created, create a new snapsnot

Try create unencrypted or encrypted snapshots from it.


## Exercise 4: Creating and mounting EFS filesystem

   1. Goto EFS Service and create an EFS file system
   2. Create 2 EC2 instance on separate AZ
   3. Use code the below and execute all the commands in the link below,
      https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Amazon%20EFS/connect-to-efs-filesystem.sh
Make sure you change the EFS id in the command.

   4. Mounting EFS takes time, we need to goto default security group and add a rule in inbound rule to inclue NFS port exposed to sercurity group used to create ec2 instance
   5. Try mounting it again and it will work

Playaround with the EFS, create file from one instance and you should be able to find it in another one. 


# Day 7:    
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)

## Exercise 1: Create Systme Manager Configuration
   1. Goto Systems Manager and Click on Quick Setup
   2. With the default setting create the configuration


## Exercise 2: Create Tags and Resource Group
   1. Create 2 Linux and 2 Windows instances
   2. Add Name and Environment tag for each of these instance like DevLin01, ProdLin02, DevWin01, ProdWin01
   3. Create a new role and add a policy for SSM (AmazonEC2RoleforSSM)
   4. Attach the role to all 4 EC2 servers created. (You can first create the role and assign the same while creating the instances)
   5. Come back to Systems Manager console and goto Fleet Manager to see the instances being managed. (This may take around 30mins to appear)


## Exercise 3: Systems Manager Automation
   1. Goto Documents sections in Systems Manager(Last option in the Menu item)
   2. Search for AWS Stop ec2 instnace document and execute, while selecting instance select only one and finish the activity
   3. Goto EC2 console and see if this instance is stopped
   4. Come back to Documents and search for EC2 start instance document and execute the same to see if the instance starts up


## Exercise 4: System Manager Run Command
   1. Goto Run Command under System Manager
   2. Click on Run command and choose AWS-FindWindowsUpdates command, choose update level to all
   3. For Specify instance tag, specify production environment
   4. Configure Rate control to 4
   5. Deselect write to S3 bucket as we do not need this option
   6. Go ahead and execute
     Observe that Linux Ec2 has failed and wait for the command to complete. 
   7. Come back to run command once the previous command is done
   8. Select AWS-InstallMissingWindowsUpdates command and execute it on Production environment. Make sure to select all the options which were selected in the previous command run.
     Observe new patch application.  
     
     
# Day 8: 
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)

## Exercise 1: Configure Patching in Systems Manager
1. Goto Patch Manager under Systems Manager console
2. Click on Configure Patching, Add Environment Tag to Development, Choose option for patching schedule as "Schedule in a new Maintenance Window", Choose the frequency to be "Every 12 hours" and give it a name under "Maintenance Window Name" and then click on Configure Patching.

This will configure patching to be scanned and install every 12 hours.


## Exercise 2: Configure Custom Compliance Rule
1. Use the github link below and copy the code (Make sure you modify the instance ID in the command, choose the one which is already compliant so that you can see the status later to be under non compliant resource)
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Systems%20Manager/aws-ssm-put-compliance-items.sh
2. Execute the command from command prompt
3. Verify the compliance of the Instance ID. 


## Exercise 3: Use Secure Shell
1. Goto Session Manager under Systems Manager console
2. Click on Configure Preferences
3. Choose/Select S3 Bucket and Cloudwatch logs option
4. Choose an exisiting S3 bucket to save the logs
5. Goto log group under Cloudwatch service and create a new log group. Its very simple, just add a name to log group and save.
6. Use the log group created under Cloudwatch service and enter the same name for log group and click on save
7. Now goto Session tab under Session Manager, choose one of the instnace and click on Start Session. Once the session is started enter some command and terminate the session.
8. Follow the same on another instance
9. Now go to CloudWatch Server log group which was created in step 5 and verify if the entries of all the commands executed is available
10. Goto S3 and verify the logs stored for all the commands executed 

## Exercise 4: Create Parameters using Parameter Store
1. Goto Parameter Store underSystems Manager console
2. Click on Create Parameter, add the name /rds/db1, Type as String, Data Type as text, Value as some custom entry you want(ex: db-connectionstring01) and finish creating the parameter.
3. Similarly create /rds/db2 parameter and create an encrypted parameter
4. Use the link below to for the commands to be executed from the command prompt
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Systems%20Manager/aws-ssm-commands.sh


## Exercise 5: Use Lambda Function to retrieve data from Parameter store
1. Create a new Lambda Function, Name it and use Python 1.7 or 1.8 whichever is latest. Code works fine with all versions. 
2. Change the code to the one in the link below and deploy.
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Systems%20Manager/lambda-ssm.py
Make sure you change the regionname and parameter store name changed accordingly.
3. Create a test with hello world and even name to T1 or anything custom and click on Test. This will throw an exception as there is no permission for Lambda to access the parameter store. 
4. Click on Permission for Lambda, click on the Role used. Once the role is open click on inline permissions and choose read permission with GetParameter, GetParameters, GetParameterByPath and then save it. 
5. Test it again and we should be able to see the results. 
6. Make modifications to the program and change parameter store and access etc and see if it works. (Try it with encrypted, other db2 parameter etc.)


## Exercise 6: Create a ElasticBeanstalk Enviromment. 
1. Create a New Application give it a name. Choose Node.js platform with single node. Upload the code from the link below. 
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Elastic%20Beanstalk/nodejs-red.zip
2. Create and test the application.
3. Now deploy a new version of the application with the link below,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Elastic%20Beanstalk/nodejs-error.zip
4. This will show a failed application, go back and check the logs to find the actual error.
5. Now deploy a new application with the link below,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Elastic%20Beanstalk/nodejs-appv1.zip
6. See that the application works now


# Day 9:
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)

## Exercise 1: Beanstalk Swap URL's
1. Create a new Environment under the same appname created in previous exercise
2. Upload the code with version2 with green page. Use the code from the link,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Elastic%20Beanstalk/nodejs-appv2.zip
3. Go to v1 application and click on Action and click on Swap Urls and choose the dev or v2 application and save
4. This should change or swap the urls


## Exercies 2: Add a custom domain name for Beanstalk application
1. Goto Route53 home page
2. Create a DNS or purchase a new domain
3. Once we have the domain, choose the domain and create a A record (Simple record)
4. Here you have 2 options one directly go with the domain or add a subdomain, in our session we added a sub domain as our actual domain is already used
5. You can either choose to apply ip address or choose an application url 
6. Choose Alias and under Route traffic to, choose your Beanstalk application url
7. Save it and use your custom url to access the application


## Exercise 3: Create Worker tier
1. Create a new application in Beanstalk, choose worker tier instead of webtier
2. Use the sample application provided by AWS
3. Goto SQS to check on the queues created

Make sure you terminate all the environements created


## Exercise 4: Created a Multie Tier HA application
1. Create a new Beanstalk application, choose V2 version of our application from the url below,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/Elastic%20Beanstalk/nodejs-appv2.zip
2. Choose advance configuration or configure more option, choose the preset "High Availability" from the list
3. Change the Autoscaling min to 2, go through all the options of Load Balancer, Monitoring and enable stream health events to cloudwatch
4. Save it and create the application, wait for it and once ready access the application using the url 
5. Verify and check EC2 instances, ASG and LB

# Day 10:
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)

## Exercise 1: Create and Update Stacks
1. Goto CloudFormation and Create a Stack, choose Use a template and use the following file and upload the same
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/1%20EC2Instance.yml
2. Move to next, skip or leave all as default and create the stack
3. Look at all Events, Resource and verify if EC2 has started
4. Now come back to the stack that was created and click on Update to update your current stack
5. Use the following link for the file and upload the same and modify the stack
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/2%20EC2InstanceIP.yml
6. Verify the resources 
7. Delete the stack created

## Exercise 2: Mapping and Parameters
1. Use the following file to create a new stack with Mappings and Parameters on us-east-1 region,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/3%20EC2InstanceMappings.yml
2. Create the stack and verify the resources and repeat the same on second region(us-west-1)
3. Check the difference between both the stacks 

## Exercise 3: Create stack with parameters
1. Use the link below to create a new stack and call it Mystack2
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/4%20EC2InstanceParameters.yml
2. Verify the LOV which you see for dev and prod instance
3. Make sure that you follow step1 and step2 on us-east-1 and us-west-1


Make sure you delete all the stack from Exercise 2 and 3 

## Exercise 4: Change sets and Drift Detection
1. Create a new stack using the file below,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/1%20EC2Instance.yml
2. Now update the stack using the link below, make sure you click on create change set from actions menu of the stack
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/5%20EC2InstanceIPandSG.yml
Continue to create the stack and see the changes before you execute the change
3. Now go to EC2 and change the security group of the instance created. Once changed come back to stack configuration and click on Drift Detection under Actions. 
4. Click on View Drift details and verify if it shows up the security group change

## Exercise 5: Create Stack with user data
1. Use the link below to create a stack,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/1%20EC2Instance.yml
2. Verify if the website is available on port 80

## Exercise 6: Rollback and Stack creation failures
1. Create a new stack with the link below, 
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/1%20EC2Instance.yml
2. Now update the stack using the link below but make sure you enter wrong email in the link below,
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/CloudFormation/2%20EC2InstanceIP.yml
3. You should be able to see that the udpate rollback fails and to fix this you can actually modify the wrong ami id and upload and you should be able to correct the failure
