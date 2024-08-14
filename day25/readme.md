Here’s a detailed plan for deploying a path-based routing web application on AWS, using EC2 instances and an Application Load Balancer (ALB):

### **1. EC2 Instance Setup (30 minutes)**

**1.1. Launch EC2 Instances:**

1. **Open the EC2 Management Console:**
   - Go to the EC2 service from the AWS Management Console.

2. **Launch Instances:**
   - Click on "Launch Instance."
   - Choose the **Amazon Linux 2 AMI**.
   - Select **t2.micro** as the instance type.

   ![alt text](image.png)

   - **Number of Instances**: Launch **2 instances**.
   - **Key Pair**: Select or create a key pair for SSH access.

   ![alt text](image-2.png)

   - **Network Settings**: Ensure instances are in the same VPC and select appropriate subnets.
   - **Storage**: Default settings are generally sufficient.
   - **Tags**: Add tags for identification:
     - `Name: App1-Instance`
     - `Name: App2-Instance`

    ![alt text](image-3.png)

3. **Configure Security Group**:
   - **Create a Security Group** for EC2 instances:
     - **Inbound Rules**:
       - **HTTP (port 80)** from anywhere or specific IP address.
       - **SSH (port 22)** only from your IP address.
     - **Outbound Rules**: Default rules allow all outbound traffic.

4. **Review and Launch** the instances.

#### Deploy Web Applications

1. **SSH into Each Instance**:

   - Use the command:
     ```bash
     sudo chmod 400 path/to/your/file.pem
     ```

     ```bash
     ssh -i /path/to/your-key.pem ec2-user@<Public-IP>
     ```
![alt text](image-5.png)

2. **Install a Web Server (Apache)**:
   ```bash
   sudo apt update -y
   sudo apt install -y httpd
   sudo systemctl start httpd
   sudo systemctl enable httpd
   ```
![alt text](image-4.png)

![alt text](image-6.png)

3. **Deploy Applications**:
   - **For "App1" Instance**:
     - Create a simple HTML file:
       ```bash
       echo "<h1>Welcome to App1</h1>" | sudo tee /var/www/html/index.html
       ```
       ![alt text](image-7.png)

   - **For "App2" Instance**:
     - Create a different HTML file:
       ```bash
       echo "<h1>Welcome to App2</h1>" | sudo tee /var/www/html/index.html
       ```

### 2. Security Group Configuration

1. **Create Security Groups**:

   - **For EC2 Instances**:
     - Navigate to **"Security Groups"** under the EC2 Dashboard.
     - Create a new security group with rules allowing HTTP and SSH as described above.

     ![alt text](image-8.png)

   - **For ALB**:
     - Create a new security group for the ALB allowing inbound traffic on port 80.

     ![alt text](image-9.png)

2. **Attach Security Groups**:
   - Attach the created security group to the ALB and EC2 instances as needed.

### 3. Application Load Balancer Setup with Path-Based Routing

#### Create an Application Load Balancer (ALB)

1. **Go to the EC2 Dashboard** and select **"Load Balancers"** under the **"Load Balancing"** section.

![alt text](image-10.png)


2. **Create a Load Balancer**:
   - Choose **"Application Load Balancer"**.
   - **Name**: Give it a name (e.g., `my-alb`).

   ![alt text](image-11.png)

   - **Scheme**: Internet-facing.
   - **Listeners**: Add a listener on port 80.

   ![alt text](image-12.png)

   - **Availability Zones**: Select the same VPC and subnets as your EC2 instances.

3. **Configure Security Groups**:
   - Attach the ALB security group created earlier.

4. **Configure Routing**:
   - **Create Target Groups**:
     - **Target Group 1** for App1:
       - Name: `app1-target-group`
       - Protocol: HTTP
       - Port: 80
       - Health Check Path: `/`
     - **Target Group 2** for App2:
       - Name: `app2-target-group`
       - Protocol: HTTP
       - Port: 80
       - Health Check Path: `/`



   - **Register Targets**:
     - Register the App1 instance to `app1-target-group`.

     ![alt text](image-14.png)
     - Register the App2 instance to `app2-target-group`.

     ![alt text](image-13.png)

5. **Configure Path-Based Routing**:
   - Go to the **"Listeners"** tab for your ALB.
   - Edit the default rule for the listener on port 80:
     - Add rules for path-based routing:
       - If the path is `/app1*`, forward to `app1-target-group`.

       ![alt text](image-15.png)
       ![alt text](image-16.png)


       - If the path is `/app2*`, forward to `app2-target-group`.

       ![alt text](image-17.png)
       ![alt text](image-18.png)
       ![alt text](image-19.png)

       ![alt text](image-20.png)

    ![alt text](image-21.png)
Changes applied in the Rule_app1 and Rule_app2
    
    ![alt text](image-26.png)

    ![alt text](image-27.png)

    ![alt text](image-23.png)
  Do the above same for rule_1 and add the instance public ip address for it.
6. **Review and Create** the ALB.

### 4. Testing and Validation

1. **Test Path-Based Routing**:
   - Access the ALB's DNS name provided in the AWS Management Console.
   - Test URL paths:
     - `http://<ALB-DNS>/app1` should show the "App1" page.

     ![alt text](image-22.png)

     ![alt text](image-25.png)

     - `http://<ALB-DNS>/app2` should show the "App2" page.
   ![alt text](image-24.png)
2. **Security Validation**:
   - Try accessing the EC2 instances directly via their public IPs and ensure SSH access is restricted to your IP.

### 5. Resource Termination

1. **Terminate EC2 Instances**:
   - Go to the **"Instances"** section in the EC2 Dashboard.
   - Select the instances.
   - Choose **"Instance State"** > **"Terminate"**.

2. **Delete Load Balancer and Target Groups**:
   - Go to **"Load Balancers"** and delete the ALB.
   - Go to **"Target Groups"** and delete the target groups.

3. **Cleanup Security Groups**:
   - Go to **"Security Groups"** and delete the security groups created for the project.

### 6. Documentation and Reporting

1. **Brief Documentation**:
   - Describe the steps taken to launch EC2 instances, set up security groups, configure the ALB, and validate the setup.
   - Include screenshots or commands used.

2. **Final Report**:
   - Summarize the project, highlighting:
     - Objectives and deliverables.
     - Challenges faced and solutions.
     - How the setup was validated and tested.
   - Provide any lessons learned or improvements for future deployments.

This guide will help you efficiently deploy and manage your two lightweight web applications on AWS, including configuring path-based routing with an ALB and ensuring proper security and resource cleanup.   