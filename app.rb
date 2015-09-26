Cuba.define do
  on root do
    res.write "Yes, it works"
  end

  on post do
    on 'users' do
      outcome = CreateUser.run(req.params)
      if outcome.valid?
        binding.pry
        res.status = 200
        res.write({ user: outcome.result.to_json })
      else
        res.status = 500
        res.write({ user: { errors: outcome.errors.messages } })
      end
    end
  end

  on put do
    on 'users/:id/confirm' do |id|
      outcome = ConfirmUser.run(id: id)

      if outcome.valid?
        res.status = 200
      else
        res.status = 500
        res.write({ user: { errors: outcome.errors.messages } })
      end
    end
  end
end
