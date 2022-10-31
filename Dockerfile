FROM nginx:alpine
COPY ./dist/hazem-cd /usr/share/nginx/html
EXPOSE 4201
CMD ["nginx","-g","daemon off;"]

