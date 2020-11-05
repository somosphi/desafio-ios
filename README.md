# Desafio iOS - Phi
---
![Banner Phi](assets/20200826084504887_picture.jpg)

## Olá, ficamos felizes por você participar do nosso desafio iOS!

---

## Como será seu desafio

Utilizando a nossa [API](https://desafio-ios-phi-bff.herokuapp.com/), você deverá criar uma app que apresente o saldo e as movimentações financeiras de um usuário, uma tela com os detalhes da movimentação selecionada e a opção de compartilhamento do mesmo. O layout deverá ser semelhante ao apresentado neste `README`. Legal, certo?

Pense no desafio como uma oportunidade de mostrar todo o seu conhecimento. Faça-o com calma! Você pode combinar o tempo com nosso time de RH!
Vamos avaliar como você lida com as seguintes situações:

- Consumo de APIs;
- Construção de Layout a partir de um modelo de tela;
- Persistência de dados (Ocultar saldo);
- Estruturação de layout;
- Lógicas de apresentação de variações de layout;
- Fluxo da aplicação.

Os pré-requisitos são: 

1. que o código seja feito em Swift, de preferência na versão mais atual, dando suporte a iOS 13.0.0+.
1. que você siga nossa [Style Guide](https://github.com/somosphi/style-guides/blob/master/swift.md). 

Fora isso, sinta-se a vontade para:

- Usar ou não usar bibliotecas;
- Estruturar seu layout com storyboards, xibs ou ViewCode;
- Adotar a arquitetura que você quiser.

Nos preocupamos com qualidade e acreditamos bastante em testes automatizados. Entretanto, sabemos que não é um tópico dominado por todos, por isso aceitamos desafios com todos os perfis e diferentes momentos de experiência e conhecimento técnico.

Para posições mais Seniors, porém, damos muita importância para a qualidade do código.

---

## Features

* Tratamento de erros e apresentação de: Error generico, loading;
* Buscar saldo da rota `myBalance`;
* Ao tocar no ícone de olho do saldo, o mesmo deve ser escondido e apresentado conforme modelo de tela anexado.
 * 	OBS: Esta flag deverá ser persistida.
* Buscar lista de itens do extrato da rota `myStatement` com paginação de 10 itens por request(scroll infinito);
* Ao tocar em um item do extrato deverá abrir uma tela de detalhes.
* A tela de detalhes deverá consumir a rota de `myStatement/detail` informando o `id` do item selecionado como parâmetro;
* Ao tocar no botão de compartilhar, deverá ser compartilhada a imagem da área de informações do comprovante abrindo a alert padrão do iOS.

---

## Api

[Documentação](https://desafio-ios-phi-bff.herokuapp.com/)

Seu token deve ser enviado no header de todas as requisições como header param `token`

Token: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c`

---

## Layout

![ColorPallet](data:image/jpeg;base64,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0MGuu+46q1y5sku/ZcuWIn716tWzHj16uHvSuXz66afmf0//LVvft27daqtWrbIbbrjB+Vf9+vWdf+zatcvGjRtXYrG33HKL4QOZ/AJ/+OSTT0pMP2bMGOfDcdNnGhMlFpyFi6XxoyiEj3G3Y8cOq1u3rl199dVubPlqwP2bb75x44YxTR9ceOGF/mfbu3evTZ8+3fkVunDs2DE3vm688UZr0aJF0X3+Qyb/2bNnj7388svWqlUru++++3wS9z5lyhT76aefil3jC/7/+OOP/+t6iAtZE9Hff//diRPP8v/yyy82ePBgV1+cBZEbOnSo64y1a9fa22+/bQ8//LA1atTI3nvvPSeOQ4YMccK3ZMkSe/PNNw1nxbi3devWds8999iRI0ds9uzZToxvvfVWO3TokL366qvWrVs3u/baa93vdDwdOGjQIAM+6W+++WZDXPj+4YcfWkFBgV1xxRX21VdfuQ4YOHCg1alTx9atW+fKHj16tDVs2NCVn6uX0vhF1XHmzJlugkAcmGQQY/g98sgjdvTo0Yx8EGD4wGb48OFOhOfNm2czZsxw/cXENXnyZMePCWb37t3uN6ILJismHgYTg/HHH390k2OueFEOEydtwNasWeN8wH35/wsDDh9LtZo1a0b6BffXqFHDHnroodSk7jOCEuVXUemjxsS/Cs3ShdL40c9vvfWWE8YBAwa48fTxxx8b/X7llVe6vp4zZ44bY4yTP/74w9555x174IEHrEmTJk548atrrrnGbr/9didoTOZMTuPHj7eRI0c6nyur/yxbtswFV+vXr7d9+/a5ydojQW/QB8Z7qjHGs2XBRZSZisbRIQBlQBEFLl261M34wOM6swiGEyOEx48fd4McUX3ssceKolbAIwREoAgbQkl0dP7557v0zZo1c4OXL5RJxETk5I0oE+HBEBEG2eWXX+7uY0AxCIi+MKI3otaWLVu678yoRHW+Le5ill+i+GWqI5EfrEaMGOGckqoy03///fduQiDKz8QH52fAMGn4yJNVwBtvvOGEk8mwffv2bnVB3vBjpcBkg4iShjrwR/SXK6Nfic6pHysWVjn4HaLvVz/UBf+hbukW5RfczyAsKS2/xU2faUyQf7Ytih8TIqsxghOMcUH0jggiorx37drVRf3+dyZT+oRVECvRjh07OhF1GZx5oS9YgcKUFSdWFv9h/C5f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)


<img src="assets/iPhone X, XS, 11 Pro – 1.png"
alt="" width="375" height="812" border="1" /> | <img src="assets/iPhone X, XS, 11 Pro – 2.png"
alt="" width="375" height="812" border="1" />

<img src="assets/iPhone X, XS, 11 Pro – 3.png"
alt="" width="375" height="812" border="1" /> | <img src="assets/iPhone X, XS, 11 Pro – 4.png"
alt="Compartilhamento" width="375" height="812" border="1" />

### Imagem a ser compartilhada:

<img src="assets/Compartilhar.png"
alt="Comprovante" width="375" height="562" border="1" />

---

## Processo de submissão

Depois de implementar a solução, envie um Pull Request para este repositório. O processo de Pull Request funciona da seguinte maneira:

Faça um fork deste repositório (não clonar direto!);
Faça seu projeto neste fork;
Commit e suba as alterações para o SEU fork;
Pela interface do Github, envie um Pull Request;
Deixe o fork público para facilitar a inspeção do código.

:exclamation: **ATENÇÃO** :exclamation:

Não tente fazer o PUSH diretamente para ESTE repositório!

## Copyright

Copyright ícones: [zondicons](https://www.iconfinder.com/iconsets/zondicons)