#New business requirements:Migrate database from on-prem to cloud, Automate database maintenance tasks and reduce database administration costs.

#Tasks to be done:

#- Create an Amazon RDS MariaDB instance using the AWS Command Line Interface.
#- Migrate data from a local MariaDB database to an Amazon RDS MariaDB database.
#- Monitor an Amazon RDS instance using Amazon CloudWatch metrics.

#Step 1: Create an Amazon RDS instance by using the AWS CLI
#Connect to the AWS CLI via putty:
aws configure

AccessID:  AKIAT4HMHXBMIED2QO4B
SecretKey: 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
Default region name: us-west-2
Default output format: json

#Step 2: Gather current environment configuration information
#Specifically, you must determine the following information:

#Instance ID of CafeInstance
#Instance type of CafeInstance
#Public DNS name of CafeInstance
#Public IP address of CafeInstance
#Availability Zone of CafeInstance
#VPC ID of Cafe VPC
#Group ID of CafeSecurityGroup
#IPv4 CIDR block of Cafe VPC
#Subnet ID of Cafe Public Subnet 1
#IPv4 CIDR block of Cafe Public Subnet 1
#List of Availability Zones in the Region

#Command to return the above information

aws ec2 describe-instances \
--filters "Name=tag:Name,Values= CafeInstance" \
--query "Reservations[*].Instances[*].[InstanceId,InstanceType,PublicDnsName,PublicIpAddress,Placement.AvailabilityZone,VpcId,SecurityGroups[*].GroupId]"

#Determine the IPv4 CIDR block of the Cafe VPC
aws ec2 describe-vpcs --vpc-ids vpc-00fdbcf7797724821 \
--filters "Name=tag:Name,Values= Cafe VPC" \
--query "Vpcs[*].CidrBlock"

#Determine the Subnet ID and IPv4 CIDR block of Cafe Public Subnet 1
aws ec2 describe-subnets \
--filters "Name=vpc-id,Values=vpc-00fdbcf7797724821" \
--query "Subnets[*].[SubnetId,CidrBlock]"

#Determine the list of Availability Zones in the Region
aws ec2 describe-availability-zones \
--filters "Name=region-name,Values=us-west-2" \
--query "AvailabilityZones[*].ZoneName"

#Step 3: Create prerequisite components for the RDS DB Instance
#Create the CafeDatabaseSG security group

aws ec2 create-security-group \
--group-name CafeDatabaseSG \
--description "Security group for Cafe database" \
--vpc-id vpc-00fdbcf7797724821

The command returns a GroupID

#Create the inbound rule for the security group

aws ec2 authorize-security-group-ingress \
--group-id sg-03a973f2e8d711c47 \
--protocol tcp --port 3306 \
--source-group sg-03a973f2e8d711c47

#Confirm that the ingress rule was applied appropriately

aws ec2 describe-security-groups \
--query "SecurityGroups[*].[GroupName,GroupId,IpPermissions]" \
--filters "Name=group-name,Values='CafeDatabaseSG'"

#Create the CafeDB Private Subnet 1
aws ec2 create-subnet \
--vpc-id vpc-00fdbcf7797724821 \
--cidr-block 10.200.2.0/23 \
--availability-zone us-west-2a

#Create the CafeDB Private Subnet 2.
aws ec2 create-subnet \
--vpc-id vpc-00fdbcf7797724821 \
--cidr-block 10.200.10.0/23 \
--availability-zone us-west-2b

#Create the CafeDB Subnet Group
aws rds create-db-subnet-group \
--db-subnet-group-name "CafeDB Subnet Group" \
--db-subnet-group-description "DB subnet group for Cafe" \
--subnet-ids "subnet-0d9b6d1959e287466" "subnet-0b5da630a60129662" \
--tags "Key=Name,Value= CafeDatabaseSubnetGroup"


Step 4: Create the Amazon RDS MariaDB instance

#Create an Amazon RDS MariaDB instance with the following configuration settings:

#DB instance identifier: CafeDBInstance
#Engine option: MariaDB
#DB engine version: 10.6.10
#DB instance class: db.t3.micro
#Allocated storage: 20 GB
#Availability Zone: CafeInstance Availability Zone
#DB Subnet group: CafeDB Subnet Group
#VPC security groups: CafeDatabaseSG
#Public accessibility: No
#Username: root
#Password: Re:Start!9

aws rds create-db-instance \
--db-instance-identifier CafeDBInstance \
--engine mariadb \
--engine-version 10.6 \
--db-instance-class db.t3.micro \
--allocated-storage 20 \
--availability-zone us-west-2a \
--db-subnet-group-name "CafeDB Subnet Group" \
--vpc-security-group-ids sg-03a973f2e8d711c47 \
--no-publicly-accessible \
--master-username root --master-user-password 'Re:Start!9'

#Check the status of the database instance

aws rds describe-db-instances \
--db-instance-identifier CafeDBInstance \
--query "DBInstances[*].[Endpoint.Address,AvailabilityZone,PreferredBackupWindow,BackupRetentionPeriod,DBInstanceStatus]"

#Step 5: Migrate application data to the Amazon RDS instance
#Begin by opening an SSH session to the CafeInstance and logging in as ec2-user.
#Use the mysqldump utility to create a backup of the local cafe_db database.

mysqldump --master-username=root --master-user-password='Re:Start!9' \
--databases cafe_db --add-drop-database > cafedb-backup.sql

#Review the contents of the backup file.

less cafedb-backup.sql

#Next, restore the backup to the Amazon RDS database by using the mysql command

mysql --user=root --password='Re:Start!9' \
--host=cafedbinstance.cikgn6wv0wj8.us-west-2.rds.amazonaws.com \
< cafedb-backup.sql

#Finally, verify that the cafe_db was successfully created and populated in the Amazon RDS instance.

mysql -u root --password='Re:Start!9' -h cafedbinstance.cikgn6wv0wj8.us-west-2.rds.amazonaws.com


#Step 6: Configure the website to use the Amazon RDS instance

#In this task, you change the database URL parameter of the Café application to point to the endpoint address of the RDS instance.
#In the AWS Management Console browser tab, select Services > Systems Manager > Parameter Store.
#In the Parameters list, click /cafe/dbUrl, and then click Edit.
#In the Parameter details page, replace the text in the Value box with the value of RDS Instance Database Endpoint Address, and save changes.
#Test the website to confirm that it is able to access the new database correctly bu using the Webserver Public DNS Name





































