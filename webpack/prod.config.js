const webpackMerge = require('webpack-merge');
const webpack = require("webpack");

const baseConfig = require("./base.config.js");

module.exports = function() {
    return webpackMerge(baseConfig(), {
        plugins: [
            new webpack.LoaderOptionsPlugin({
                minimize: true,
                debug: false
            }),
            new webpack.DefinePlugin({
                'process.env': {
                    'NODE_ENV': JSON.stringify('production')
                }
            }),
            new webpack.optimize.UglifyJsPlugin({
                beautify: false,
                mangle: {
                    screw_ie8: true,
                    keep_fnames: true
                },
                compress: {
                    screw_ie8: true
                },
                comments: false,
                sourceMap: false
            })   
        ]
    });
}
