export const arrayFromOperator = function (arr, comp, operator, flag) {
  const filtered = arr;
  if (flag) {
    filtered = filtered.filter(function (el) {
      return el != null;
    });
  } 

  filtered = filtered.map((element) => {
    if (operator.includes("=")) {
      if (operator.includes("!")) {
        return element != comp;
      } else if (operator.includes(">")) {
        return element >= comp;
      } else if (operator.includes("<")) {
        return element <= comp;
      } else {
        return element === comp;
      }
    } else if (operator.includes(">")) {
      if (operator.includes("<")) {
        return element != comp;
      } else {
        return element > comp;
      }
    } else if (operator.includes("<")) {
      return element < comp;
    }
  })
  return filtered;
}

export const all = function () {
  for (i = 0; i < arguments.length; i++) {
    if (typeof(arguments[i]) === 'array') {
        for (j = 0; j < arguments[i].length; j++) {
          if (!arguments[i][j]) {
            return false;
          }
        }
    } else {
      if (!arguments[i]) {
        return false;
      }
    }
  }
  return true;
}

export const any = function () {
  for (i = 0; i < arguments.length; i++) {
    if (typeof(arguments[i]) === 'array') {
        for (j = 0; j < arguments[i].length; j++) {
          if (arguments[i][j]) {
            return true;
          }
        }
    } else {
      if (arguments[i]) {
        return true;
      }
    }
  }
  return false;
}

export const isNull = function () {
  if (arguments.length === 1) {
    if (Array.isArray(arguments[0])) {
      for (i = 0; i < arguments[0].length; i++) {
        if (arguments[0][i] !== null) {
          return false;
        }
      }
      return true;
    } else if(arguments[0] === null) {
      return true;
    }

    return false;
  } else {
    throw `${arguments.length} arguments passed to 'isNull' which requires 1`;
  }
}

export const isFunction = function () {
  if (arguments.length === 1) {
    if (arguments[0] instanceof Function) {
      return true;
    }

    return false;
  } else {
    throw `${arguments.length} arguments passed to 'isFunction' which requires 1`;
  }
}

export const isFinite = function () {
  if (arguments.length === 1) {
    if (Array.isArray(arguments[0])) {
      return arguments[0].map(arg => isFinite(arg));
    } else {
      return isFinite(arguments[0]);
    }
  } else {
    throw `${arguments.length} arguments passed to 'isFinite' which requires 1`;
  }
}

export const isInfinite = function () {
  if (arguments.length === 1) {
    if (Array.isArray(arguments[0])) {
      return arguments[0].map(arg => arg === Infinity);
    } else {
      return arguments[0] === Infinity;
    }
  } else {
    throw `${arguments.length} arguments passed to 'isInfinite' which requires 1`;
  }
}

export const pWarn = function () {
  if (arguments.length === 0) {
    console.warn();
  } else if (arguments.length > 2) {
    console.warn(`in '${arguments[0].toString()}': ${arguments.join(' ')}`);
  } else {
    console.warn(`in ${arguments[0].toString()}`);
  }
}

export const pStop = function () {
  if (arguments.length === 0) {
    throw new Error;
  } else if (arguments.length > 2) {
    throw new Error `in '${arguments[0].toString()}': ${arguments.join(' ')}`;
  } else {
    throw new Error `in ${arguments[0].toString()}`;
  }
}

export const stop = function () {
  if (arguments.length > 0) {
    throw new Error `in ${arguments[0].toString()}`;
  }
  throw new Error;
}

export const nzchar = function () {
  let arr = []
  const _nzchar = function () {
    // let NA=undefined
    let arg = arguments
    if (arg[1] === undefined) arg[1] = false
    if (arg.length === 0) return "Error, 0 arguments passed to 'nzchar' which requires 1 to 2"
    if (arg[2]) return "Error, more than 1 arguments passed to 'nzchar' which requires 1 to 2"
    if ((arg[0] instanceof Object && (arg[0].length === undefined || arg[0].length === 0)) || arg[0] === null) return 'logical(0)'
    if (arg[0] === undefined && arg[1] == true) { arr.push (undefined) }
    if (arg[1] == false) {
      if (arg[0] !== '') arr.push (true)
      else arr.push(false)
    }
    if (Array.isArray(arg[0]) && arg[0].length > 0) {
      for (let i = 1; i < arg[0].length; i++) {
        _nzchar(arg[0][i])
      }
    }
    return arr
  }
  return _nzchar(...arguments)
}

//* #######################################
//* returns TRUE if its argument's value is NULL and FALSE otherwise.
export const isNull = function () {
  let arr = [];
  const _isNull = function () {
    let arg = arguments;
    if (arg.length === 0) {
      throw "Error, 0 arguments passed to 'isNull' which requires 1 to 2";
    }
    if (arg[1]) {
      throw "Error! more than 1 arguments passed to 'isNull' which requires 1";
    }
    if (arg[0] == null || (arg[0] instanceof Object && (arg[0].length === undefined || arg[0].length === 0))) {
      arr.push(true);
    } else {
      arr.push(false);
    }
    if (Array.isArray(arg[0]) && arg[0].length > 0) {
      for (let i = 1; i < arg[0].length; i++) {
        _isNull(arg[0][i])
      }
    }
    return arr
  }
  return _isNull(...arguments)
}

export const isNa = function () {
  let arr = []
  const _isNa = function () {
    let arg = arguments
    if (arg.length === 0) {
      throw "Error, 0 arguments passed to 'isNa' which requires 1 to 2";
    }
    if (arg[1]) {
      throw "Error! more than 1 arguments passed to 'isNa' which requires 1";
    }
    if (arg[0] == null || (arg[0] instanceof Object && (arg[0].length === undefined || arg[0].length === 0))) {
      return 'logical(0)';
    }
    if (arg[0] === undefined) {
      arr.push(true);
    } else {
      arr.push(false);
    }
    if (Array.isArray(arg[0]) && arg[0].length > 0) {
      for (let i = 1; i < arg[0].length; i++) {
        _isNa(arg[0][i]);
      }
    }
    return arr;
  }
  return _isNa(...arguments);
}

export const isNumeric = function () {
  let lg = true;
  if (arguments.length === 0) {
    throw "Error, 0 arguments passed to 'isNumeric' which requires 1 to 2";
  }
  if (arguments[1]) {
    throw "Error! more than 1 arguments passed to 'isNumeric' which requires 1";
  }
  if (arguments[0] === null || arguments[0] === undefined) {
    return false;
  }
  if (arguments[0] instanceof Object && (arguments[0].length === undefined || arguments[0].length === 0)) {
    return false;
  } else if (Array.isArray(arguments[0]) && arguments[0].length > 0) {
    for (let i = 1; i < arguments[0].length; i++) {
      lg = (typeof arguments[0][i] === 'number') && lg
    }
  }
  return lg
}

export const asLogical = function (value = 'Empty') {
  if (value === null || value === 'Empty') return 'logical(0)'
  if (isNaN(value) || value === undefined) return undefined
  if (Number.isInteger(value) !== true || value === 'F' || value === 'FALSE' || value === 'False') return false
  if (Number.isInteger(value) === true || value === 'T' || value === 'TRUE' || value === 'True') return true
}

export const seqLen = function (value = 'Empty') {
  if (value === 'Empty' || value === 0) return 'logical(0)'
  if (isNaN(value) || value === undefined || value === null || value < 0) return 'Error: argument must be coercible to non-negative integer'
  else {
    return Array.from(new Array(Math.round(value)), (val, index) => index + 1)
  }
}