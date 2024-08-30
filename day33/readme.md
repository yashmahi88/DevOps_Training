

### 1. **Setup Helm and Minikube**

#### 1.1 Install Minikube
Ensure Minikube is installed. Follow the installation guide from [Minikube documentation](https://minikube.sigs.k8s.io/docs/start/).

```sh
minikube start
```
 ![alt text](image.png)

#### 1.2 Install Helm
Ensure Helm is installed. Follow the installation guide from [Helm documentation](https://helm.sh/docs/intro/install/).

```sh

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

```

### 2. **AWS Services Setup**

#### 2.1 Create an S3 Bucket

1. **Navigate to the S3 Console** and create a new bucket named `my-app-assets`.
2. **Upload `index.html` file**:
   - Go to the bucket.
   - Click on **Upload** and add your `index.html` file.

3. **Set Permissions**:
   - Navigate to the **Permissions** tab of the bucket.
   - Edit the **Bucket Policy** to allow public read access (for testing only):

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::my-app-assets/*"
       }
     ]
   }
   ```
 ![alt text](image-2.png)

 

#### 2.2 Set Up an RDS MySQL Instance

1. **Navigate to the RDS Console**.
2. **Create a new database**:
   - Choose **MySQL**.
   - Select **Free Tier** options.
   - Configure DB details (name, master username, password).
   - Set VPC security group settings to allow access from the backend service.

   ![alt text](image-4.png)

Step 3: Create Helm Charts

Create a new directory for your Helm charts:

```
  mkdir helm-charts

  cd helm-charts
```
Create a Helm chart for the frontend service:
```
    helm create frontend

    cd frontend
```
Edit the values.yaml file to include the S3 bucket name:

```
    s3Bucket: yashm-bucket
```
Edit the templates/deployment.yaml file to include the S3 bucket name:

```
    spec:

    containers:

    - name: frontend

        image: nginx:latest

        volumeMounts:

        - name: s3-volume

        mountPath: /usr/share/nginx/html

    volumes:

    - name: s3-volume

        awsElasticBlockStore:

        volumeID: yashm-bucket

        fsType: ext4
```
Create a Helm chart for the backend service:

```
    cd ..

    helm create backend

    cd backend
```
Edit the values.yaml file to include the RDS instance details:
```
    rdsInstance:

    host: yashm-database.us-west-2.rds.amazonaws.com

    port: 3306

    username: admin

    password: password

    database: yashm_database
```
Edit the templates/deployment.yaml file to include the RDS instance details:
```
    spec:

    containers:

    - name: backend

        image: python:latest

        env:

        - name: DATABASE_URL

        value: mysql://admin:password@yashm-database.us-west-2.rds.amazonaws.com:3306/yashm_database
```
    Create a Helm chart for the database:
```
    cd ..

    helm create database

    cd database
```
Edit the values.yaml file to include the RDS instance details:
```
    rdsInstance:

    host: yashm-database.us-west-2.rds.amazonaws.com

    port: 3306

    username: admin

    password: password

    database: yashm_database
```

Step 4: Package Helm Charts

    Package each Helm chart into a .tgz file:
```
    cd frontend

    helm package .

    cd ..

    cd backend

    helm package .

    cd ..

    cd database

    helm package .
```
Step 5: Deploy Multi-Tier Application Using Helm

    Deploy the database chart:
```
helm install database
```

![alt text](image-8.png)

    Deploy the backend chart with dependency on the database chart:
```
helm install backend --set backend.databaseChart=database
```

![alt text](image-9.png)


    Deploy the frontend chart with dependency on the backend service:
```
helm install frontend --set frontend.backendService=backend
```

![alt text](image-10.png)

![alt text](image-11.png)

```
 minikube service frontend --url
```
![`alt text`](image-12.png)

![alt text](image-13.png)
Step 6: Manage Helm Secrets

Create a secrets file for the database credentials:
```
    echo "database:

    username: admin

    password: password" > secrets.yaml
```
Update the backend chart to use the secrets:

```
cd backend

helm upgrade backend --set backend.databaseSecrets=secrets.yaml
```
Step 7: Implement RBAC

    Create a RBAC role for Helm deployments:
```
kubectl create role helm-deployer --verb=create,update,delete --resource=deployments,services
```
Create a RBAC role binding for the Helm deployments:

```
kubectl create rolebinding helm-deployer-binding --role=helm-deployer --user=<your-username>
```
