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

# Day1:                                                [Back to TOC](#table-of-contents)
[![TOC](https://img.shields.io/badge/TOC-TableofContent-green)](#table-of-contents)
   1. Create a Policy for SysOperations -- Used existing policy for SystemAdministration    
   2. Create a group for SysOps
   3. Create a User and assign the group

   4. Install AWS CLI

   5. Create EC2 Instance with Shutdown as Terminate. Try to terminate the instance from Management Console, Login to EC2 instance from command prompt and execute shutdown command as root. Test the behaviour. 

### Commands Used
      1. sudo su - -->Change the user to root
      2. shutdown --> use this command to shutdown from server

# Day2  [Back to TOC](#table-of-contents)
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
      
      
   
# Day3  [Back to TOC](#table-of-contents)
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

  
      USEDMEMORY=$(free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }')

      aws cloudwatch put-metric-data --metric-name memory-usage --dimensions Instance=i-0542ea1e32c310c93  --namespace "EC2-Mem" --value $USEDMEMORY


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

# Day 4:    [Back to TOC](#table-of-contents)

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



# Day 5:    [Back to TOC](#table-of-contents)

## Exercise 1: Create an Application Load Balancer (ALB)

   1. Create an S3 bucket and upload all the files from the link below,
   https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/tree/main/Elastic%20Load%20Balancing%20and%20Auto%20Scaling/Website
   2. Create 2 ec2 instnace in differnt subnet and all the following user data,

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

   make sure you assign S3Readonly role to each of these instances.

   3. Create a new LB configuration with a new Template Group



## Exercise 2: Enable Path based Routing

   1. Create a new ec2 instance add the code below for user data section,

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


# Day 6:    [Back to TOC](#table-of-contents)

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


# Day 7:    [Back to TOC](#table-of-contents)

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
