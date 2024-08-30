READ THE LINK BELLOW TO UNDERSTAND WHAT IS HAPPENING

https://kind.sigs.k8s.io/docs/user/ingress/
(verify the instalation by seen the running pods in the correct namespace)

The ingress is the resource that is used to expose the services and defines how external HTTP(S) traffic should be routed to services within the cluster, but the component that really implement the ingress is named ingress controller, it does this by configuring a load balancer or reverse proxy to route traffic according to the rules specified in Ingress.

There are several types of ingress controllers, the one the is going to be used here is name NGINX
