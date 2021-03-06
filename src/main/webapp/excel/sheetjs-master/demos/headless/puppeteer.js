/* xlsx.js (C) 2013-present  SheetJS -- http://sheetjs.com */
const puppeteer = require('excel/sheetjs-master/demos/headless/puppeteer');

(async () => {

  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('http://oss.sheetjs.com/sheetjs/tests/', {waitUntil: 'load'});
	await page.waitFor(30*1000);
  await page.pdf({path: 'test.pdf', format: 'A4'});

  browser.close();
})();

