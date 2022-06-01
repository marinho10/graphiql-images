Article: Absinthe don't support list of upload as argument

Normalmente como backender trabalho com a disponibilização de API's em REST ou em Graphiql,
no desenvolvimento de um API Graphiql utilizando Absinthe surgiu uma feature para associação de uma galeria de imagens a uma entidade...

Feature:

Imaginemos a entidade Utilizador e queremos ter associado uma list de imagens quando criamos/atualizamos um utilizador.

---

Wrong Solution:

Adicionar array de imagens ao Utilizador e na criação/edição de Utilizador ter um array de upload de imagens.

---

Database

antes:
tabela Utilizador
id
email
surname
name

depois:
tabela Utilizador
id
email
surname
name
gallery (array de images)

---

Graphql schema

antes
input_object :user_input do
field :name, non_null(:string)
field :surname, non_null(:string)
field :email, non_null(:string)
field :name, non_null(:upload)
end

depois
input_object :user_input do
field :name, non_null(:string)
field :surname, non_null(:string)
field :email, non_null(:string)
field :name, non_null(:upload)
field :gallery, list_of(non_null(:upload)) !! NOT SUPPORTED BY ABSINTHE
end

---

E por final no resolver e consequentemente no contexto trataria as imagens...

Problema:
https://github.com/absinthe-graphql/absinthe_plug/pull/201

!!!!!Absinthe don't support list of upload as argument!!!

---

Solution:

Adicionar tabela de imagens e disponiblizar endpoint para adicionar imagens. Possibilitar associar
as imagens a um utilizador com uma relação de 1:N.

---

Database
tabela user
id
email
surname
name

tabela user_gallery
id
image
user_id

---

Graphql schema - user

antes
input_object :user_input do
field :name, non_null(:string)
field :surname, non_null(:string)
field :email, non_null(:string)
field :name, non_null(:upload)
end

depois
input_object :user_input do
field :name, non_null(:string)
field :surname, non_null(:string)
field :email, non_null(:string)
field :name, non_null(:upload)
field :gallery, list_of(non_null(:id))
end

---

Graphql schema - user_gallery_image

object(:user_gallery_image) do
field(:id, non_null(:id))
field(:gallery_image, non_null(:file_image)) do
resolve(&GeneralResolver.gallery_image/3)
end
field(:user_id, :id)
end

object(:user_gallery_image_mutations) do
field(:user_gallery_image_create, :user_gallery_image) do
arg(:gallery_image, non_null(:upload))
resolve(&UserGalleryImageResolver.user_gallery_image_create/2)
end
end

Assim adicionamos e removemos imagens a tabela de user_gallery e é nos devolvido um identificador para a imagem.
Com esse identificador podemos associar a imagem a um utilizador passando no field gallery no objecto de
input do utilizador.

Também foi necessário criar um processo de limpeza de imagens não usadas para precaver a possivel perda de
identificadores e refresh da pagina. Este processo limpa todas as imagens sem utilizador associado adicionadas
a mais de 2 dias.

Esta solução está disponivel neste repositório para poderem perceber melhor o funcionamento.
