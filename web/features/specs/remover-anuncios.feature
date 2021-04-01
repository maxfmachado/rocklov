#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero remover esse anúncio
    para que eu possa manter meu Dashboard atualizado

    Contexto: Login
        * Login com "max@gmail.com" e "mudar123"

    
    Cenario: Remover um anúncio
        Dado que tenho um anúncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | Cordas         |
            | preco     | 50             |

        Quando solicito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu Dashboard


    Cenario: Desistir da exclusão de um anúncio
        Dado que tenho um anúncio indesejado:
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 100       |

        Quando solicito a exclusão desse item
            Mas não confirmo a exclusão
        Então esse item deve continuar no meu Dashboard