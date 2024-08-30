#!/bin/bash

#Create openssl certificates
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt

#Create secrets file
kubectl create secret tls secret --cert=nginx.crt --key=nginx.key --dry-run=client -o yaml > secrets.yaml


app_name="nginx-with-tls"
# Define the configmap details
configmap_name="nginx-config"
tls_cert_path="/etc/nginx/tls/nginx.crt"
tls_key_path="/etc/nginx/tls/nginx.key"

# Define deployment details
deployment_name="nginx-https"
nginx_config_volume_name="nginx-config-volume"
nginx_tls_volume_name="nginx-tls-volume"

# Define secret details
secret_name="secret"

# Define service details
service_name="nginx-service"
servic_type="NodePort"
node_port=32400
target_port=443
container_port=443

# Create the NGINX config file
cat <<EOF > nginx-config.yaml
apiVersion: v1
data:
  nginx.conf: |
    events { }
    
    http{
      server{
         listen 80;
         listen 443 ssl;
         
         ssl_certificate $tls_cert_path;
         ssl_certificate_key $tls_key_path;
         location / {
            return 200 'Deu bom em!\n PQP!';
            add_header Content-Type text/plain;
         }
      }
    }
kind: ConfigMap
metadata:
  creationTimestamp: null
  name: $configmap_name
EOF


cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $deployment_name
  labels:
    app: $app_name
spec:
  replicas: 3
  selector:
    matchLabels:
      app: $app_name
  template:
    metadata:
      labels:
        app: $app_name
    spec:
      containers:
      - name: $deployment_name
        image: nginx
        ports:
          - containerPort: 443
        volumeMounts: 
          - name: $nginx_config_volume_name 
            mountPath: /etc/nginx/nginx.conf
            subPath: nginx.conf
          - name: $nginx_tls_volume_name
            mountPath: /etc/nginx/tls
      volumes:
      - name: $nginx_config_volume_name 
        configMap:
          name: $configmap_name
      - name: $nginx_tls_volume_name
        secret:
          secretName: $secret_name 
          items:
            - key: tls.crt
              path: nginx.crt
            - key: tls.key
              path: nginx.key
EOF

cat <<EOF > service.yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: $app_name
  name: $service_name
spec:
  type: NodePort
  ports:
  - name: https
    protocol: TCP
    port: $container_port
    targetPort: $target_port
    nodePort: $node_port
  selector:
    app: $app_name

EOF

# Apply the secret and deployment YAML files to the cluster
kubectl apply -f secrets.yaml
kubectl apply -f nginx-config.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl port-forward svc/nginx-service 32400:443 &

# Confirm the resources have been created
echo "Everything is created"

