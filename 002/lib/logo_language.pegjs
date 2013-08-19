start
  = gridSize:gridSize statements:(statement)* {return {gridSize: gridSize, statements: statements}}

gridSize = value:integer __ {return value}

statement = move
    / repeat

move = op:movement __ value:integer __ { return {perform: op, arg: value} }

repeat = "REPEAT" __ repeatCount:integer __ "[" __ statements:(statement)+ "]" __? {
    return {perform: "REPEAT", arg: {repeatCount: repeatCount, statements: statements} }
}

movement
  = (
       "FD"
     / "RT"
     / "LT"
     / "BK"
)

integer "integer"
  = digits:[0-9]+ { return parseInt(digits.join(""), 10); }

/* white space */
__
  = ( whiteSpace / lineTerminator )*

whiteSpace 
  = [\t\v\f \u00A0\uFEFF]

lineTerminator 
  = [\r\n]