const expressValidator = require('express-validator');

module.exports = expressValidator({
  errorFormatter: (param, msg, value) => {
    const namespace = param.split('.');
    const root = namespace.shift();
    let formParam = root;

    while (namespace.length) {
      formParam += `[${namespace.shift()}]`;
    }

    return {
      param: formParam,
      msg,
      value
    };
  }
});
