// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
/**
 * @title will
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script will.sol
 */
 
 contract Will{
     address owner;
     uint fortune;
     bool deceased;
 
    constructor() payable {
        owner = msg.sender;   //msg sender represents address that is being called(msg is a global variable from solidity)
        fortune = msg.value;    // msg value tells us how much ether is being sent 
        deceased = false;
    }

    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    //create modifier so that we only allocates funds if friends gramps deceased
     modifier mustBeDeceased{
         require(deceased == true); 
         _;
     }
     //create a list to store the wallet addresses of those who are will be inheriting 
     // [1] list of family wallets
     address payable [] familyWallets; //[[error]]; 
    
    //Mapping to keep track of which addresses what aand who gets so by creating keystore of value in solidity..mapping through inheritance
    //[2] map through inheritance ---map addresses (keystore values) -- inheritance for all the addresses
    mapping(address => uint) inheritance;
    function setInheritance(address payable wallet, uint amount) public onlyOwner{
        // [3] To add wallets to the family wallets use .push
        familyWallets.push(wallet);
        inheritance[wallet] = amount; //apply inheritence to the wallet so it can loop through for the all the amounts
    }
    //To atomate the payments --pay each family member on their wallet address -- and insert modifier because cant able to pay before the owner decesed
    function payout() private mustBeDeceased  //restricted only owner should use
    {
    //with a forloop you can loop through things and set conditions
    for(uint i=0;i<familyWallets.length; i++)
    {
        //transfer amount to each wallet
        //transfering the funds from contract address to reciever address
        familyWallets[i].transfer(inheritance[familyWallets[i]]); //transfer always takes arguments [[error]]
        //for each index we are transfering funds through inheritance
    } 
    }
    // oracle switch simulation 
    function hasDeceased() public onlyOwner{
        if(deceased == true)
        //deceased = true;
        payout();
    }
 }
