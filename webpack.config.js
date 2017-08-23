const path = require("path");

function buildConfig(env) {
    return require(path.resolve(__dirname, "webpack", `${env}.config.js`))(env)
}

module.exports = buildConfig;
