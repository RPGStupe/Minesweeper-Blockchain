pragma solidity ^0.4.17;

import "./MinesweeperOwnership.sol";

contract MinesweeperMinting is MinesweeperOwnership{
    uint256 public constant MAX_SIZE = 100;
    uint256 public constant MIN_SIZE = 4;

    function createMinesweeperGame(uint16 _size, uint16 _bombCount) public returns (uint256) {
        require(_size <= MAX_SIZE && _size >= MIN_SIZE);
        require(_bombCount <= (_size*_size) - 1);

        uint256 _tokenId = _createPlayfield(_size, _bombCount);

        PlayfieldCreated(_size, _bombCount, msg.sender, _tokenId);
        return _tokenId;
    }
}