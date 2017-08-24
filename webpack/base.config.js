const path = require("path");
const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = function() {
    return {
        entry: {
            client: [
                path.resolve(__dirname, "..", "src", "client", "index.js")
            ]
        },

        output: {
            path: path.resolve(__dirname, "..", "dist"),
            filename: "[name].[chunkhash].js",
        },

        context: path.resolve(__dirname, ".."),

        resolve: {
            modules: [
                "node_modules",
                path.resolve(path.join("src", "client"))
            ],

            extensions: [ ".js", ".elm", ".less", ".css", ".config.js" ]
        },

        module: {
            rules: [{
                    test: /\.(css|scss)$/,
                    use: ExtractTextPlugin.extract({
                        use: [ "css-loader" ],
                        fallback: "style-loader"
                    })
                },
                {
                    test: /\.elm$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    loader: "elm-webpack-loader?verbose=true&warn=true",
                },
                {
                    test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                    loader: "url-loader?limit=10000&mimetype=application/font-woff",
                },
                {
                    test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                    loader: "file-loader",
                },
                {
                    test: /\.less$/,
                    use: ExtractTextPlugin.extract({
                        use: ["css-loader", "less-loader"],
                        fallback: "style-loader"
                    })
                }
            ],

            noParse: /\.elm$/,
        },

        plugins: [

            new ExtractTextPlugin("[name].[chunkhash].css"),

            new webpack.optimize.CommonsChunkPlugin({
                name: "vendor",
                minChunks: function (module) {
                // this assumes your vendor imports exist in the node_modules directory
                return module.context && module.context.indexOf("node_modules") !== -1;
                }
            }),

            new webpack.optimize.CommonsChunkPlugin({
                name: "manifest" //But since there are no more common modules between them we end up with just the runtime code included in the manifest file
            }),

            new HtmlWebpackPlugin({
                template: path.resolve(__dirname, "..", "src", "client", "index.html"),
                inject: "body",
            })
        ]

    };
}
