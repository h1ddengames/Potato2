FROM node
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json .
COPY package-lock.json .
RUN npm install -g @angular/cli
RUN npm install

# This needs to be run in an Angular Directory. Needs to Connect to a Pod or Shared Directory.
# RUN ng serve --open

COPY . /usr/src/app
EXPOSE 8080
CMD ["npm", "start"]
