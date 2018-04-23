pragma solidity ^0.4.17;

import "./MinesweeperModel.sol";
import "./NFTBase.sol";

/// @title Model of the Minesweeper token
/// @author Fabian Iwanecki
contract MinesweeperOwnership is MinesweeperModel, NFTBase {
    string public constant NAME = "Minesweeper Ethereum";
    string public constant SYMBOL = "MSE";

    function totalSupply() public view returns (uint256) {
        return playfields.length;
    } 

    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return tokenIdToOwner[_tokenId] == _claimant;
    }

    function ownerOf(uint256 _tokenId) public view returns (address owner) {
        owner = tokenIdToOwner[_tokenId];

        require(owner != address(0));
    }
}