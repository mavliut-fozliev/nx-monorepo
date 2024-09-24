const path = require("path");
const nodeExternals = require("webpack-node-externals");

module.exports = {
  entry: "./src/main.ts", // Entry point of your application
  target: "node", // Specifies the environment in which the code will run
  externals: [nodeExternals()], // Exclude node_modules from the bundle
  output: {
    path: path.resolve(__dirname, "..", "..", "dist"), // Output directory
    filename: "main.js" // Output file name
  },
  resolve: {
    extensions: [".ts", ".js"] // File extensions to process
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: "ts-loader", // Use ts-loader to transpile TypeScript files
        exclude: /node_modules/
      }
    ]
  }
};
