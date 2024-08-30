Read the README.md in the `kind` folder before do anything here (setup the kind cluster with ingress and install the ingress controler).

to install the cert-manager go to the following link:
https://cert-manager.io/docs/installation/kubectl/

and run the following command to install with kubectl:
`kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.3/cert-manager.yaml`


after that will be possible to deploy a name space issuer and a cluster issuer files in the `certs` folder, they are de desired configuration for the issuers


When the kind clsuter is up and the issuers are instaled it's time to deploy the application, go to de component folders and run


`kubectl apply -d <file_name>'`


After you have the application running on https://giropops-senhas.io/ (this addres must be mapped in you `/etc/hosts` file) it's time to
start working with the cert-managet.
The Cert-Manager is a way to expose the ingress address with https and manage all the TLS certificates inside the kubernetes cluster ( It simplifies the process of obtaining, renewing, and managing certificates for your Kubernetes workloads).

It's necessary to use the cert-manager with a certificate authority (CA) that provides digital certificates to enable HTTPS (TLS/SSL), letsencrypty is one of this CA.
read more on https://cert-manager.io/docs/

Now, go to the `cert` folder and follow the instructions
