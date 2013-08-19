module.exports = Grid;

var util = require("util");

function Grid(gridSize) {
  this.gridSize = gridSize;
  this.grid = [];
}

Grid.prototype.init = function () {
  this.grid = new Array(this.gridSize);
  for (var y = 0; y < this.gridSize; y++) {
    this.grid[y] = new Array(this.gridSize);
    for (var x = 0; x < this.gridSize; x++) {
      this.grid[y][x] = ".";
    }
  }
}

Grid.prototype.print = function () {
  var out = "";
  for (var i = 0; i < this.gridSize; i++) {
    for (var j = 0; j < this.gridSize; j++) {
      out += this.grid[i][j];
    }
    out += ("\n");
  }
  out += ("\n");
  util.puts(out);
};

Grid.prototype.center = function () {
  var halfGrid = Math.floor(this.gridSize / 2);
  var coord = {x: halfGrid, y: halfGrid};
  this.plot(coord);
  return coord;
};

Grid.prototype.plot = function (coord) {
  var correctedCoord = {x: this.wrapGrid(coord.x), y: this.wrapGrid(coord.y)};
  try {
    this.grid[correctedCoord.y][correctedCoord.x] = "*";
    return correctedCoord;
  } catch (e) {
    util.error("Can't plot " + correctedCoord.x + ", " + correctedCoord.y);
    throw(e);
  }
};

Grid.prototype.wrapGrid = function (value) {
  if (value >= 0) {
    return value % this.gridSize;
  } else {
    return this.gridSize - Math.abs(value % this.gridSize);
  }
};
