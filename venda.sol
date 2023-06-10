// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 0xE837B31e1D0E3DBaC150D2D5DA9DB22c3B7ca361

contract Venda {

    string public nomeVendedor;
    uint256 public bonusFator;

    constructor(string memory vendedor, uint256 fator) {
        nomeVendedor = vendedor;
        bonusFator = fator;
    }

   function calcularBonus( uint256 valorVenda) 
        public view returns ( uint256 retornoValor) 
    {
        retornoValor = (valorVenda*bonusFator);
        return retornoValor;
    }

}
