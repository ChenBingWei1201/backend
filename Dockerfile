FROM node:16-alpine

EXPOSE ${PORT}

COPY . /app
WORKDIR /app

RUN corepack enable
RUN npm run setup
RUN npm run install:all
RUN npm generate
RUN npm run migrate

CMD ["npm", "run", "start"]
