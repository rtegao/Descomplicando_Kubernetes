install the cert-manager with `kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.3/cert-manager.yaml`


namespace issuer -> stagin_issuer.yaml -> `kubectl apply -f production_issuer.yaml`
cluster issuer -> production_issuer.yaml -> `kubectl apply -f staging_issuer.yaml`

verify if they are deployed user:
    `kubectl get issuer.cert-manager.io`
    `kubectl get clusterissuer.cert-manager.io`

