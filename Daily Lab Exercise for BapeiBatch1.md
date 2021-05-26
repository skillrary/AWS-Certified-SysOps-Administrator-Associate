# Day1:

1. Create a Policy for SysOperations -- Used existing policy for SystemAdministration
2. Create a group for SysOps
3. Create a User and assign the group

4. Install AWS CLI

5. Create EC2 Instance with Shutdown as Terminate. Try to terminate the instance from Management Console, Login to EC2 instance from command prompt and execute shutdown command as root. Test the behaviour. 

### Commands Used
1. sudo su - -->Change the user to root
2. shutdown --> use this command to shutdown from server

# Day2
1. Change Instance Type from t2.micro to any instance and test
2. Know where to choose/create Spot, Reserved, Dedicated hosts and Savings Plan. 
3. Know where configure Dedicated host/instance


4. Create EC2 instance, stop and start the instance and recoginze release of public IP from the instance.
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
    Attach the new role to EC2 instance and then try to execute following command
        aws s3 ls

7. Create an instance profile from command line, this would not work as aws cli is not configured.
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
## Exercise 1: Create Custom VPC and test Bastion Host and Nat Gateway

1. Create a VPC with the configuration as per the link(github https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/custom-vpc.txt) provided
2. Create Ec2 instance in both Public and Private Subnet
3. SSH to EC2 instance in Private subnet from EC2 in Public subnet (Copy PEM file to Public EC2 instance and then try to SSH)
4. Try accessing google.com from the command prompt using ping utility
   ping google.com
   You will see that it is not accessible.

5. Create a NAT gateway and map the id in the private route table
6. Try pinging google again to test if private EC2 instance is able to access the internet


## Exercise 2: Create Custom Metric
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/aws-cli-put-metric-data.sh
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/mem.sh

1. Created Custom Metric. Use the above link to do the same.
2. Execute the command the following command
      aws cloudwatch put-metric-data --metric-name MyBytes --namespace MyNameSpace --unit Bytes --value 231434333 --dimensions InstanceId=1-23456789,InstanceType=m1.small
3. Goto Cloudwatch and see if it has created a new namesapce 
4. Now create a new EC2 instance and create mem.sh file with the following 2 lines.

  
      USEDMEMORY=$(free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }')

      aws cloudwatch put-metric-data --metric-name memory-usage --dimensions Instance=i-0542ea1e32c310c93  --namespace "EC2-Mem" --value $USEDMEMORY


5. Save the file and create a crontab entry using the following commnad
      crontab -e
6. Add the line below to crontab entry 
       */1 * * * * /home/ec2-user/mem.sh
7. Save it and test if the entry is intact in crontab
      crontab -l
9. Exectue steps from github url to put some load or stress the system. Execute the following commands one after the other.

      sudo amazon-linux-extras install epel -y
      sudo yum install stress-ng -y
      stress-ng --vm 10 -c 10 --vm-bytes 80% --vm-method all --verify -t 60m -v

   Now wait for the data to be published to CloudWatch

10. Verify if you see all the data in CloudWatch
11. Create an alarm for memory utilzation and trigger an email through SNS topic
12. In the instance standard monitoring create another alarm for CPU utilization. Also configure action to be performed. Choose to termiante the instance.
13. Verify if the instance gets terminated

## Exercise 3: Install Unified Cloudwatch Agend for EC2
https://github.com/skillrary/AWS-Certified-SysOps-Administrator-Associate/blob/main/EC2/cloudwatch-agent-windows-install.sh

1. Create a new Windows environment. Choose free tier windows 2019 base/ (Make sure to disable IE security from Server Management on Windows)
2. Download Cloudwatch Agent from the url below and install, 
https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi
3. Configure Cloudwatch agent using Cloudwatch Agent wizard under Amazon directory in Program files under c drive. 
4. Execute the following line from windows powershell
      & "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -s -c file:"C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json"

5. Go back to Cloudwatch console and wait for metrics to be shown

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


