// contracts/Box.sol
// a simple contract that we can propose a new brand which is sustanialbe to be added to our Box contrct
// only the owner of the contract can be call the set
// the box will be owned by our governece process which is our timelock contract

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Box is Ownable {
  string private brandName;

  // Emitted when the stored value changes
  event ValueChanged(string newbrandName);

  // Stores a new value in the contract
  function store(string memory newbrandName) public onlyOwner {
    brandName = newbrandName;
    emit ValueChanged(newbrandName);
  }

  // Reads the last stored value
  function retrieve() public view returns (string memory) {
    return brandName;
  }
}