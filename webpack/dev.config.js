const webpackMerge = require('webpack-merge');
const path = require("path");

const baseConfig = require("./base.config.js");

module.exports = function() {
    return webpackMerge(baseConfig(), {
        devtool: "source-map",

        devServer: {
            inline: true,
            port: 8000,
            contentBase: path.resolve(__dirname, "..", "dist"),
            stats: {
                colors: true
            },
        },
    });
}
