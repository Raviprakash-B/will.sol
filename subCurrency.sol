// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Coin{
    address public minter;
    mapping(address => uint)public balances;

    //To allow client to react what is hapening
    //These logs are stored in a blockchain and are accessible using address of the contract till the contract is present in the blockchain  
    event Sent(address from, address to,uint amount);//sent will take 3 arguments //it stores arguments 

    //Contructor reuns only when we deploy our contract
    constructor(){
        minter = msg.sender;
    }

    //make new coins and send them to an address 
    //only the owner can send these coins
    function mint(address reciever,uint amount) public
    {
        require(msg.sender == minter);  //sender should be only minter
        balances[reciever] = balances[reciever] + amount;  //create list of reciever // need to be update after sending 
    }

    //To send any amount of coins to an existing address
    //To ment new coins

    error inSufficientBalance(uint requested, uint available); //amount requested and amount available
    function send(address reciever,uint amount) public{
        //require to be amount is greater than x

        if(amount > balances[msg.sender]) //balances of sender
        revert inSufficientBalance({            //it stops this transaction from happening and provide the information regarding transaction
        requested : amount,
        available : balances[msg.sender]
        });
        balances[msg.sender] -= amount; //updating balance person who is sending
        balances[reciever] += amount; //reciever acc
        emit Sent(msg.sender,reciever,amount);   //Always when we create event we need to emit that event (mandatory)
    }
      
}
