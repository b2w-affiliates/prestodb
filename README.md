PrestoDB Docker image
===

# Build
```bash
sudo docker build -t prestodb1 .
```


# Run
```bash
sudo docker run -it -v $(pwd)/catalog:presto-server-0.149/etc/catalog -p 8080:8080 --rm --name presto_coordinator3 prestodb1
```