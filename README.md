# TODO
Setup GraphQL API with Rails

### Clone and install dependencies
```sh
$ git clone https://github.com/xrexonx/rels.git && bundle install
```
### Setup models
```sh
$ rails g model Article title:string text:text
$ rails g model Comment commenter:string body:text article:references
$ rails db:migrate
```

### Serve
```sh
$ rails s
$ open http://localhost:3000/graphiql
```

### Sample Mutation
Add article `app/graphql/types/mutation_type.rb`
```ruby
  field :addArticle, Types::ArticleType do
    description 'Add Article'
    argument :article, Types::PostInputType
    resolve -> (obj, args, c) {
      post = Article.new(args['article'].to_h)
      post.save
      post
    }
  end
```
The mutation query would look like:
```
mutation {
  addArticle (article: {
    title: "Hello Graphql",
    text: "My graphql post"
  }) {
    id
    title
    text
  }
}
```

Edit article `app/graphql/types/mutation_type.rb`
```ruby
  field :editArticle, Types::ArticleType do
    description 'Edit article'
    argument :id, !types.Int
    argument :title, types.String
    # more argument here..

    resolve -> (obj, args, c) {
      Article.update(args[:id], :title => args[:title])
    }
  end
```
The mutation query would look like:
```
mutation {
  editArticle (id: 1, title: "Rexon") {
    title
  }
}
```

### Sample Queries
Query all articles `app/graphql/types/query_type.rb`
```ruby
  field :articles, types[Types::ArticleType] do
    description 'Find all Articles'
    resolve -> (obj, args, ctx) {
      Article.all
    }
  end
```
The query would look like:
```
query {
  articles {
    title
    text
  }
}
```

Query article by id `app/graphql/types/query_type.rb`
```ruby
  field :article do
    type Types::ArticleType
    argument :id, !types.ID
    description 'Find a Article by ID'
    resolve -> (obj, args, ctx) {
      Article.find(args[:id])
    }
  end
```
The query would look like:
```
query {
  article (id: 1) {
    id
    title
    text
    comments {
      id
      body
      commenter
      created_at
    }
  }
}
```