1. Create and Configure an S3 Bucket

1.1. Create the S3 Bucket:

 Open the AWS Management Console.
navigate to the S3 service.
Click "Create bucket."
Enter the bucket name: techvista-portfolio-[your-initials].
Choose the appropriate AWS Region.
Click "Create."


![alt text](image.png)

![alt text](image-1.png)

![alt text](image-2.png)

1.2. Enable Versioning:

    Go to the bucket's properties.
    Find the "Bucket Versioning" section.
    Click "Edit" and enable versioning.
    Click "Save changes.

![alt text](image-3.png)

1.3. Set Up Static Website Hosting:

    Go to the bucket's properties.
    Find the "Static website hosting" section.
    Click "Edit."
    Select "Enable."
    For "Index document," enter index.html.
    For "Error document," enter error.html (if applicable).
    Save the changes.

![alt text](image-4.png)

![alt text](image-5.png)

1.4. Upload Static Website Files:

Go to the "Objects" tab.
Click "Upload" and add your static website files (HTML, CSS, images).
Click "Upload" to start the process.

![alt text](image-6.png)

![alt text](image-7.png)

1.5. Verify Accessibility:

Access the static website URL provided in the "Static website hosting" section of the bucket properties.
Ensure the website is loading correctly.

![alt text](image-8.png)

2. Implement S3 Storage Classes:
Classify the uploaded content into different S3 storage classes (e.g., Standard, Intelligent-Tiering, Glacier).
Justify your choice of storage class for each type of content (e.g., HTML/CSS files vs. images).

![alt text](image-9.png)

![alt text](image-18.png)

HTML/CSS Files: Using S3 Standard storage class because these files are frequently accessed.

![alt text](image-10.png)

3. Lifecycle Management

3.1. Create a Lifecycle Policy:

Go to the bucket's "Management" tab.
Click "Create lifecycle rule."
Enter a rule name, such as "Transition older versions."
Apply the rule to all objects or specify a prefix if needed.
Add a transition to S3 Glacier for objects older than 30 days.
Set another rule to delete non-current versions after 90 days.
Review and save the policy.

![alt text](image-11.png)

![alt text](image-12.png)

![alt text](image-13.png)

4. Configure Bucket Policies and ACLs

4.1. Create and Attach Bucket Policy:

Go to the bucket’s "Permissions" tab.
Click "Bucket Policy."
Enter the following policy to allow public read access for static website content:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::techvista-portfolio-[your-initials]/*"
    }
  ]
}
```

![alt text](image-14.png)

Set Up ACL for Specific User Access:

Go to the "Permissions" tab.
Click on "Access Control List" (ACL).
Add a new grant for the external user with specific permissions to a particular folder if needed.

(change the object ownership to ACLs enabled if the edit option for the ACL in Permissions in disabled).
![alt text](image-16.png)

![alt text](image-15.png)

5. Test and Validate Configuration

 Test Static Website URL:

Ensure that the static website URL provided by S3 is accessible and that the content loads correctly.

![alt text](image-17.png)

