// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Lottery{
    address public owner;
    address payable[] public players;
    uint public LotteryId;
    mapping (uint => address payable) public lotteryHistory;

constructor() {
    owner = msg.sender;
    LotteryId = 1;
}

function getWinnerbyLottery(uint lottery) public view returns (address payable) {
    return lotteryHistory[lottery];
}

function getBalance() public view returns (uint){
    return address(this).balance;
}

function enter() public payable{
    require(msg.value > 1 ether);

 // address of player entering lottery

    players.push(payable(msg.sender));
}

function getrandomnumber() public view returns (uint){
    return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
}

function pickwinner() public onlyowner{
    uint index = getrandomnumber() % players.length;
    players[index].transfer(address(this).balance);

    lotteryHistory[LotteryId] = players[index];
        LotteryId++;
        

        // reset the state of the contract
        players = new address payable[](0);
}
modifier onlyowner(){
    require(msg.sender == owner);
    _;
}

}
