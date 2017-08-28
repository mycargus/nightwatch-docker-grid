
var nightwatchConfig = require('../nightwatch.json');

// EXAMPLE ONLY:

module.exports = {
  'Nightwatch.js Test' : function (browser) {
    console.log('Nightwatch test started');

    browser
      .url(nightwatchConfig.test_settings.default.launch_url)
      .assert.containsText('#test', 'Hello, Docker World!')
      .end();

    console.log('Nightwatch test finished');
    console.log('¸¸♬·¯·♩¸¸♪·¯·♫¸¸Happy Dance¸¸♬·¯·♩¸¸♪·¯·♫¸¸');
  }
};
