// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ContratoAluguel {

    string public locator;
    string public locatario;
    uint256[] public valorAluguel;

    constructor(string memory _locator, string memory _locatario,uint valorInicial) {
        locator = _locator;
        locatario = _locatario;
        for(uint i = 0 ; i < 36; i ++){
            addToArray(valorInicial);
        }
    }

    function addParcelas(uint256 val) public view returns (bool) {
        for (uint256 i; i < 36; i ++) {
            addParcelas(val);
        }
        return true;        
    }

    function addToArray(uint256 newItem) public {
        valorAluguel.push(newItem);
    }

    function reajustarParcelas(uint256  mes) public returns (bool) {
        for (uint256 i; i < valorAluguel.length; i ++) {
            if (i>mes) {
                addToParcelaArray(mes);
            }
        }
        return true;

    }

    function addToParcelaArray(uint256 mes) private {
        uint val = valorAluguel[mes];
        valorAluguel[mes] = (val+100);
    }

    function retornaParcelaMes(uint256 mes) public view returns (uint) {
        uint256 valor = valorAluguel[mes];
        return valor; 
    }

    function retornaNomeLocatorOuLocatario (uint256 tipo) public view returns (string memory nome) {
        if (tipo==1) {
            nome = locator;
            return nome;
        } else if (tipo == 2) {
            nome = locatario;
            return nome;
        } else {
            nome = "tipo invalido";
            return nome;
        }
        
    }

}
