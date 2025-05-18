require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const SEPOLIA_URL = process.env.SEPOLIA_URL; // 我的url
const PRIVATE_KEY = process.env.PRIVATE_KEY; // 我的key
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: SEPOLIA_URL,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: "3ARSERSNSRJ976XSVG7GUUX27A7FJDKRFD", // 我的apikey
  },
};
