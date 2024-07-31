Docker Project 01

**Part 1: Creating a Container from a Pulled Image** Pulled the nginx image and run the nginx container

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.001.png)

Verified the docker is running.

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.002.png)

Part 2: **Modifying the Container and Creating a New Image** Access the running container

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.003.png)

Commit change to create a new image:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.004.png)

Part 3: Creating a dockerfile to build and deploy a web app  Created an index.html file

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.005.png)

Writing to the dockerfile

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.006.png)

Build the docker image

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.007.png)

Running the conatiner 

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.008.png)

Verifying the web app at http://localhost:8082

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.009.png)

Cleaning up, stopped and removed all the containers.

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.010.png)

Project 02:

Part 1: Setting project structure

Created subdirectories for each services  and created a shared network 

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.011.png)

Part 2: Setting Up the database Created a Dockerfile for PostgreSQL

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.012.png)

Build the postgreSQL Image:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.013.png)

Running the PostgreSQL Container:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.014.png)

Part 3: Setting up backend (node.js with express)

**Initialize the Node.js Application and Install Express and pg (PostgreSQL client for Node.js)**

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.015.png)

**Creating the application code**

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.016.png)

Creaing a docker file for backend:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.017.png)

Running the backend container:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.018.png)

Part 4: Setting up Nginx Creating HTML page

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.019.png)

Create docker file for frontend

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.020.png)

Building the frontend cointainer

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.021.png)

Running the frontend cointainer

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.022.png)

**Part 5: Connecting the Backend and Database**

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.023.png)

Part 6: Final Integration and Testing

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.024.png)

Rebuild and run the updated frontend container:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.025.png)

Part 7 cleaning up:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.026.png)

Removing the images:

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.027.png)

Remove the network and volume

![](Aspose.Words.d4df0fff-8683-4971-a853-7943a03411b2.028.png)
