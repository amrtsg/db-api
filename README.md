# Postgres database in Docker W/ API

## To build and run postgres docker image

```
> docker build -t postgresimg . //you can change postgresimg to desired image name
> docker run -d -p 5432:5432 --name postgrescont postgresimg //you can change postgrescont to desired container name
```

## Once the container is up and running, run:

```
> npm i //to install dependencies for API
> curl http://localhost:3000/YOUR_ROUTE
```

Available routes:


```/users``` returns all users <br>
```/vehicles``` returns all vehicles <br>
