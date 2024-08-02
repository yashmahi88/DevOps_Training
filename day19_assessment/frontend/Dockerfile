# Use an Nginx image to serve static files
FROM nginx:alpine

# Copy static files to Nginx's default directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
