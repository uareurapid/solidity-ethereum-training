pragma solidity ^0.7.0;

contract MappingsStructExample {
    
    //amount and when
    struct Payment {
        uint amount;
        uint timestamps;
    }
    
    //total balance + mum of payments done
    struct Balance {
        uint totalBalance;
        uint numPayments;
        //is a counter?
        mapping (uint => Payment) payments;
    }
    
    mapping (address => Balance) public balancesReceived;
    
    mapping (address => uint) public balanceReceived;
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    //send money to the smart contract
    function sendMoney() public payable {
        //use the sender as index for the array (store how much is received from a given address)
        balanceReceived[msg.sender] += msg.value;
        
        //updated way ----------------
        balancesReceived[msg.sender].totalBalance += msg.value;
        //report teh payments, because is a reference type we need to specify where is gonna be stored (memory)
        Payment memory payment = Payment(msg.value, block.timestamp /*now*/);
        //now is deprecated, use block.timestamp instead
        
        //get the index on the counter
        uint numPaymentsIdx = balancesReceived[msg.sender].numPayments;
        
        balancesReceived[msg.sender].payments[numPaymentsIdx] = payment;
        
        //------------ OR

        // balancesReceived[msg.sender].payments[ balancesReceived[msg.sender].numPayments ] = payment;   
        
        //--------------------
        
        //increment the counter
        balancesReceived[msg.sender].numPayments += 1;
        
        //-----------------------OR
        
        //numPaymentsIdx +=1;
        //balancesReceived[msg.sender].numPayments = numPaymentsIdx;
        
        //---------------------------------------
    }
    
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender]; 
        //get how much i have on the contract for this address
        //and set it to 0
        balanceReceived[msg.sender] = 0;
        //then send the amount that was there
        _to.transfer(balanceToSend);
        //_to.transfer(address(this).balance);
    }
    
    //same as above but using the struct
    function withdrawAllMoneyStruct(address payable _to) public {
        uint balanceToSend = balancesReceived[msg.sender].totalBalance; 
        balancesReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }
    
    
    function withdrawMoney(address payable _to, uint _amount) public{
       require(balanceReceived[msg.sender] >= _amount, 'not enough funds!');
       balanceReceived[msg.sender] -= _amount;
       _to.transfer(_amount);
    }
    
    //same as above but using the struct
    function withdrawMoneyStruct(address payable _to, uint _amount) public{
       require(balancesReceived[msg.sender].totalBalance >= _amount, 'not enough funds!');
       balancesReceived[msg.sender].totalBalance -= _amount;
       _to.transfer(_amount);
    }
}