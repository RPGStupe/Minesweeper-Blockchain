pragma solidity ^0.4.17;

/// @title Model of the Minesweeper token
/// @author Fabian Iwanecki
contract MinesweeperModel {
    event TileFlagged(int16 x, int16 y, uint256 tokenId);
    event TileUnflagged(int16 x, int16 y, uint256 tokenId);
    event TileOpened(int16 x, int16 y, uint8 bombs, uint256 tokenId);
    event PlayfieldCreated(int16 _size, int16 _bombCount, address owner, uint256 tokenId);
    event GameLost(uint256 tokenId);
    event GameWon(int16 tokenId);
    event TestEvent(int16 x, int16 y, bool bomb);
    event BombPlaced(int16 random);

    enum tileStatus {DEFAULT, FLAGGED, OPENED, OPENED_BOMB}

    struct Playfield {
        int16 size;
        int16 bombCount;
        bytes32 gameHash;
        int16 tilesOpened;
        bool locked;
        mapping (int16 => tileStatus) fieldToTileStatus;
        mapping (int16 => bool) fieldToBomb;
        mapping (int16 => uint8) fieldToBombsNearby;
    }
    
    mapping (uint256 => address) public tokenIdToOwner;
    uint256 nonce;
    Playfield[] playfields;

    function _createPlayfield(
        int16 _size,
        int16 _bombCount
    )
    internal
    returns (uint256) {
        Playfield memory _playfield = Playfield({
            size: _size,
            bombCount: _bombCount,
            gameHash: generateFieldHash(_size, _bombCount),
            tilesOpened: 0,
            locked: false
        });

        uint256 newTokenId = playfields.push(_playfield) - 1;

        tokenIdToOwner[newTokenId] = msg.sender;
        nonce++;

        return newTokenId;
    }

    function generateFieldHash(int16 _size, int16 _bombCount)
    internal
    view
    returns (bytes32) {
        return keccak256(_size, _bombCount, nonce);
    }
}