
# Use official nginx image as the base image
FROM nginx:alpine

# Copy the nginx config file to replace the default.
COPY ./nginx.conf  /etc/nginx/conf.d/default.conf

# Copy the build output to replace the default nginx contents.
COPY ./   /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# shekinahmbenza86@gmail.com
# ZG9wX3YxXzhjODIwM2QyMzQ4OGYxZGU5YmEyYmU3MzY3MGE0NmM4MjdlMDg4MmEyNzI5YTlkNDllMWI3YjFiMjE2Y2U3MjM6ZG9wX3YxXzhjODIwM2QyMzQ4OGYxZGU5YmEyYmU3MzY3MGE0NmM4MjdlMDg4MmEyNzI5YTlkNDllMWI3YjFiMjE2Y2U3MjM=