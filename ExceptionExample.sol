pragma solidity ^0.7.0;

contract ExceptionExample {
    
    mapping (address => uint64) public balanceReceived; //balancesdefault to 0
    
    function receiveMoney() public payable {
        //just increment to 
        //maybe sure we will end up with more
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender]+= uint64(msg.value);
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public {
        //check if he has enough ether
        require(_amount <= balanceReceived[msg.sender],"you dont have enough funds!");
        //make sure we will end up with less
        assert(balanceReceived[msg.sender] - uint64(_amount) <= balanceReceived[msg.sender]);
        //first do this, only then the transfer
        balanceReceived[msg.sender]-= _amount;
        _to.transfer(_amount);
    }
}