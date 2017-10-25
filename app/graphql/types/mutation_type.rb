Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :editArticle, Types::ArticleType do
    description 'Edit article'
    argument :id, !types.Int
    argument :title, types.String

    resolve -> (obj, args, c) {
      puts obj.errors.full_messages
      @post = Article.find(args[:id])
      puts @post.inspect
      # post = post.title(args[:title])
      # post
    }
  end

  field :addArticle, Types::ArticleType do
    description 'Add Article'
    argument :article, Types::PostInputType

    resolve -> (obj, args, c) {
      post = Article.new(args['article'].to_h)
      post.save
      post
    }
  end
end
