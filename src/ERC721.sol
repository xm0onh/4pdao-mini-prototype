// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";

contract ERC721 {
    using Strings for uint256;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );
    mapping(uint256 => address) private _owners;
    mapping(address => mapping(address => bool)) private _operators;
    mapping(address => uint256) private _balances;
    mapping(uint256 => uint256) public tokenScores;
    string baseURL = "";

    // uint256 public nextTokenId = 0;

    function play(uint256 _tokenId) public {
        // uint256 tokenId = nextTokenId;
        // nextTokenId += 1;
        tokenScores[_tokenId] = generateScore();
        // _safeMint(msg.sender, tokenId);
    }

    function generateScore() private view returns (uint256) {
        // Generate a random score between 0 and 100
        return
            uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) %
            101;
    }

    function mint(uint256 _tokenId) external {
        // Put restriction on stealing an existing token from the owner
        require(_owners[_tokenId] == address(0), "already minted");
        // Only 100 tokens can be minted
        require(_tokenId < 100, "_tokenId too large");

        emit Transfer(address(0), msg.sender, _tokenId);
        _owners[_tokenId] = msg.sender;
        _balances[msg.sender] += 1;
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        require(_owners[_tokenId] != address(0), "no such token");
        return _owners[_tokenId];
    }

    //*** It's better to use "safetransferFrom"
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable {
        // check if the token id exist s
        require(_owners[_tokenId] != address(0), "token does not exist");
        require(_owners[_tokenId] == _from, "cannot transfer");
        require(
            msg.sender == _from || _operators[_from][msg.sender],
            "required to be owner"
        );

        emit Transfer(_from, _to, _tokenId);
        _operators[_from][msg.sender] = false;
        _owners[_tokenId] = _to;
        _balances[_from] -= 1;
        _balances[_to] += 1;
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        require(_owners[_tokenId] != address(0), "token does not exist");

        return string(abi.encodePacked(baseURL, _tokenId.toString(), ".jpeg"));
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        _operators[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovedForAll(address _owner, address _operator)
        external
        view
        returns (bool)
    {
        return _operators[_owner][_operator];
    }

    function balanceOf(address _owner) external view returns (uint256) {
        require(_owner != address(0), "zero address");
        return _balances[_owner];
    }
}
