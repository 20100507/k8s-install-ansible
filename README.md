# k8s-install-ansible
k8s 1.17 自动化安装仅需要一条命令即可

注意你的主控机器的root用户必须可以免密登陆所有的部署机
下载部署脚本:

第一步:在util目录下有ansible rpm包,需要执行 rpm -ivh ansible-rpm的名字 安装好ansible2.8.5.一定要使用2.8.x版本!!!!

第二步: 修改dxm-mmr-production 主机和 hostname配置,修改roles/init_install/template/hosts hosts 文件配置

第二步: 依次执行如下脚本即可.

### 初始化机器

ansible-playbook -i dxm-mmr-production ./playbooks/init_install.yml --become-method=sudo


### 安装并且启动docker容器

ansible-playbook -i dxm-mmr-production ./playbooks/docker.yml  --become-method=sudo

### 安装k8s 

#### 一条命令

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml  --become-method=sudo

kubectl label nodes node名称 IngressProxy=true

#### 分开部署

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t init_directory --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t gen_certs --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_etcd --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_apiserver --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_controller_manager --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_scheduler --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_kubeproxy --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_calico --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_kubelet --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_dashboard --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_dns --become-method=sudo

ansible-playbook -i dxm-mmr-production ./playbooks/kubernetes.yml -t install_traefik --become-method=sudo
