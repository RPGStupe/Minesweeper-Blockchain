pragma solidity ^0.4.17;

/// @title Interface for a Minesweeper Token
/// @author Fabian Iwanecki
/// Every minesweeper game is represented by a NFT.
contract NFTBase {
    function totalSupply() public view returns (uint256 total);
    function ownerOf(uint256 _tokenId) public view returns (address owner);

    // Optional
    // function name() public view returns (string name);
    // function symbol() public view returns (string symbol);
    // function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256 tokenId);
    // function tokenMetadata(uint256 _tokenId) public view returns (string infoUrl);
}