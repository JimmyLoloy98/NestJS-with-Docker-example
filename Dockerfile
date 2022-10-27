# Create a image in docker

# > docker build -t [name-image] .

# > docker run -p [port]:[port] --name [name2-image] [name-image]

# > docker push [username]/[name-image]

# > docker image tag update-nest-app jimmyloloy98/nest-app:1.0.0

# --------------------------------------------

# >>> docker run -p 80:3000 jimmyloloy98/nest-app:1.0.0

# --------------------------------------------

FROM node:18-alpine as deps
WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

FROM node:18-alpine as builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN yarn build

FROM node:18-alpine as runner
WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --production
COPY --from=builder /app/dist ./dist


CMD ["node", "dist/main"]
