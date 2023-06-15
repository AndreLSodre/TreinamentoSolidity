// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
// 0xe58F459dD138Da6D338d04Dd0D6B2D01648f2672
contract Ownable {
    address public owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Somente o proprietario pode realizar esta acao");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

} 

contract ContratoAluguel is Ownable {

    mapping(bytes32 => Contrato) public contratos;
    uint256 public totalDeContrato;

    struct Contrato {
        bytes32 chaveContrato;
        string locator;
        string locatario;
        uint256[] valorAluguel;
    }

     function mudarDonoDoContrato(address _owner) public onlyOwner returns (bool) {
        owner = _owner;
        return true;
    }

    modifier somenteContrato( string memory _locator, string memory _locatario, uint256 _valorParcela) {
        require(bytes(_locator).length > 0, "Insira o nome do Locador");
        require(bytes(_locatario).length > 0, "Insira o nome do Locatario");
        require(_valorParcela > 0, "Insira um valor valido na parcela");
        _;
    }

     modifier validarContrato( string memory _locator, string memory _locatario) {
        require(bytes(_locator).length > 0, "Insira o nome do Locador");
        require(bytes(_locatario).length > 0, "Insira o nome do Locatario");
        _;
    }

    modifier validarMes(uint _mes) {
        require(_mes > 0, "valor da parcela deve ser entre 1 e 36");
        require(_mes < 37, "valor da parcela deve ser entre 1 e 36");
        _;
    }

    modifier validarParcela(uint _parcelaContrato) {
        require(_parcelaContrato > 0, "numero do contrato invalido");
        require(_parcelaContrato <= totalDeContrato, "numero do contrato invalido");
        _;
    }

    constructor(string memory _locator, string memory _locatario, uint256 _valorParcela) {
        uint256[] memory parcelas = addParcelas(
            _valorParcela
        );
        bytes32 _chaveContrato = keccak256(bytes(string.concat(_locator, _locatario)));
        Contrato memory novoContrato = Contrato(_chaveContrato,_locator, _locatario, parcelas);
        contratos[_chaveContrato] = novoContrato;
        totalDeContrato++;
    }

    function incluirContrato(string memory _locator, string memory _locatario, uint256 _valorParcela) 
        public somenteContrato(_locator, _locatario, _valorParcela)
        returns (bool) {
        uint256[] memory parcelas = addParcelas(
            _valorParcela
        );
        bytes32 _chaveContrato = keccak256(bytes(string.concat(_locator, _locatario)));
        Contrato memory novoContrato = Contrato(_chaveContrato, _locator, _locatario, parcelas);
        contratos[_chaveContrato] = novoContrato;
        totalDeContrato++;

        return true;
    }

    function addParcelas(uint256 valor)
        private pure returns (uint256[] memory parcelas)
    {
        uint numParcela = 36;
        uint256[] memory _valorAluguel = new uint256[](numParcela);
        for (uint256 i = 0; i < numParcela; i++) {
            _valorAluguel[i] = valor;
        }
        return _valorAluguel;
    }

    function reajustarParcelas(uint256 mes, string memory _locator, string memory _locatario) public validarMes(mes) validarContrato(_locator,_locatario) returns (bool) {
        bytes32 _chaveContrato = keccak256(bytes(string.concat(_locator, _locatario)));
        uint count = contratos[_chaveContrato].valorAluguel.length;
        mes -1;
        for (mes; mes < count; mes++) {
            uint valor = contratos[_chaveContrato].valorAluguel[mes];
            contratos[_chaveContrato].valorAluguel[mes] = (valor + 100);
        }
        return true;
    }

    function retornaParcelaMes(uint256 mes, string memory _locator, string memory _locatario) public validarMes(mes) validarContrato(_locator,_locatario) view returns (uint256) {
        bytes32 _chaveContrato = keccak256(bytes(string.concat(_locator, _locatario)));
        uint256 valor = contratos[_chaveContrato].valorAluguel[(mes-1)];
        return valor;
    }

    function retornaNomeLocatorOuLocatario(uint256 tipo, string memory novoNome, string memory _locator, string memory _locatario)
        public
        validarContrato(_locator,_locatario)
        returns (string memory)
    {
        require(bytes(novoNome).length > 0, "Insira o nome do Locatario");
        require(tipo !=1 && tipo !=2 , "tipo invalido digiti 1 para Locator e 2 para Locatario");
        bytes32 _chaveContrato = keccak256(bytes(string.concat(_locator, _locatario)));
        if (tipo == 1) {
            contratos[_chaveContrato].locator = novoNome;
            return contratos[_chaveContrato].locator;
        } else if (tipo == 2) {
            contratos[_chaveContrato].locatario = novoNome;
            return contratos[_chaveContrato].locatario;
        } else {
            return "numero do contrato invalido";
        }
    }
}
