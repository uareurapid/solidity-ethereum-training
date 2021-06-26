pragma solidity ^0.7.0;

contract FunctionsExample {
    
    mapping (address => uint) public balanceReceived; //balancesdefault to 0
    
    address payable owner; //contract owner
    
    
    constructor() /*public*/ { //on newer versions viibility of constructor is irrelevant
        owner = msg.sender;
    }
    
    //get teh contract owner
    function getOwner() public view returns(address) {
        return owner;
    }
    
    //pure function (not related to internal state)
    //not interacting with storage variables
    function convertWeiToEth(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether; //10^18 -> 1000000000000000000
    }
    
    //destroy and send the rest of the funds to teh owner
    function destroySmartContract() public {
        require(msg.sender == owner,'you must be the owner of the smart contract');
        selfdestruct(owner);
    }
    
    function receiveMoney() public payable {
        //just increment to 
        //maybe sure we will end up with more
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public {
        //check if he has enough ether
        require(_amount <= balanceReceived[msg.sender],"you dont have enough funds!");
        //make sure we will end up with less
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount );
        //first do this, only then the transfer
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    //fallback, on previous versions was => function
    fallback () external payable {
        
        //get money in
        receiveMoney();
    }
    
    receive () external payable {
        
    }
    
   
}