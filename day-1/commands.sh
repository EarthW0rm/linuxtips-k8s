###### INICIO ALL MACHINES #######

sudo -s
touch /etc/modules-load.d/k8s.conf && nano /etc/modules-load.d/k8s.conf

########## /etc/modules-load.d/k8s.conf ##########
br_netfilter
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack_ipv4
ip_vs
########## /etc/modules-load.d/k8s.conf ##########

apt-get update -y \
    && apt-get upgrade -y \
    && curl -fsSL https://get.docker.com | bash \
    && sudo usermod -aG docker earthw0rm


curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y kubelet kubeadm kubectl
    
swapoff -a

###### FIM ALL MACHINES #######

###### INICIO MASTER NODE ######

sudo -s

kubeadm config images pull \
    && kubeadm init

mkdir -p $HOME/.kube \
    && sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config \
    && sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

kubectl get pods -n kube-system

kubeadm token create --print-join-command

echo "source <(kubectl completion bash)" >> ~/.bashrc
