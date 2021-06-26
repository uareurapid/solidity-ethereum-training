pragma solidity ^0.7.0;

contract SendMoneyExample  {
    
    uint public balanceReceived;
    uint public lockedUntil;
    
// msg { value: wei }
 //status   true Transaction mined and execution succeed
 //transaction hash 0x4e7b88ecfd34cff83a360b84dadd9b5287751e293c3156f1ac2b171c6533a78c Copy value to clipboard
 //from 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 Copy value to clipboard
 //to   SendMoneyExamplefunction.receiveMoney() 0xd9145CCE52D386f254917e481eB44e9943F39138 Copy value to clipboard
 //gas  3000000 gas Copy value to clipboard
 //transaction cost 21392 gas Copy value to clipboard
 //execution cost   120 gas Copy value to clipboard
 //hash 0x4e7b88ecfd34cff83a360b84dadd9b5287751e293c3156f1ac2b171c6533a78c Copy value to clipboard
 //input    0x6d2...6ec18 Copy value to clipboard
 //decoded input    {} Copy value to clipboard
 //decoded output   {} Copy value to clipboard
 //logs [] Copy value to clipboard Copy value to clipboard
 //value
    
    function receiveMoney() public payable {
        balanceReceived += msg.value;
        //message object
        //inside is the value of wei
        lockedUntil = block.timestamp + 1 minutes; //cannot withdraw until 1 minute after receiving
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
        //0xDA0bab807633f07f013f94DD0E6A4F96F8742B53
    }
    
    function withdrawMoney() public {
        //send teh money back to the address that called the smart contract
        if(lockedUntil < block.timestamp) {
           address payable to = payable(msg.sender);
           to.transfer(getBalance()); 
        }
        
    }
    
    function withdrawMoneyTo(address payable _to) public {
        //send teh money back to the address as param
        if(lockedUntil < block.timestamp) {
            _to.transfer(getBalance());
        }
    }
}