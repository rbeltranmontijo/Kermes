const assert = require("chai/lib/chai/interface/assert");

const Kermes = artifacts.require("Kermes");
let instance;

beforeEach(async () => {
  instance = await Kermes.new();
});

contract("Kermes", function(accounts) {
  it("should return the list of accounts", async () => {
    console.log(accounts);
  });
  it("should return the contract balance", async () => {
    let value = await instance.balanceOf();
    assert(value, 1000000);
  });
  it("should increase balance", async () => {
    await instance.generateNewTokens(10, { from: accounts[0] });
    let value = await instance.balanceOf();
    assert(value, 1000010);
  });
  it("should fail, You are not the owner", async () => {
    try {
      await instance.generateNewTokens(10, { from: accounts[1] });
    } catch (error) {
      return;
    }
    assert.fail();
  });
  it("should add comida", async () => {
    await instance.nuevaComida("Hamburguesa", 10);
    let value = instance.MappingComida("Hamburguesa");
    assert("Hamburguesa", value);
  });
});
