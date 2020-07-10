# AWS Demo: Containerized Django
Let's say right now you want to try Django. Then at some point in the future you want to reset it. Unconciously you had already installed so much that reinstall Django will break something. One way to prevent this nightmare is by containerizing Django and store it in a container registry for later use.

### Requirement
* AWS account (free tier is sufficient)

### Create Django Docker Image in EC2
1. Go to EC2 Management Console then launch an EC2 instance with this configuration:
    * AMI: Ubuntu Server 20.04 LTS x86_64
    * Type: t2.micro
    * Security Groups: SSH(22), HTTP(80)
2. Connect to the instance.
3. Update the apt package index and install packages to allow apt to use a repository over HTTPS.
```
$ sudo apt update && sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
```
4. Add and verify Docker’s official GPG key.
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
5. Set Docker's repository to stable version.
```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
6. Install Docker
```
sudo apt update && sudo apt install docker-ce -y
```
7. Verify Docker is successfully installed.
```
sudo docker run hello-world
```
8. Clone this repository
```
git clone https://github.com/debugvelop/aws-django-ecr-demo.git
```
9. Build the image (this may take a while)
```
cd aws-django-ecr-demo
sudo docker build -t demo .
```
10. Verify the image is successfully built by run it and open the instance's public IP address on your browser
```
sudo docker run demo -d -p 80:8000
```

### Upload Django Docker Image to Container Registry
1. Go to IAM Console then add a new user for the instance with this configuration
    * Access type: Programmatic Access
    * Set permissions: Attach existing policies directly (AmazonEC2ContainerRegistryFullAccess)
2. Save **access key ID** and **secret access key**.
3. Back to the instance's SSH and install AWS CLI.
```
unzip awscliv2.zip
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
```
4. Verify that AWS CLI is installed correctly.
```
aws --version
```
5. Connect AWS CLI to IAM User by entering previously saved **access key ID** and **secret access key**.
```
aws configure
```
