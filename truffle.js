var mnemonic = "candy maple cake sugar pudding cream honey rich smooth crumble sweet treat";
module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 7545,
      network_id: "*" // Match any network id
    },
    cli: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    }  
  }
};
