#Objective:
#Create users and groups, and assign the users to a group in Linux environment. 

#Validate that you are in the home folder of your current user
pwd

#To add the users & password
sudo useradd <userid>
sudo useradd arosalez

sudo passwd <userid>
sudo passwd arosalez

#To validate that users have been created
sudo cat /etc/passwd | cut -d: -f1

#To create the Sales group
sudo groupadd Sales

#To verify that the group was added
cat /etc/group

#To add the user arosalez to the Sales group
sudo usermod -a -G Sales arosalez

#To verify that the user was added
cat /etc/group

#To login as the user
su arosalez

#--then enter your password

#See if the logged in user can modify a file
touch myFile.txt

#--it returns: arosalez is not in the sudoers file.  This incident will be reported.

#To go back to the homefolder
exit

#To display the content of the secure file
sudo cat /var/log/secure


