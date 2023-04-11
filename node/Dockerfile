FROM node:15

WORKDIR /usr/src/app

# copies everything in the current folder (node) to the WORKDIR set earlier
# this works because this directory was mounted to the node:15 container we've created before,
# so all files the created before, although being in a container that no longer exists, were preserved
COPY . .

EXPOSE 3000

CMD [ "node", "index.js" ]