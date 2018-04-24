var MinesweeperCore = artifacts.require("MinesweeperCore");

contract("MinesweeperCore", function(accounts) {
    const user1 = accounts[0];
    const user2 = accounts[1];
    const user3 = accounts[2];
    let minesweeperCore;
    const pastEvents = [];
    const logEvents = [];

    deploy = async function() {
        minesweeperCore = await MinesweeperCore.new();

        // const eventsWatch = canvasCore.allEvents();

        // eventsWatch.watch((err, res) => {
        //     if (err) return;
        //     pastEvents.push(res);
        //     console.log(">>", res);
        // });

        // logEvents.push(eventsWatch);
    };

    unwatch = function() {
        // logEvents.forEach(ev => ev.stopWatching());
    };

    describe("createMinesweeperGame:", async function() {
        beforeEach(deploy);
        afterEach(unwatch);

        it("should create minesweeper game", async function() {
            await minesweeperCore.createMinesweeperGame(4, 4);
            const game = await minesweeperCore.getGame(0);
            console.log(game)
        });
    });
    describe("flagTile:", async function() {
        beforeEach(deploy);
        afterEach(unwatch);

        it("should flag a tile", async function() {
            await minesweeperCore.createMinesweeperGame(40, 1);
            const tileStatus = await minesweeperCore.getTile(0, 0, 0);
            console.log(tileStatus)
            await minesweeperCore.flagTile(0, 0, 0);
            
            const tileStatusFlagged = await minesweeperCore.getTile(0, 0, 0);
            console.log(tileStatusFlagged);
        });
    });
    describe("unflagTile:", async function() {
        beforeEach(deploy);
        afterEach(unwatch);

        it("should unflag a flagged tile", async function() {
            
            await minesweeperCore.createMinesweeperGame(40, 1);
            const tileStatus = await minesweeperCore.getTile(0, 0, 0);
            console.log(tileStatus)

            await minesweeperCore.flagTile(0, 0, 0);
            const tileStatusFlagged = await minesweeperCore.getTile(0, 0, 0);
            console.log(tileStatusFlagged);

            await minesweeperCore.unflagTile(0, 0, 0);
            const tileStatusUnflagged = await minesweeperCore.getTile(0, 0, 0);
            console.log(tileStatusUnflagged);
        });
    });

    describe("openTile:", async function() {
        beforeEach(deploy);
        afterEach(unwatch);

        it("should open a tile", async function() {
            
            await minesweeperCore.createMinesweeperGame(40, 1);
            const tileStatus = await minesweeperCore.getTile(0, 0, 0);
            console.log(tileStatus);

            await minesweeperCore.openTile(0, 0, 0);
            const tileStatusOpenedBomb = await minesweeperCore.getTile(0, 0, 0);
            console.log(tileStatusOpenedBomb);
        });
    });

    describe("playFullGame:", async function() {
        beforeEach(deploy);
        afterEach(unwatch);

        it("should win the game", async function() {
            await minesweeperCore.createMinesweeperGame(4, 4);
            const game = await minesweeperCore.getGame(0);
            await minesweeperCore.openTile(0, 0, 0);
            await minesweeperCore.openTile(1, 0, 0);
            await minesweeperCore.openTile(2, 0, 0);
            await minesweeperCore.flagTile(3, 0, 0);
            await minesweeperCore.openTile(0, 1, 0);
            await minesweeperCore.openTile(1, 1, 0);
            await minesweeperCore.flagTile(2, 1, 0);
            await minesweeperCore.openTile(3, 1, 0);
            await minesweeperCore.openTile(0, 2, 0);
            await minesweeperCore.openTile(1, 2, 0);
            await minesweeperCore.flagTile(2, 2, 0);
            await minesweeperCore.flagTile(3, 2, 0);
            await minesweeperCore.openTile(0, 3, 0);
            await minesweeperCore.openTile(1, 3, 0);
            await minesweeperCore.openTile(2, 3, 0);
            await minesweeperCore.openTile(3, 3, 0);
        });
    });
});