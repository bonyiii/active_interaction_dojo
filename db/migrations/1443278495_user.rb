Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :email
      String :name
      Integer :unconfirmed_tries, default: 0
      DateTime :confirmed_at


      DateTime :created_at
      DateTime :updated_at
    end
  end
end
