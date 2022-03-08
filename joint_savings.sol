
//Joint Savings Account

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Define variables
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;


    
    // Define a withdraw function with two arguments: amount and recipient

    function withdraw(uint amount, address payable recipient) public {

        
        // Require that recipient is either `accountOne` or `accountTwo`. 
        
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        
        // Require that the `balance` is sufficient to accomplish the withdraw operation.
        
        require(contractBalance >= lastWithdrawAmount, "Insufficient funds!");

        /*
        Add and `if` statement to check if the `lastToWithdraw` is not equal to `recipient` 
        If `lastToWithdraw` is not equal, then set it to the current value of `recipient`.
        */
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        } 

        // Transfer the amount to the recipient
        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        // Call the `contractBalance` variable and set it equal to the balance of the contract to reflect the new balance of the contract.
        contractBalance = address(this).balance;
    }

    // Deposit function.
    function deposit() public payable {

        
        // Update contract balance
        
        contractBalance = address(this).balance;
    }

    
    //Function to set the addresses of payable accounts
    function setAccounts(address payable account1, address payable account2) public{

        accountOne = account1;
        accountTwo = account2;
    }

    
    // default fallback function so the contract can store Ether sent from outside the deposit function.
    
    function() external payable {}
}