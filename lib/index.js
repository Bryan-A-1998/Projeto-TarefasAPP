const express = require('express');
const multer = require('multer');
const path = require('path');
const { Sequelize, DataTypes } = require('sequelize');
const cron = require('node-cron');
const cors = require('cors');

const app = express();
app.use(cors({
    origin: '*', allowedHeaders: '*', methods: '*',
}));


// Configuração do banco de dados MySQL
const sequelize = new Sequelize('tarefas_db', 'root', '', {
    host: 'localhost',
    dialect: 'mysql'
});

const Tarefa = sequelize.define('Tarefa', {
    titulo: { type: DataTypes.STRING, allowNull: false },
    descricao: { type: DataTypes.TEXT, allowNull: true },
    data_hora: { type: DataTypes.DATE, allowNull: false },
    foto: { type: DataTypes.STRING, allowNull: true }
});

app.use(express.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Configuração do multer para upload de imagens
const storage = multer.diskStorage({
    destination: 'uploads/',
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}_${file.originalname}`);
    }
});
const upload = multer({ storage });

// Rotas
app.post('/tarefas', upload.single('foto'), async (req, res) => {
    try {
        const { titulo, descricao, data_hora } = req.body;
        const novaTarefa = await Tarefa.create({
            titulo,
            descricao,
            data_hora,
            foto: req.file ? `/uploads/${req.file.filename}` : null
        });
        res.status(201).json(novaTarefa);
    } catch (error) {
        res.status(500).json({ erro: 'Erro ao criar tarefa' });
    }
});

app.get('/tarefas', async (req, res) => {
    const tarefas = await Tarefa.findAll();
    res.json(tarefas);
});

app.put('/tarefas/:id', async (req, res) => {
    const { id } = req.params;
    const { titulo, descricao, data_hora } = req.body;
    await Tarefa.update({ titulo, descricao, horario }, { where: { id } });
    res.json({ mensagem: 'Tarefa atualizada' });
});

app.delete('/tarefas/:id', async (req, res) => {
    const { id } = req.params;
    await Tarefa.destroy({ where: { id } });
    res.json({ mensagem: 'Tarefa excluída' });
});

// Verificação de lembretes a cada minuto
cron.schedule('* * * * *', async () => {
    const agora = new Date();
    const duasHorasDepois = new Date(agora.getTime() + 2 * 60 * 60 * 1000);
    const tarefas = await Tarefa.findAll({ where: { data_hora: duasHorasDepois } });
    tarefas.forEach(tarefa => {
        console.log(`Lembrete: Tarefa "${tarefa.titulo}" está marcada para daqui a 2 horas!`);
    });
});

// Iniciar servidor
(async () => {
    await sequelize.sync();
    app.listen(3000, () => console.log('Servidor rodando na porta 3000'));
})();
