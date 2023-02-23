import {HardhatUserConfig} from 'hardhat/types';
import 'hardhat-deploy';
import 'hardhat-deploy-ethers';
import '@nomiclabs/hardhat-etherscan';
import {node_url, accounts, apiKey} from './utils/network';
const config: HardhatUserConfig = {
    
    networks: {
        polygonMumbai: {
          url: node_url('mumbai'),
          accounts: accounts('mumbai'),
          allowUnlimitedContractSize: true
        },
        hardhat: {
            chainId: 31337,
            allowUnlimitedContractSize: true
          },
          localhost: {
            chainId: 31337,
            allowUnlimitedContractSize: true
          },

      },
      etherscan: {
        apiKey: {
            polygonMumbai: apiKey('mumbai'),
        }
      },
  solidity: {
    version: '0.8.9',
  },
  namedAccounts: {
    deployer: 0,
    tokenOwner: 1,
  },
  paths: {
    sources: 'src',
  },
};
export default config;
