FROM library/node:14.16-alpine

# Prepare the destination
RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY --chown=node:node package* /usr/app/

# Make the install in the container to avoid compilation problems
RUN yarn install --production && \
    yarn autoclean --init && \
    yarn autoclean --force

# Clean image
RUN npm uninstall -g npm && \
    rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp

# Add source files
COPY --chown=node:node . /usr/app

EXPOSE 3000 8020

# Start application
ENTRYPOINT ["node", "server.js"]
