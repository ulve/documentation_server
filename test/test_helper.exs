ExUnit.start

#Mix.Task.run "ecto.create", ~w(-r DocumentationServer.Repo --quiet)
#Mix.Task.run "ecto.migrate", ~w(-r DocumentationServer.Repo --quiet)
#Ecto.Adapters.SQL.begin_test_transaction(DocumentationServer.Repo)
