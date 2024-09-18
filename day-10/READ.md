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

---

The cert-manager doesn't work in kind cluster because it doesn't have a public IP (or DNS) for the letsencrypt validate.

The authentication (user and pass) in the components folder are:
- user = ricardo
- pass = batatabanana123

This auth file was generatate by using the htpasswd with the following command `htpasswd -c auth ricardo` , after that a password will be solicitated and than an `auth` file is created, with this file is necessary to create the secret, use the following command:
`kubectl create secret generic giropops-senhas-user --from-file=auth --dry-run=client -o yaml > secret.yaml && kubectl applay -f secret.yaml`
----

Another feature that is possible to perform with kubernetes ingress is the canary deployment. The folder named `canary` has an ingress file that points to a different container image (nginx), this container will receive the route percentage that is determined in the weight annotation field.

It's important to say that the main ingress (from the giropops-senhas application) remains intact, it's not necessary to use the canary annotation.
