const crowdsale = artifacts.require('CROWDSALE');
module.exports = function(deployer) {
 deployer.deploy(crowdsale);
};
