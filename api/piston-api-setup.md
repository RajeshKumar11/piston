### **Building the Docker Image**

To build this Docker image, use the `docker build` command in the directory where the Dockerfile is located. Here's an example:

```bash
docker build -t piston-api .
```

-   This command will create a Docker image named `piston-api`.

### **Running the Docker Container**

After building the image, you can run a container using the `docker run` command:

```bash
docker run -d -p 2000:2000 --name piston-container piston-api
```

To Avoid the issue of **mkdir: cannot create directory 'isolate/': Read-only file system**

```bash
docker run -d --privileged -p 2000:2000 --name piston-container piston-api
```

-   This command runs the container in detached mode (`-d`), maps port `2000` of the host to port `2000` of the container, and names the container `piston-container`.
