# from: https://github.com/Saluki/nestjs-template
FROM node:20-alpine AS dev

ENV NODE_ENV=build

RUN npm install -g nest eslint jest

RUN apk add openssl

USER node

# ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
# ENV PATH=$PATH:/home/node/.npm-global/bin

WORKDIR /app

COPY --chown=node:node package*.json ./

RUN npm ci

COPY --chown=node:node . .

RUN npm run build

CMD ["npm", "run", "start:dev"]

FROM dev AS prod

CMD ["npm", "run", "start:prod"]
