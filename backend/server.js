const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());

app.use(bodyParser.json({ limit: '10mb' })); 
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'sistema_validacao_produtos'
});

// Conectar ao banco de dados
db.connect((err) => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        return;
    }
    console.log('Conectado ao banco de dados MySQL');
});

// Criar categoria
app.post('/categorias', (req, res) => {
    const { nome } = req.body;
    if (!nome) {
        return res.status(400).send({ error: 'O nome da categoria é obrigatório.' });
    }
    db.query('INSERT INTO categorias (nome) VALUES (?)', [nome], (err, result) => {
        if (err) {
            return res.status(500).send({ error: 'Erro ao adicionar categoria' });
        }
        res.send({ id: result.insertId, nome });
    });
});

// Listar categorias
app.get('/categorias', (req, res) => {
    db.query('SELECT * FROM categorias', (err, results) => {
        if (err) {
            return res.status(500).send({ error: 'Erro ao listar categorias' });
        }
        res.send(results);
    });
});

// Criar marca
app.post('/marcas', (req, res) => {
    const { nome } = req.body;
    if (!nome) {
        return res.status(400).send({ error: 'O nome da marca é obrigatório.' });
    }
    db.query('INSERT INTO marcas (nome) VALUES (?)', [nome], (err, result) => {
        if (err) {
            return res.status(500).send({ error: 'Erro ao adicionar marca' });
        }
        res.send({ id: result.insertId, nome });
    });
});

// Listar marcas
app.get('/marcas', (req, res) => {
    db.query('SELECT * FROM marcas', (err, results) => {
        if (err) {
            return res.status(500).send({ error: 'Erro ao listar marcas' });
        }
        res.send(results);
    });
});



// Criar loja
app.post('/lojas', (req, res) => {
    const { nome } = req.body;
    if (!nome) {
        return res.status(400).send({ error: 'O nome da loja é obrigatório.' });
    }
    db.query('INSERT INTO lojas (nome) VALUES (?)', [nome], (err, result) => {
        if (err) {
            return res.status(500).send({ error: 'Erro ao adicionar loja' });
        }
        res.send({ id: result.insertId, nome });
    });
});

// Listar loja
app.get('/lojas', (req, res) => {
    db.query('SELECT * FROM lojas', (err, results) => {
        if (err) {
            return res.status(500).send({ error: 'Erro ao listar lojas' });
        }
        res.send(results);
    });
});
// Editar loja
app.put('/lojas/:id', (req, res) => {
    const { id } = req.params;
    const { nome } = req.body;
  
    if (!nome) {
      return res.status(400).send({ error: 'O nome da loja é obrigatório.' });
    }
  
    db.query('UPDATE lojas SET nome = ? WHERE id = ?', [nome, id], (err, result) => {
      if (err) {
        return res.status(500).send({ error: 'Erro ao editar loja' });
      }
      if (result.affectedRows === 0) {
        return res.status(404).send({ error: 'Loja não encontrada' });
      }
      res.send({ id: id, nome: nome });
    });
  });
  
  // Excluir loja
  app.delete('/lojas/:id', (req, res) => {
    const { id } = req.params;
    
    db.query('DELETE FROM lojas WHERE id = ?', [id], (err, result) => {
      if (err) {
        return res.status(500).send({ error: 'Erro ao excluir loja' });
      }
      if (result.affectedRows === 0) {
        return res.status(404).send({ error: 'Loja não encontrada' });
      }
      res.send({ message: 'Loja excluída com sucesso' });
    });
  });


app.post('/produtos', (req, res) => {
    const { nome, categoria_id, marca_id, loja_id, preco, quantidade, lote, data_vencimento, imagem } = req.body;

    if (!nome || !quantidade || !data_vencimento) {
        return res.status(400).send({ error: 'Nome, quantidade e data de vencimento são obrigatórios.' });
    }

    console.log('Dados recebidos:', req.body);

    const categoriaId = parseInt(categoria_id) || null;
    const marcaId = parseInt(marca_id) || null;
    const lojaId = parseInt(loja_id) || null;

  
    db.query(
        'INSERT INTO produtos (nome, categoria_id, marca_id, loja_id, preco, quantidade, lote, data_vencimento, imagem) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
            nome,
            categoriaId, 
            marcaId, 
            lojaId, 
            preco || 0, 
            quantidade || 0, 
            lote || null, 
            data_vencimento,
            imagem 
        ],
        (err, result) => {
            if (err) {
                console.error('Erro ao inserir produto:', err); 
                return res.status(500).send({ error: 'Erro ao adicionar produto' });
            }

            res.send({ id: result.insertId, nome });
        }
    );
});

// Listar produtos
app.get('/produtos', (req, res) => {
    db.query('SELECT * FROM produtos', (err, results) => {
        if (err) {
            return res.status(500).send({ error: 'Erro ao listar produtos' });
        }
        res.send(results);
    });
});


// Iniciar o servidor
app.listen(3000, () => {
    console.log('Servidor rodando na porta 3000');
});
