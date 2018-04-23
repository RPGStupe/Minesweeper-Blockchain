pragma solidity ^0.4.17;

/// @title Model of the Minesweeper token
/// @author Fabian Iwanecki
contract MinesweeperModel {
    event TileFlagged(uint256 x, uint256 y, uint256 tokenId);
    event TileUnflagged(uint256 x, uint256 y, uint256 tokenId);
    event TileOpened(uint256 x, uint256 y, uint256 tokenId);
    event PlayfieldCreated(uint256 _size, uint256 _bombCount, address owner, uint256 tokenId);
    event GameLost(uint256 tokenId);

    enum tileStatus {DEFAULT, FLAGGED, OPENED, OPENED_BOMB}

    struct Playfield {
        uint16 size;
        uint16 bombCount;
        bytes32 gameHash;
        mapping (uint16 => tileStatus) fieldToTileStatus;
        mapping (uint16 => bool) fieldToBomb;
    }
    
    mapping (uint256 => address) public tokenIdToOwner;
    uint256 nonce;
    Playfield[] playfields;

    function _createPlayfield(
        uint16 _size,
        uint16 _bombCount
    )
    internal
    returns (uint256) {
        Playfield memory _playfield = Playfield({
            size: _size,
            bombCount: _bombCount,
            gameHash: generateFieldHash(_size, _bombCount)
        });

        uint256 newTokenId = playfields.push(_playfield) - 1;

        tokenIdToOwner[newTokenId] = msg.sender;
        nonce++;

        return newTokenId;
    }

    function generateFieldHash(uint16 _size, uint16 _bombCount)
    internal
    view
    returns (bytes32) {
        return keccak256(_size, _bombCount, nonce);
    }
}