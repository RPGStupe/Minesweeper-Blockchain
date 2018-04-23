pragma solidity ^0.4.17;

import "./MinesweeperMinting.sol";

contract MinesweeperCore is MinesweeperMinting {

    function openTile(uint16 _x, uint16 _y, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));

        uint16 _size = playfields[_tokenId].size;

        require(playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] == tileStatus.DEFAULT);

        playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.OPENED;

        TileOpened(_x, _y, _tokenId);

        if (isBomb(_x, _y, _tokenId)) {
            playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.OPENED_BOMB;
            GameLost(_tokenId);
        }
    }

    function flagTile(uint16 _x, uint16 _y, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));
        
        uint16 _size = playfields[_tokenId].size;

        require(playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] == tileStatus.DEFAULT);

        playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.FLAGGED;

        TileFlagged(_x, _y, _tokenId);
    }

    function unflagTile(uint16 _x, uint16 _y, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));
        
        uint16 _size = playfields[_tokenId].size;

        require(playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] == tileStatus.FLAGGED);

        playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.DEFAULT;

        TileUnflagged(_x, _y, _tokenId);
    }

    function isBomb(uint16 _x, uint16 _y, uint256 _tokenId) internal view returns (bool) {
        uint16 _size = playfields[_tokenId].size;
        return playfields[_tokenId].fieldToBomb[(_y * _size) + _x];
    }

    function getGame(uint256 _tokenId) external view returns(uint256 _size, uint256 _bombCount, bytes32 _gameHash) {
        _size = playfields[_tokenId].size;
        _bombCount = playfields[_tokenId].bombCount;
        _gameHash = playfields[_tokenId].gameHash;
    }

    function getTile(uint16 _x, uint16 _y, uint256 _tokenId) external view returns(tileStatus) {
        uint16 _size = playfields[_tokenId].size;
        return playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x];
    }
}