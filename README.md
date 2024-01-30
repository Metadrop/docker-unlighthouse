# Unlighthouse Docker

This repository allows using unlighthouse through Docker.

Dockerfile is based on https://github.com/indykoning/unlighthouse-docker project.

## Usage

Run `docker run --cap-add SYS_ADMIN -p 5678:5678 metadrop/unlighthouse unlighthouse` with the respective parameters. After that, you can access
to the unlighthouse website (for CLI usage) at http://localhost:5678

There are some examples with and without configuration below:

### With configuration

```bash
docker run -v /path/to/unlighthouse.config.ts:/home/unlighthouse/unlighthouse.config.ts --cap-add SYS_ADMIN -p 5678:5678 metadrop/unlighthouse unlighthouse
```


### Without configuration

```bash
docker run --cap-add SYS_ADMIN -p 5678:5678 metadrop/unlighthouse unlighthouse --site example.com
```

### Continuous integration

To use the CI version, run:

```bash
docker run --cap-add SYS_ADMIN -p 5678:5678 metadrop/unlighthouse unlighthouse-ci --site example.com
```
