Cuba.define do
  on root do
    res.write "Yes, it works"
  end

  on 'wifi/connected' do
    res.status 200
    res.write({ mac: ok })
  end

  on 'users' do

    # First rule match so to create todos it must be before of create user
    on ':id' do |user_id|
      on put do
        on 'confirm' do
          outcome = ConfirmUser.run(id: user_id)

          if outcome.valid?
            res.status = 200
            res.write({ user: { confirmed: true } })
          else
            res.status = 422
            res.write({ user: { errors: outcome.errors.messages } })
          end
        end
      end

      on 'todos' do
        on get do
          outcome = ListTodos.run(user_id: user_id)

          if outcome.valid?
            res.status = 200
            res.write({ todos: outcome.result.to_json })
          else
            res.status = 422
            res.write({ user: { errors: outcome.errors.messages } })
          end
        end

        on post do
          outcome = CreateTodo.run(req.params.merge(user_id: user_id))

          if outcome.valid?
            res.status = 201
            res.write({ todo: outcome.result.to_json })
          else
            res.status = 422
            res.write({ todo: { errors: outcome.errors.messages } })
          end
        end
      end # todos
    end # :id

    on post do
      outcome = CreateUser.run(req.params)

      if outcome.valid?
        res.status = 201
        res.write({ user: outcome.result.to_json })
      else
        res.status = 422
        res.write({ user: { errors: outcome.errors.messages } })
      end
    end

  end # users
end
