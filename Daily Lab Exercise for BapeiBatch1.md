# Day1:

1. Create a Policy for SysOperations -- Used existing policy for SystemAdministration
2. Create a group for SysOps
3. Create a User and assign the group

4. Install AWS CLI

5. Create EC2 Instance with Shutdown as Terminate. Try to terminate the instance from Management Console, Login to EC2 instance from command prompt and execute shutdown command as root. Test the behaviour. 

## Commands Used
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
