Sequel.migration do
  change do
    create_table(:todos) do
      primary_key :id
      String :body
      String :user_id

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
