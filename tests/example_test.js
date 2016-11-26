
// EXAMPLE ONLY:

module.exports = {
  'Nightwatch.js Test' : function (browser) {
    console.log('Nightwatch test started');

    browser
      .url('http://hello.docker')
      .assert.containsText('#test', 'Hello, Docker World!')
      .end();

    console.log('Nightwatch test finished');
    console.log('¸¸♬·¯·♩¸¸♪·¯·♫¸¸Happy Dance¸¸♬·¯·♩¸¸♪·¯·♫¸¸');
  }
};
