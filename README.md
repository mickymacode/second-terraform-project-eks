1. create vpc 和 eks

        terraform init
   
        terraform plan
   
        terraform apply -auto-approve

3. 安装AWS CLI, kubectl, aws-iam-authenticator


4. deploy nginx-app into the eks cluster

        aws eks update-kubeconfig --name myapp-eks-cluster --region ap-southeast-2

update-kubeconfig: 这是 eks 子命令之一，用于更新本地 Kubernetes 配置文件（通常称为 kubeconfig 文件），以便包含 Amazon EKS 集群的连接信息。
这个指令的作用是将 Amazon EKS cluster的连接信息更新到本地的 Kubernetes 配置文件中，以便你可以使用 kubectl（Kubernetes 命令行工具）与该集群进行交互。

        kubectl apply -f nginx-config.yaml


WELL DONE! 通过AWS的DNS到浏览器，可以access nginx的页面
