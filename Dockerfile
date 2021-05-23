FROM node:latest

RUN mkdir /app
WORKDIR /app

COPY . /app
RUN npm install

RUN npm run build

EXPOSE 5000

ENV NUXT_HOST=0.0.0.0

CMD [ "npm", "start" ]