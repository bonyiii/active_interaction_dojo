Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :email
      String :name
      DateTime :confirmed_at


      DateTime :created_at
      DateTime :updated_at
    end
  end
end
