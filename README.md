### Descrição do Projeto:

### Análise de Dados do Campeonato Brasileiro Usando Neo4j e Apache Spark

**Tema**: Dados do Campeonato Brasileiro de Futebol.

Áreas de Tecnologia Utilizadas:

- **Apache Spark**: Empregado para o tratamento e processamento dos dados.

- **Banco de Dados NoSQL Orientados à Grafos (Neo4j)**: Utilizado para armazenar e gerenciar os dados do campeonato.


#### Processo Desenvolvido:

Preparação dos Dados:
- Utilização de dois arquivos CSV contendo os dados relevantes do campeonato.
- Processamento desses arquivos usando Apache Spark no Google Colab, em um notebook denominado trabalho_bd3_futebol_spark.ipynb.
- Geração de um arquivo .txt, depois esse arquivo foi renomeado para conter o .cypher, resultado da etapa de processamento de dados, que serve de insumo para a próxima etapa.

População do Banco de Dados NoSQL (Neo4j):

- Utilização do arquivo .cypher gerado na etapa anterior para popular o banco de dados Neo4j.
- Esse passo permite a criação de uma base de dados relacional que reflete as complexidades e as relações inerentes aos dados do campeonato.

Realização de Consultas:
- Execução de consultas variadas no banco de dados Neo4j.
- As consultas estão localizadas nesse arquivo, na seção 'Consultas'.
- Estas consultas permitem extrair insights e análises específicas dos dados do campeonato.

#### Componentes do Grupo:

- Clara Mattos Chagas Lino
- Laryssa Machado Rabelo de Paiva
- Leonardo Filgueiras Mendes Calvet
- Wesley Santos Ferreira
