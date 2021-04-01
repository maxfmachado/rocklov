#language: pt

Funcionalidade: Receber pedido de locação

    Sendo um anuciante que possiu equipamentos cadastrados
    Desejo receber pedidos de locação
    Para que eu possa decidir se quero aprová-los ou rejeitá-los

    Cenario: Receber pedido
        Dado que meu perfil de anunciante é "joao@anunciante.com" e "mudar123"
            E que tenho o seguinte equipamento cadastrado:
            | thumb     | trompete.jpg |
            | nome      | Trompete     |
            | categoria | Outros       |
            | preco     | 100          |
            E acesso o meu Dashboard

        Quando "maria@locataria.com" e "mudar123" solicita a locação de equipo
        Entao devo ver a seguinte mensagem:
            """
            maria@locataria.com deseja alugar o equipamento: Trompete em: DATA_ATUAL
            """
            E devo ver os links: "ACEITAR" e "REJEITAR" no pedido
