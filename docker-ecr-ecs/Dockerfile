FROM node:11.2-alpine
WORKDIR /app
COPY ./pocApp /app
EXPOSE 3000
RUN npm install
CMD [ "npm", "start" ]