// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract Lottery {
    address public owner;
    address payable[] public players;
    uint private lotteryId;
    mapping (uint => address payable) public lotteryHistory;

    /** 
     * @dev Event emitted when a player enters the lottery.
    * @param player The address of the player who entered.
    * @param amount The amount (in wei) sent by the player as the entry fee.
    */
    event PlayerEntered(address indexed player, uint amount);

    /** 
    * @dev Event emitted when a winner is picked.
    * @param winner The address of the player who won.
    * @param amount The amount (in wei) transferred to the winner.
    */
    event WinnerPicked(address indexed winner, uint amount);


    

    /** 
     * @dev Constructor initializes the owner and sets the initial lottery ID.
     */
    constructor() {
        owner = msg.sender;
        lotteryId = 1;
    }

    /** 
     * @dev View function to get the winner of a specific lottery.
     * @param lottery The ID of the lottery.
     * @return The address of the winner.
     */
    function getWinnerByLottery(uint lottery) public view returns (address payable) {
        require(lottery > 0, "Invalid lottery ID");
        require(lottery <= lotteryId, "Lottery ID exceeds current lottery");
        return lotteryHistory[lottery];
    }

    /** 
     * @dev View function to get the current lottery ID.
     * @return The current lottery ID.
     */
    function getLotteryId() public view returns (uint) {
        return lotteryId;
    }

    /** 
     * @dev View function to get the current contract balance.
     * @return The current contract balance.
     */
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    /** 
     * @dev View function to get the list of players.
     * @return The array of player addresses.
     */
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    /** 
     * @dev Function to allow players to enter the lottery by sending a minimum entry fee.
     * Requires that the lottery is not closed (lotteryId is 1).
     */

    function enter() public payable {
        require(msg.value > 0.01 ether, "Minimum entry fee is 0.01 ether");
        require(lotteryId == 1, "Cannot enter after winner is picked");
        // Add the player to the list of participants
        players.push(payable(msg.sender));
        // Emit PlayerEntered event
        emit PlayerEntered(msg.sender, msg.value);
    }

    /** 
     * @dev View function to generate a pseudo-random number based on owner and block information.
     * @return A pseudo-random number.
     */
    function getRandomNumber() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, blockhash(block.number - 1))));
    }

    /** 
     * @dev Function to pick a winner by transferring the contract balance to a randomly selected player.
     * @dev Emits WinnerPicked event.
     */
    function pickWinner() public onlyowner {
        // Ensure there are participants
        require(players.length > 0, "No participants in the lottery");

        // Select a random index from the array of players
        uint index = getRandomNumber() % players.length;
        
        // Transfer the contract balance to the winner
        players[index].transfer(address(this).balance);
        
        // Emit WinnerPicked event
        emit WinnerPicked(players[index], address(this).balance);

        // Record the winner in the lottery history
        lotteryHistory[lotteryId] = players[index];

        // Increment the lottery ID for the next round
        lotteryId++;
        
        // Reset the list of players
        players = new address payable[](0);
    }

    /** 
     * @dev Modifier to restrict access to the owner of the contract.
     */
    modifier onlyowner() {
      require(msg.sender == owner, "Only the owner can call this function");
      _;
    }
}
