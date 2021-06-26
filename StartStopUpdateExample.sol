pragma solidity ^0.7.0;

contract StartStopUpdateExample {
    
    address contractOwner;
    bool public paused; //paused contract
    
    constructor()  {
        contractOwner = msg.sender;
    }
    
    function sendMoney() public payable {
        
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == contractOwner, "You are not the owner");
        paused = _paused;
    }
    
    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == contractOwner, "you need to be the owner");
        require(!paused,"contract is paused, cannot withdraw at the moment");
        _to.transfer( address(this).balance);
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function destroySmartContract(address payable _to) public {
        //who will get the rest of teh funds stored here? on _to argument
        require(msg.sender == contractOwner, "you are not the owner, cannot destroy");
        selfdestruct(_to);
    }
}