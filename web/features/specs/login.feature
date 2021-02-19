#language: pt


Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "max@gmail.com" e "mudar123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenario: Tentar logar
        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input   | senha_input | mensagem_output                  |
            | max@gmail.com | mudar223    | Usuário e/ou senha inválidos.    |
            | max@404.com   | mudar123    | Usuário e/ou senha inválidos.    |
            | max*yahoo.com | mudar123    | Oops. Informe um email válido!   |
            |               | mudar123    | Oops. Informe um email válido!   |
            | max@gmail.com |             | Oops. Informe sua senha secreta! |
