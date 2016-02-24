# A Dockerized Selenium Grid with Nightwatch

I built this project to quickly provision a dockerized environment for running
UI tests against a dockerized app. It employs a dockerized [Selenium Grid](https://github.com/SeleniumHQ/selenium/wiki/Grid2), which yields a far more cost-effective CI solution compared to purchasing and maintaining *n* dedicated machines.

This project is geared toward a Node.js audience, meaning I've included `npm`
scripts as wrappers for the `docker-compose` commands. Hopefully, once you've
completed the initial setup, you won't have to recall any docker commands. :smiley:

Nightwatch serves as the testrunner. It is automatically provisioned in the
 `nightwatch` docker image, which you can easily customize in the included `nightwatch.json` file.

This project is available as a docker image [on docker hub](https://hub.docker.com/r/mycargus/docker-grid-nightwatch/).

### Dependencies

The following instructions are for Mac OSX users.

1. [dinghy](https://github.com/codekitchen/dinghy)  <--- You'll love it!!
2. docker-compose: `$ brew install docker-compose`
3. a docker image of the app under test

### Setup

Add the docker image of the app under test to the `docker-compose.yml` file. Be sure to define its virtual URL (a default is provided). For example:
``` 
web:
  image: app-under-test:latest
  environment:
    VIRTUAL_HOST: app.under.test
```

That was easy!

NOTE: `VIRTUAL_HOST` is your app's URL against which Nightwatch will execute the tests. It can be whatever you want. If you change it, be sure to replace the launch_url value located in the `nightwatch.json` file.

### How do I execute the tests?

Start dinghy if it isn't already running:
```sh
$ dinghy up
```

Start the Selenium hub, the app under test, and the Selenium browser nodes:
```sh
$ npm start
```

Execute the tests with Nightwatch:
```sh
$ npm test
```

When you're done, stop and remove the docker containers:
```sh
$ npm stop
```

### Can I view the Selenium grid console?

Yep! After having started the Selenium hub and nodes (`$ npm start`), open a
browser and go to [http://selenium.hub.quiz.docker](http://selenium.hub.quiz.docker), then
click the 'console' link.

### A test is failing. How do I debug it?

Start the Selenium hub, the quiz_web app, and the Selenium *debug* browser nodes:
```sh
$ npm run debug_start
```

View the chrome debug node via VNC (password: `secret`):
```sh
$ open vnc://debug.chrome.quiz.docker
```

View the firefox debug node via VNC (password: `secret`):
```sh
$ open vnc://debug.firefox.quiz.docker
```

Next execute the Nightwatch tests against the debug nodes:
```sh
$ npm run debug_test
```

Again, once you're finished:
```sh
$ npm stop
```
