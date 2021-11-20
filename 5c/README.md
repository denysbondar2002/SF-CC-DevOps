### Prerequisites
-  I wrote this app two years ago (I was a student of 1st course)
- This app was how Course Work for a student of 3rd course KPI (Kiev) University
- I got out this app from the personal archive and push to GitHub 09.11.2021 

### Requirements
- Python 3.7+

### The environment variables
```
SECRET_KEY=secretkey
DATABASE_URL=mysql://username:password@host/db_name
```

#### We have these k8s manifests
1. deployment.yaml - in this manifest, we describe which docker image we are using, the port number of this container, and set the env variables from Secret. 
2. lb-service.yaml - in this manifest, we open input traffic to our pods.
3. flask-secrets.yaml - here we set the env variables which used in the deployment.yaml manifest