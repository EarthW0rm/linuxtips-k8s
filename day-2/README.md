# linuxtips-k8s

kubectl get pods -o wide

## Taints

Com os taints em nos e possivel travar a execucao de containers 

kubectl taint node elliot-02 key1=value1:NoSchedule

kubectl taint node elliot-02 key1:NoSchedule-

kubectl taint node elliot-02 key1=value1:NoExecute

kubectl taint node elliot-02 key1:NoExecute-