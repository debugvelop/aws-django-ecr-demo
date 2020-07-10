# AWS Demo: Containerized Django+PostgreSQL
Let's say right now you want to try Django and Postgres. As time goes by, you want to reset your Django/Postgres. Unconciously you had already installed so much that reinstall Django/Postgres will break something. One way to prevent this nightmare is by containerized Django and Postgres.

### Requirement
* AWS account (Free tier is sufficient)

### Create The Docker Image
1. Go to EC2 Management Console and launch an EC2 instance with this configuration:
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
git clone https://github.com/debugvelop/aws-django-postgres-ecr-demo.git
```
9. Build the image
```
cd aws-django-postgres-ecr-demo-git
sudo docker build -t demo .
```
10. Verify the image is successfully built by run it and open the instance's public IP address on your browser
```
sudo docker run demo -p 80:8000
```
