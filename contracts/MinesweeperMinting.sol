pragma solidity ^0.4.17;

import "./MinesweeperOwnership.sol";

contract MinesweeperMinting is MinesweeperOwnership{
    int16 public constant MAX_SIZE = 100;
    int16 public constant MIN_SIZE = 4;

    function createMinesweeperGame(int16 _size, int16 _bombCount) public returns (uint256) {
        require(_size <= MAX_SIZE && _size >= MIN_SIZE);
        require(_bombCount <= _size);

        uint256 _tokenId = _createPlayfield(_size, _bombCount);

        placeBombs(_tokenId);

        PlayfieldCreated(_size, _bombCount, msg.sender, _tokenId);
        
        return _tokenId;
    }

    function placeBombs(uint256 _tokenId) internal {
        int16 size = playfields[_tokenId].size;
        int16 bombCount = playfields[_tokenId].bombCount;
        bytes32 gameHash = playfields[_tokenId].gameHash;

        uint256 nonce = 0;

        for (int16 i = 0; i < bombCount; i++) {
            int16 random = int16(pseudoRandom(0, uint16(size*size) - 1, gameHash, nonce));
            nonce++;
            if (playfields[_tokenId].fieldToBomb[random]) {
                i--;
            }
            playfields[_tokenId].fieldToBomb[random] = true;
            BombPlaced(random);
        } 
    }

    function pseudoRandom(uint16 _min, uint16 _max, bytes32 _gameHash, uint256 nonce) internal pure returns (uint16) {
        return uint16(keccak256(_gameHash, nonce))%(_min+_max)-_min;
    }
}