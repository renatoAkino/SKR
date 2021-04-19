# App de Empreendimentos SKR

Desafio de Desenvolvimento para a vaga de Desenvolvedor Mobile

## Sobre

O projeto é divido em dois arquivos principais, um backend escrito em NodeJS com banco em MySQL que serve uma API REST e um App em Flutter que consome e apresenta os dados.


## Requisitos 

* Node 8
* Git
* Flutter 1.22
* Dart
* Xampp/Lampp


## Instalação

Passo 1:

Clonando o repositório e dependências:

git clone https://github.com/renatoAkino/SKR


Passo 2:

Criando e populando o banco de dados:

* Inicialize o XAMPP

* Abra o painel do PhpMyAdmin em: [http://localhost/phpmyadmin/](http://localhost/phpmyadmin/) 

* Crie uma nova base de dados com o nome: 
skr


* Popule o banco criado importando o arquivo 
database.SQL
  localizado na pasta 
/database
 do projeto

Passo 3:

Rodando o servidor

cd server


npm install


node server.js


O projeto deve rodar em: [http://localhost/:3000](http//localhost:3000) 

Passo 4:

Abra o local do App

cd ..
cd app_skr


Passo 5:

Instale as bibliotecas e dependências do aplicativo: 

flutter pub get


Abra o emulador através do Android Studio ou VSCode e execute:

flutter run


## Funcionalidades:

* Home
* Details Screen

## Client

Telas

<table>
  <tr>
    <td><img src="assets/images/Screenshot_1.png" width=270 height=520></td>
    <td><img src="assets/images/Screenshot_2.png" width=270 height=520></td>
  </tr>
  <tr>
    <td><img src="assets/images/Screenshot_3.png" width=270 height=520></td>
    <td><img src="assets/images/Screenshot_4.png" width=270 height=520></td>
  </tr>
 </table>
