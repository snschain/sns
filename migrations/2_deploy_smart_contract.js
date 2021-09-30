const Sns = artifacts.require("Sns");

module.exports = function (deployer) {
  deployer.deploy(Sns);
};
