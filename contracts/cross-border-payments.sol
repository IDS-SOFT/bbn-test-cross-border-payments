// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CrossBorderPayment {
    address public sender;
    address public recipient;
    IERC20 public token;
    uint256 public amount;

    enum PaymentState { Created, Completed, Cancelled }
    PaymentState public state;

    event PaymentCreated(address indexed sender, address indexed recipient, uint256 amount);
    event PaymentCompleted(address indexed sender, address indexed recipient, uint256 amount);
    event PaymentCancelled(address indexed sender, address indexed recipient, uint256 amount);
    event CheckBalance(string text, uint amount);

    //Uncomment the constructor and feed necessary arguments in scripts/deploy.ts, to deploy the contract.

    constructor(
        address _recipient,
        address _tokenAddress,
        uint256 _amount
    ) {
        sender = msg.sender;
        recipient = _recipient;
        token = IERC20(_tokenAddress);
        amount = _amount;
        state = PaymentState.Created;

        emit PaymentCreated(sender, recipient, amount);
    }

    function completePayment() external {
        require(msg.sender == sender, "Only the sender can complete the payment");
        require(state == PaymentState.Created, "Payment has already been completed or cancelled");

        token.transfer(recipient, amount);
        state = PaymentState.Completed;

        emit PaymentCompleted(sender, recipient, amount);
    }

    function cancelPayment() external {
        require(msg.sender == sender, "Only the sender can cancel the payment");
        require(state == PaymentState.Created, "Payment has already been completed or cancelled");

        token.transfer(sender, amount);
        state = PaymentState.Cancelled;

        emit PaymentCancelled(sender, recipient, amount);
    }
    
    function getBalance(address user_account) external returns (uint){
    
       string memory data = "User Balance is : ";
       uint user_bal = user_account.balance;
       emit CheckBalance(data, user_bal );
       return (user_bal);

    }
}
