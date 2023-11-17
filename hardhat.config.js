require("@nomiclabs/hardhat-ethers");

module.exports = {
  defaultNetwork: "localhost",
  networks: {
    hardhat: {
      forking: {
        url: "https://rpc.scroll.io"
      }
    }
  },
  solidity: {
    version: "0.8.4", 
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};