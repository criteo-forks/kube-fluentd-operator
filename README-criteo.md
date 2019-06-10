# Build image

# Build fluentd image with plugins

```
cd base-image
make build-image
```

# Build with config-reloader

1. Edit version 'TAG' in config-reloader/Makefile and build the image

```
cd ../config-reloader
make build-image
```

2. Push the image

```
docker push criteord/base-fluentd-operator:<TAG>
```
