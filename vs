const Discord = require('discord.js');
const client = new Discord.Client();
const fetch = require('node-fetch');

// Define o prefixo de comando do bot
const prefix = '!';

// Define a chave de acesso à API do OpenAI
const apiKey = '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';

client.on('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);
});

client.on('message', async message => {
  // Verifica se o autor da mensagem é o bot
  if (message.author.bot) return;

  // Verifica se a mensagem começa com o prefixo definido
  if (message.content.startsWith(prefix)) {
    // Separa o comando e os argumentos
    const args = message.content.slice(prefix.length).trim().split(/ +/);
    const command = args.shift().toLowerCase();

    // Gera uma resposta utilizando a API do OpenAI
    if (command === 'chat') {
      // Junta os argumentos em uma única string
      const text = args.join(' ');

      // Faz uma chamada para a API do OpenAI
      const response = await fetch('https://api.openai.com/v1/engines/davinci-codex/completions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${apiKey}`
        },
        body: JSON.stringify({
          prompt: `Chat with me:\n${text}\nBot:`,
          max_tokens: 50,
          n: 1,
          stop: 'Bot:'
        })
      });

      // Extrai a resposta gerada pela API
      const { choices } = await response.json();
      const answer = choices[0].text.trim();

      // Envia a resposta para o canal onde a mensagem foi enviada
      message.channel.send(answer);
    }
  }
});

client.login('seu_token_aqui');
