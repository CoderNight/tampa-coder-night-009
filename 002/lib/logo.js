var Grid = require("./grid.js");

var Logo = (function () {

  function Logo() {
    this.coord = {x: 0, y: 0};
    this.grid = null;
    this.orientation = 0;
    this.printEachStep = false;
    commands = {"FD": this.moveForward.bind(this),
      "BK": this.moveBackward.bind(this),
      "RT": this.rotateRight.bind(this),
      "LT": this.rotateLeft.bind(this),
      "REPEAT": this.repeat.bind(this)};
  }

  // "Private" fields / methods
  var commands;

  function wrap360(value) {
    var ret = value % 360;
    return ret < 0 ? 360 + ret : ret;
  }

  // Public methods
  Logo.prototype.run = function (program) {
    var gridSize = program.gridSize;
    this.grid = new Grid(gridSize);
    this.grid.init();
    this.coord = this.grid.center();
    this.runStatements(program.statements);
    this.grid.print();
  };

  Logo.prototype.rotateRight = function (degrees) {
    this.rotate(degrees);
  };

  Logo.prototype.rotateLeft = function (degrees) {
    this.rotate(-1 * degrees);
  };

  Logo.prototype.rotate = function (degrees) {
    this.orientation = wrap360(this.orientation + degrees);
  };

  Logo.prototype.repeat = function (arg) {
    for (var j = 0; j < arg.repeatCount; j++) {
      this.runStatements(arg.statements);
    }
  };

  Logo.prototype.runStatements = function (statements) {
    for (var i = 0; i < statements.length; i++) {
      var statement = statements[i];
      commands[statement.perform](statement.arg);
    }
  };

  Logo.prototype.moveBackward = function (count) {
    this.move(count, -1);
  };

  Logo.prototype.moveForward = function (count) {
    this.move(count, 1);
  };

  Logo.prototype.move = function (count, direction) {
    for (var i = 0; i < count; i++) {
      switch (this.orientation) {
        case 0:
        {
          this.coord.y = this.coord.y - direction;
          break;
        }
        case 45:
        {
          this.coord.y = this.coord.y - direction;
          this.coord.x = this.coord.x + direction;
          break;
        }
        case 90:
        {
          this.coord.x = this.coord.x + direction;
          break;
        }
        case 135:
        {
          this.coord.y = this.coord.y + direction;
          this.coord.x = this.coord.x + direction;
          break;
        }
        case 180:
        {
          this.coord.y = this.coord.y + direction;
          break;
        }
        case 225:
        {
          this.coord.y = this.coord.y + direction;
          this.coord.x = this.coord.x - direction;
          break;
        }
        case 270:
        {
          this.coord.x = this.coord.x - direction;
          break;
        }
        case 315:
        {
          this.coord.y = this.coord.y - direction;
          this.coord.x = this.coord.x - direction;
          break;
        }
        default :
        {
          throw("Invalid orientation: " + this.orientation);
        }
      }
      // If we go "out of bounds" the grid will give us corrected wraparound coordinates
      this.coord = this.grid.plot(this.coord);
    }

    if (this.printEachStep) {
      this.grid.print();
    }
  };

  return Logo;
})();

module.exports = Logo;