FROM node:10-slim

WORKDIR /usr/src/app

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm install

COPY . .

CMD [ "npm", "run", "dev" ]
VOLUME [ "/usr/src/app/node_modules" ]
