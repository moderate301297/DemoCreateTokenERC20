const TokenStar = artifacts.require("TokenStar");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(TokenStar);
};
