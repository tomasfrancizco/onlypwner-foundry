pragma solidity ^0.8.20;

import {console} from "forge-std/Test.sol";
import {IVault} from "./interfaces/IVault.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract Vault is IVault {
    address public override owner;
    IERC20 public override token;
    mapping(address => uint256) public override shares; // shares por usuario
    uint256 public override totalShares; // shares totales

    constructor(address _token) {
        owner = msg.sender;
        token = IERC20(_token);
    }

    function deposit(uint256 amount) external override { // deposit(10**17) es lo que manda el scripter
        require(amount > 0, "Vault: Amount must be greater than 0");

        uint currentBalance = token.balanceOf(address(this)); // balance del contrato en token
        uint currentShares = totalShares; // total de shares
        console.log("msg.sender...", msg.sender);
        console.log("amount: %s", amount);
        console.log("currentShares: %s", currentShares);
        console.log("currentBalance: %s", currentBalance);

        uint newShares;
        if (currentShares == 0) { // esto no deberia ser... porque es como no haber interactuado, o haber depositado y retirado
            newShares = amount;
        } else {
            newShares = (amount * currentShares) / currentBalance; // como hago para que currentBalance sea MUY GRANDE ?
        }
        //(1 * 10^17) / 10^18 = 0.1
        // Si le transfiero todo al contrato sin depositar...


        console.log("newShares = (amount * currentShares) / currentBalance ........: %s", newShares);

        shares[msg.sender] += newShares; // esto tiene que ser 0
        totalShares += newShares;

        token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 sharesAmount) external override {
        require(sharesAmount > 0, "Vault: Amount must be greater than 0");

        uint currentBalance = token.balanceOf(address(this)); // el total que se fue mandando al contrato
        uint payoutAmount = (sharesAmount * currentBalance) / totalShares; // (input de la funcion / el total de tokens del contrato) / total de shares
        // 1 * 10^17 / 10^17 = 1
        shares[msg.sender] -= sharesAmount;
        totalShares -= sharesAmount;

        if (msg.sender == owner) {
            payoutAmount *= 2;
        }

        token.transfer(msg.sender, payoutAmount); // tendra que exceder el balance del contrato al multiplicarse * 2?
    }
}
