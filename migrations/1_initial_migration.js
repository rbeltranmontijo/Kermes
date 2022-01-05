const Migrations = artifacts.require("Migrations");
const Kermes = artifacts.require("Kermes");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Kermes);
};
