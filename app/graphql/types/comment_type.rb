Types::CommentType = GraphQL::ObjectType.define do
  name "Comment"
  field :id, !types.ID
  field :body, !types.String
  field :commenter, types.String
  field :created_at, !types.String
end