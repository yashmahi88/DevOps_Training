In this project, you will develop a simple Node.js application, deploy it on a local Kubernetes cluster using Minikube, and configure various Kubernetes features. The project includes Git version control practices, creating and managing branches, and performing rebases. Additionally, you will work with ConfigMaps, Secrets, environment variables, and set up vertical and horizontal pod autoscaling.

**Setup Minikube and Git Repository**

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.001.png)

**Develop a Node.js Application**

**Create the Node.js App Initialize the Node.js project**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.002.png)

**Install necessary packages**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.003.png)

create app.js

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.004.png)

Update package.json

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.005.png)

` `**Commit the Node.js Application Add and commit changes**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.006.png)

Create Dockerfile and Docker Compose

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.007.png)

**Create docker-compose.yml** **(optional for local testing)**

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.008.png)

**Add and commit changes**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.009.png)

Build and Push Docker Image

` `**FACED ISSUE IN THIS AND THE PROCESS IS STILL STUCK HERE**

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.010.png)

Solved the issue which was in package.json under start: node-app.js previously it was node app.js

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.011.png)

**Push Docker Image to Docker Hub**

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.012.png)

**Add and commit changes**

**Create Kubernetes Configurations**

`  `**Create kubernetes/deployment.yaml** :

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.013.png)

**kubernetes/config.yaml**   

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.014.png)

**kubernetes/secret.yaml**

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.015.png)

**Add and commit Kubernetes configurations**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.016.png)

Apply Kubernetes Configurations **Apply the ConfigMap and Secret**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.017.png)

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.018.png)

Implement Autoscaling

Create Horizontal Pod Autoscaler **Create kubernetes/hpa.yaml** :

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.019.png)

here we need to change v2beta2 to v2

**Apply the VPA**:

kubectl apply -f kubernetes/vpa.yaml

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.020.png)

Test the Deployment

**7.1 Check the Status of Pods, Services, and HPA Verify the Pods and service**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.021.png)

Access the Application **Expose the Service**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.022.png)

**Get the Minikube IP and Service Port**:

![](Aspose.Words.74d4d384-c31b-4dd5-872b-a79f4e61449d.023.png)
