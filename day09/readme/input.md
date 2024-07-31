Day 09- Kubernetes ingress, URL rewriting, sticky sessions, and
autoscaling.

<img src="./ymtj4u5k.png"
style="width:6.69305in;height:2.43125in" />**1:** **Setting** **Up**
**the** **Kubernetes** **Cluster** **and** **Static** **Web** **App**

<img src="./23afvbpo.png"
style="width:6.69305in;height:4.39792in" />Creating a basic html file

creating docker file

<img src="./etq525j5.png"
style="width:6.69305in;height:4.39792in" />

<img src="./l0ufmqka.png"
style="width:6.69305in;height:4.39792in" />Building the dockerhub image

Pushing the image to the docker hub<img src="./fa01djvq.png"
style="width:6.69305in;height:4.39792in" />

<img src="./p5he2mpg.png"
style="width:6.69305in;height:4.39792in" />**Kubernetes**
**Deployment:** creating deployment.yaml

<img src="./irorjhr2.png"
style="width:6.69305in;height:4.39792in" />creating service.yaml

<img src="./trwivddl.png"
style="width:6.69305in;height:4.39792in" />Applying the deployment.yaml
and service.yaml

> **2:** **Configuring** **Ingress** **Networking**

**Tried** **to** **install** **the** **ingress** **using** **the**
**command** **minikube** **start** **–addons=ingress**

<img src="./4ior31nx.png"
style="width:6.69305in;height:4.39792in" />**Error** **occurred**

<img src="./iyrloci4.png"
style="width:6.69305in;height:4.39792in" />**In** **order** **to**
**solve** **this** **we** **have** **to** **enable** **the** **ingress**
**minikube** **addons** **enable** **ingress**

<img src="./swa5thzt.png"
style="width:6.69305in;height:4.39792in" />**Verify** **whether**
**the** **ingress** **is** **running** **and** **accessible**

**Create** **Ingress** **Resource:**

<img src="./pd2oryma.png"
style="width:6.69305in;height:4.39792in" />**Created**
**frontend-deployment.yaml**

> <img src="./mztvdmpw.png"
> style="width:6.69305in;height:4.39792in" />**created**
> **backend-deployment.yaml**

<img src="./4tsi5ska.png"
style="width:6.69305in;height:4.39792in" />**Applying** **the**
**changes**

<img src="./d35qcrex.png"
style="width:6.69305in;height:4.39792in" />**Create** **an** **ingress**
**resource**

<img src="./hl3pk0vj.png"
style="width:6.69305in;height:4.39792in" />**Apply** **the** **ingress**
**resource**

**Configure** **URL** **rewriting** **in** **the** **ingress**
**resource** **to** **modify** **incoming** **URLs** **before** **they**
**reach** **the** **backend** **services.**

<img src="./jwsknstt.png"
style="width:6.69305in;height:4.39792in" /><img src="./wep4obsh.png"
style="width:6.69305in;height:4.39792in" />Enable sticky sessions to
ensure that requests from the same client are directed to the same
backend pod.

**3:** **Implementing** **Horizontal** **Pod** **Autoscaling**
**Configure** **Horizontal** **Pod** **Autoscaler:**

<img src="./3ynmzd4k.png"
style="width:6.69305in;height:4.39792in" />**Write** **a**
**horizontal** **pod** **autoscaler** **(HPA)** **manifest** **to**
**automatically** **scale** **the** **static** **web** **application**
**pods** **based** **on** **CPU** **utilization.**

<img src="./nh2u5ief.png"
style="width:6.69305in;height:4.39792in" />**Applying** **hpa.yaml**

**Stres** **testing**

Perform stress testing to simulate traffic and validate the HPA
configuration.

<img src="./e2q2xbzk.png"
style="width:6.69305in;height:4.39792in" /><img src="./ejzsia4h.png"
style="width:6.69305in;height:1.96458in" /><img src="./myw14p35.png"
style="width:6.69305in;height:0.57361in" />Monitor the scaling behavior
and ensure the application scales up and down based on the load.

<img src="./x5elrcs4.png"
style="width:6.69305in;height:4.39792in" />

<img src="./ic0o5lh1.png"
style="width:6.69305in;height:4.39792in" />Adding TLS Secret to the
ingress-resource.yaml

Creating SSL certificate<img src="./z0b3gwt0.png"
style="width:6.69305in;height:1.775in" /><img src="./mkzkd1dl.png"
style="width:5.6875in;height:2.69792in" />

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out
tls.crt -subj "/CN=myapp.ingress/O=ingressapp-tls"

kubectl create secret tls my-tls-secret --cert=tls.crt –key=tls.key

When using https://myapp.local/backend

> <img src="./1f3r2gis.png"
> style="width:6.69305in;height:2.48472in" />when using
> [<u>https://myapp.local/frontend</u>](https://myapp.local/frontend)

<img src="./2fuxzwny.png"
style="width:6.69305in;height:1.96458in" /><img src="./l1fhonjd.png"
style="width:6.69305in;height:0.57361in" />
