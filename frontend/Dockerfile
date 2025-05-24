# Use an official Nginx image
FROM nginx:alpine

# Copy the build files into the default Nginx directory
COPY . /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

# Command to run Nginx serving the frontend
CMD ["nginx", "-g", "daemon off;"]

# Run the following commands to build and run the Docker container:
# docker build -t random-choice-devops-frontend .
# docker run -d -p 8080:80 --name random-picker-frontend-container random-choice-devops-frontend
