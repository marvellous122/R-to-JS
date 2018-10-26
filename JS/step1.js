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
    if (arguments[0] === null) {
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
    if (arguments[0] instanceof Array) {
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
    if (arguments[0] instanceof Array) {
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