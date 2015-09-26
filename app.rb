Cuba.define do
  on root do
    res.write "Yes, it works"
  end

  on post do
    on 'users' do
      outcome = CreateUser.run(name: req.params['name'], email: req.params['email'])
      if outcome.valid?
        res.status = 200
      else
        res.status = 500
        res.write({ user: { errors: outcome.errors } })
      end
    end
  end
end
