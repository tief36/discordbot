const Discord = require('discord.js');
const { openai } = require('@openai/openai-api');

const client = new Discord.Client();
const openaiApiKey = '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';

const chatGpt = async (message) => {
  const openaiApi = new openai(openaiApiKey);
  const prompt = message.content;
  const response = await openaiApi.completions.create({
    engine: 'davinci',
    prompt,
    maxTokens: 150,
    n: 1,
    stop: '\n',
  });

  return response.choices[0].text;
};

client.on('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);
});

client.on('message', async (message) => {
  if (message.author.bot) return;

  const response = await chatGpt(message);
  message.channel.send(response);
});

client.login('MTA5MDc5NTc4NDA0MTE1NjY3OQ.GwYJJQ.sQQZJQDUIQr61u8oJffBSbn0Y5Bec2h55zIKkw');
