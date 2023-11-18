require("@nomiclabs/hardhat-ethers");

module.exports = {
  defaultNetwork: "localhost",
  networks: {
    hardhat: {
      forking: {
        url: "https://not-yet"
      }
    }
  },
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};