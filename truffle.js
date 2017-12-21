var HDWalletProvider = require("truffle-hdwallet-provider");

var infura_apikey = "KVWpgNwEzl6mwPZTMR9L";
var mnemonic = "hybrid oxygen disease people enemy sight girl obscure mean damage weather slow";

module.exports = {

 networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
	ropsten: {
      provider: new HDWalletProvider(mnemonic, "https://ropsten.infura.io/"+infura_apikey),
      network_id: 3,
	  gas: 4000000
    }
}
};
