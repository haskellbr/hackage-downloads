const request = require('superagent');
const blessed = require('blessed');
const contrib = require('blessed-contrib');
const Promise = require('bluebird');

Promise.promisifyAll(request.Request.prototype);

const screen = blessed.screen();
let data = {};

function randomColor() {
  return [Math.random() * 255,Math.random()*255, Math.random()*255]
}

const line = contrib.line({
  showLegend: true,
  style: {
    line: 'yellow',
    text: 'green',
    baseline: 'blue',
    label: 'Downloads over time',
  },
});
screen.append(line);
screen.render();

const start = new Date().getTime();
function updateDisplay(topPackages) {
  const now = new Date().getTime() - start;
  topPackages.forEach((p, i) => {
    if(!data[p.name]) data[p.name] = {
      x: [],
      y: [],
      title: p.name,
      style: {
        line: i,
        //text: randomColor()
      }
    };
    data[p.name].x.push(now);
    data[p.name].y.push(p.downloads);
  });
  line.setData(Object.keys(data).map(k => data[k]));
  screen.render();
}

setInterval(() => {
  request.get('http://localhost:9999/').end((err, res) => {
    if (err) return console.error(err);
    const topPackages = res.body.slice(0, 10);
    updateDisplay(topPackages);
  });
}, 1000);
