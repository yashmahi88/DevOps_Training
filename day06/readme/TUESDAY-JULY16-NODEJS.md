Project 01  

**Deploying a Node.js App Using Minikube Kubernetes**

Installing Node.js

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.001.png)

**1. Set Up Git Version Control**

**Initialize a Git Repository**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.002.png)

**Create a Node.js Application  Install express.js** 

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.003.png)

**Commit the Initial Code**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.004.png)

**Commit the changes**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.005.png)

**Branching and Fast-Forward Merge Creating  a new branch**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.006.png)

**Implement a new route and commit new changes.**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.007.png)

**Merge the Branch Using Fast-Forward**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.008.png)

Merge the feature/add-route** branch using fast-forward

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.009.png)

**Delete the feature branch:**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.010.png)

**Containerize the Node.js Application   Create a dockerfile**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.011.png)

**Build and Test the Docker Image Building the image**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.012.png)

**Run the Docker container to test:**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.013.png)

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.014.png)

**Deploying to Minikube Kubernetes  Start minikube**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.015.png)

**created service.yaml**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.016.png)

**Create service-nodeport.yaml**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.017.png)

**Apply Manifests to Minikube**

**Applied deployment, ClusterIP, NodePort**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.018.png)

**Making Changes to the Node.js Application  Create a New Branch for Changes**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.019.png)

**Modify index.js**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.020.png)

**Commit the changes**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.021.png)

**Merge the Changes and Rebuild the Docker Image Merge the feature branch**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.022.png)

` `**Delete the feature branch**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.023.png)

` `**Rebuild the Docker Image**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.024.png)

**Update the Kubernetes Deployment   updating the deployment manifest**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.025.png)

**Apply the update manifest**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.026.png)

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.027.png)

` `**Project 2**

Create a new directory for the project:

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.028.png)

` `**Create a Python Flask Application**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.029.png)

**Install flask**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.030.png)

**Git add and commit**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.031.png)

**Branching and Fast-Forward Merge**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.032.png)

**Modify in app.py**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.033.png)

**commiting the changes**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.034.png)

**Merge the Branch Using Fast-Forward**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.035.png)

**Containerize the Flask Application**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.036.png)

**Build and Test the Docker Image**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.037.png)

**Testing** 

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.038.png)

**Deploying to Minikube Kubernetes**

`    `**minikube start**

**Create Kubernetes Deployment and Service Manifests**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.039.png)

**service.yaml**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.040.png)

0![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.041.png)

Create a service-nodeport.yaml** file for NodePort:

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.042.png)

**Apply Manifests to Minikube**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.043.png)

**Access the Application**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.044.png)

**Clean up**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.045.png)

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.046.png)

**Making Changes to the Flask Application**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.047.png)

**Update the Application**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.048.png)

` `**Commit the Changes**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.049.png)

**Merge the Changes and Rebuild the Docker Image**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.050.png)

**Rebuild the docker image**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.051.png)

**Update Kubernetes Deployment**

![](Aspose.Words.b13df66d-22c6-4ee7-b69a-00c72f0ccef1.052.png)
