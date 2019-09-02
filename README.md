[![Build Status](https://travis-ci.com/doerfli/rss-mock-server.svg?branch=master)](https://travis-ci.com/doerfli/rss-mock-server) 

# README

This application will create mock RSS and Atom feeds for testing purposes. 

Run `rails server` to start the application. There is also a docker image available on [DockerHub](https://hub.docker.com/r/doerfli/rss-mock-server), use the `docker-compose.yml` for easy setup. 

Once the server is up and running go to `localhost:3000/feeds/randomfeed.rss` to create a new rss feed (you may replace `randomfeed` with any id you like). New items will be added every 60 seconds by default. To create an atom feed, go to `localhost:3000/feeds/randomfeed.atom` 

If you want a different interval, add the query parameter `interval` to the url. E.g. `<host>:<port>/feeds/<somefeedid>.rss?interval=10` 

If you want a different number of items, add the query parameter `items` to the url. E.g. `<host>:<port>/feeds/<somefeedid>.atom?items=30` 
