pragma solidity ^0.4.17;

import "./MinesweeperMinting.sol";

contract MinesweeperCore is MinesweeperMinting {

    function openTile(int16 _x, int16 _y, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));
        require(!_locked(_tokenId));

        int16 _size = playfields[_tokenId].size;

        require(playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] == tileStatus.DEFAULT);

        playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.OPENED;

        playfields[_tokenId].tilesOpened++;

        uint8 bombCount = 0;

        for (int16 y = -1; y < 2; y++) {
            for (int16 x = -1; x < 2; x++) {
                if (_y + y >= 0 && _x + x >= 0) {
                    if (isBomb(_x + x, _y + y, _tokenId)) {
                        bombCount++;
                    }
                }
            }
        }

        playfields[_tokenId].fieldToBombsNearby[(_y * _size) + _x] = bombCount;

        TileOpened(_x, _y, bombCount, _tokenId);

        if (isBomb(_x, _y, _tokenId)) {
            playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.OPENED_BOMB;
            GameLost(_tokenId);
            lockGame(_tokenId);
        } else {
            if (playfields[_tokenId].tilesOpened == (_size*_size) - playfields[_tokenId].bombCount) {
                GameWon(_size*_size - playfields[_tokenId].bombCount);
                lockGame(_tokenId);
            }
        }
    }

    function lockGame(uint256 _tokenId) internal {
        playfields[_tokenId].locked = true;
    }

    function flagTile(int16 _x, int16 _y, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));
        require(!_locked(_tokenId));
        
        int16 _size = playfields[_tokenId].size;

        require(playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] == tileStatus.DEFAULT);

        playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.FLAGGED;

        TileFlagged(_x, _y, _tokenId);
    }

    function unflagTile(int16 _x, int16 _y, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));
        require(!_locked(_tokenId));
        
        int16 _size = playfields[_tokenId].size;

        require(playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] == tileStatus.FLAGGED);

        playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x] = tileStatus.DEFAULT;

        TileUnflagged(_x, _y, _tokenId);
    }

    function isBomb(int16 _x, int16 _y, uint256 _tokenId) public view returns (bool) {
        int16 _size = playfields[_tokenId].size;
        return playfields[_tokenId].fieldToBomb[(_y * _size) + _x];
    }

    function getGame(uint256 _tokenId) external view returns(int16 _size, int16 _bombCount, bytes32 _gameHash, int16 _tilesOpened, bool _locked) {
        _size = playfields[_tokenId].size;
        _bombCount = playfields[_tokenId].bombCount;
        _gameHash = playfields[_tokenId].gameHash;
        _tilesOpened = playfields[_tokenId].tilesOpened;
        _locked = playfields[_tokenId].locked;
    }

    function getTile(int16 _x, int16 _y, uint256 _tokenId) external view returns(tileStatus) {
        int16 _size = playfields[_tokenId].size;
        return playfields[_tokenId].fieldToTileStatus[(_y * _size) + _x];
    }
}