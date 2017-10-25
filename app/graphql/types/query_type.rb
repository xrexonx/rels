Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :article do
    type Types::ArticleType
    argument :id, !types.ID
    description 'Find a Article by ID'
    resolve -> (obj, args, ctx) {
      Article.find(args[:id])
    }
  end

  field :articles, types[Types::ArticleType] do
    description 'Find all Articles'
    resolve -> () {
      Article.all
    }
  end
end
