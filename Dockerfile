# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Set environment variables for PostgreSQL
ENV POSTGRES_DB=postgres
ENV POSTGRES_USER=amr
ENV POSTGRES_PASSWORD=postgres

# Optionally, you can initialize the database with a custom SQL script
# Place your SQL script in the same directory as this Dockerfile
COPY init.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432

# By default, Docker will run `postgres` command as the entrypoint
# You don't need to explicitly specify ENTRYPOINT or CMD in this case