# docker-rippled-ubuntu

This Rippled is using port 5006. 

To build
```
docker build -t rippled-ubuntu . 
```

To run in background
```
docker run -d -p <port>:5006 -t rippled-ubuntu
```

To run in interactive mode
```
docker run -i -p <port>:5006 -t rippled-ubuntu
```



