# cvp

Gerenciamento de validação de produtos de Lojas em Flutter 
## Principais Funcionalidades:

* Cadastro de Lojas: Os usuários podem adicionar novas lojas facilmente através de um formulário intuitivo.
* Edição e Exclusão: Com um simples toque, é possível editar ou excluir lojas, garantindo flexibilidade no gerenciamento.
* Listagem Dinâmica: As lojas são exibidas em uma lista interativa, permitindo a navegação rápida e fácil.
* Integração com API: O projeto se comunica com um backend em Node.js, garantindo que todas as operações de CRUD sejam realizadas de forma eficiente.


# CVP - Sistema de Gerenciamento de Validação de Produtos em Flutter

O **CVP** é uma aplicação desenvolvida em Flutter que permite o gerenciamento eficiente da validação de produtos em lojas. Com uma interface intuitiva e funcionalidades robustas, o sistema facilita a administração de lojas e produtos.

## Principais Funcionalidades

- **Cadastro de Lojas**: Adicione novas lojas facilmente por meio de um formulário amigável.
- **Edição e Exclusão**: Edite ou exclua lojas com um simples toque, garantindo flexibilidade na gestão.
- **Listagem Dinâmica**: Navegue rapidamente por uma lista interativa de lojas.
- **Integração com API**: O projeto se comunica com um backend em Node.js, permitindo que todas as operações de CRUD sejam realizadas de maneira eficiente.

## Estrutura do Banco de Dados

O sistema utiliza um banco de dados MySQL com a seguinte estrutura:

### Criar Banco de Dados

```sql
-- Criar Banco de Dados
CREATE DATABASE sistema_validacao_produtos;
USE sistema_validacao_produtos;

-- Criar Tabela de Categorias
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criar Tabela de Marcas
CREATE TABLE marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criar Tabela de Lojas
CREATE TABLE lojas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria_id INT DEFAULT NULL,
    marca_id INT DEFAULT NULL,
    loja_id INT DEFAULT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL,
    lote VARCHAR(100),
    data_vencimento DATE,
    imagem LONGTEXT,  -- Adicionando a coluna para a imagem em base64
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL,
    FOREIGN KEY (marca_id) REFERENCES marcas(id) ON DELETE SET NULL,
    FOREIGN KEY (loja_id) REFERENCES lojas(id) ON DELETE SET NULL
);


select * from categorias;
select * from marcas;
select * from lojas;
select * from produtos;


```