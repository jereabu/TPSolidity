
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Colegio {

    // Declaramos variables
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => uint8) private notas_materia;
    string[] private _nom_materias;

    //Creamos constructor
    constructor(string memory nombre_, string memory apellido_, string memory curso_) {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }

    //Devuelve el apellido del alumno
    function getapellido() public view returns (string memory) {
        return _apellido;
    }
    // Append-eamos el nombre completo
    function AppendString(string memory a, string memory b, string memory c) public pure returns (string memory) {
        return string(abi.encodePacked(a,b,c));
    }


    //Devuelve el nombre completo del alumno
    function getnombre_completo() public view returns (string memory) {
        return AppendString(_nombre, " ", _apellido);
    }

    //Devuelve el curso del alumno
    function getcurso() public view returns (string memory) {
        return _curso;
    }

    //Le permite AL DOCENTE poner la nota a una materia
    function set_nota_materia(uint8 _nota, string memory _materia) public {
        require(_docente == msg.sender, "No estas autorizado a cambiar tu propia nota.");
        require(_nota <= 100 && _nota >= 1, "No es una nota valida");
        notas_materia[_materia] = _nota;
        _nom_materias.push(_materia);
    }

    //Devuelve la nota dependiendo la materia
    function getnota_materia(string memory _materia) public view returns (uint) {
        uint _nota = notas_materia[_materia];   
        return _nota;
    }
    
    //Se fija si la nota de una cierta materia es mayor o igual a 60, devuelve true o false
    function getaprobo(string memory _materia) public view returns (bool) {
        if (notas_materia[_materia] >= 60){
            return true;
        } else {
            return false;
        }
       
    }

    function getpromedio() public view returns (uint) {

        uint _cantItems = _nom_materias.length;
        uint _notaParaPromedio;
        uint _notaFinal;

        for (uint i = 0; i < _cantItems; i++){
            _notaParaPromedio += notas_materia[_nom_materias[i]];
        }

        _notaFinal = _notaParaPromedio / _cantItems;
        return _notaFinal;
    
    }
}
