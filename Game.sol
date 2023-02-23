// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Game is ERC721 {

    // The game allows players to "play" by generating a random score and minting a new ERC721 token to represent their score. 
    // The token ID is incremented for each new token created, and the score is stored in a mapping.

    uint256 public nextTokenId = 0;
    mapping(uint256 => uint256) public tokenScores;

    constructor() ERC721("Game", "Gm") {}

    function play() public {
        uint256 tokenId = nextTokenId;
        nextTokenId += 1;
        tokenScores[tokenId] = generateScore();
        _safeMint(msg.sender, tokenId);
    }

    function generateScore() private view returns (uint256) {
        // Generate a random score between 0 and 100
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 101;
    }
    
}
