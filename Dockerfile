FROM node:16-alpine

EXPOSE ${PORT}

COPY . /backend
WORKDIR /backend

RUN corepack enable
RUN apt update
RUN apt install openssl -y
RUN npm run setup
RUN npx prisma generate
RUN npm run migrate

CMD ["npm", "run", "start"]
