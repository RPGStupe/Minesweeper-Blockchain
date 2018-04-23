var MinesweeperCore = artifacts.require("./MinesweeperCore.sol");

module.exports = function (deployer) {
  deployer.deploy(MinesweeperCore).then(function() {
    console.log("ADDRESS:", MinesweeperCore.address);
  });
};