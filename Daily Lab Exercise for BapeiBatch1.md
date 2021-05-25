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
      
      
   





