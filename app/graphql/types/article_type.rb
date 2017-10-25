Types::ArticleType = GraphQL::ObjectType.define do
  name 'Article'
  field :id, types.String
  field :title, types.String
  field :text, types.String
  field :comments, types[Types::CommentType]
end
