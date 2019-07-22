## The purpose of this task is to configure Kubernets cluster and Running Nginx Ingress controller.
### 1.	Create a Kubernetes cluster
     Create S3 bucket to store K8S State store:
     aws s3api create-bucket --bucket mstack.local --region us-east-2
     Create EC2 Role for aws ec2 instance to perform kops configuration
     Create a hosted zone in AWS 
     Steps performed from AWS EC2 instance, hence need to create one EC2 instance.
     Install Below tools on EC2 instance:
     
     Kubectl:
     curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl

     python:
     apt-get install python

     awscli
     pip install aws-cli

    Create SSH key pair :
    ssh-keygen -f .ssh/id_rsa

	  KOPS:
    wget https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
    chmod +x kops-linux-amd64
    sudo mv kops-linux-amd64 /usr/local/bin/kops

    Configure K8S Cluster
    export KOPS_STATE_STORE=s3://mstack.local

    kops create cluster --cloud=aws --zones=ap-east-1c –name mstack.local --node-count=2 --node-size=t2.micro --master-size=t2.medium
    kops update cluster --name ${KOPS_CLUSTER_NAME} –yes
    kpos validate cluster
    
### 2. Create NGINX-controller service
     kubectl apply -f nginx-controller-service.yaml
     This will create load balancer to AWS.

### 3. NGINX-Ingress-Controller Configuration
     kubectl apply -f nginx-controller.yaml
     
### 4. Deploy Kubernetes Guestbook Application 
     kubectl apply -f redis-master-deployment.yaml
     kubectl apply -f redis-master-service.yaml
     kubectl apply -f redis-slave-deployment.yaml
     kubectl apply -f redis-slave-service.yaml 
     kubectl apply -f frontend-deployment.yaml
     kubectl apply -f frontend-service.yaml
    
### 5. Create ingress for guestbook application
     kubectl apply -f staging-ingress.yaml
     Browse through loadbalancer DNS name and see the Guest page frontend should be visible.
     
     
