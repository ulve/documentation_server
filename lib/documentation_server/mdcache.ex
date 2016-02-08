defmodule DocumentationServer.Mdcache do
   use GenServer

   # External api

   def start_link(root) do
      GenServer.start_link(__MODULE__, {root, read_all(root)}, name: __MODULE__)
   end

   def find_all do
      GenServer.call __MODULE__, :find_all
   end

   def update_index do
      GenServer.call __MODULE__, :update_index
   end

   # GenServer implementation

   def handle_call(:find_all, _from, {root, cache}) do
      {:reply, cache, {root, cache} }
   end

   def handle_call(:update_index, _from, {root, _cache}) do
      new_cache = read_all(root)
      {:reply, new_cache, {root, new_cache}}
   end

   # Private functions
   
   defp read_all(root) do
      wildcard_expression = root <> "/**/*.md"
      {:reply, Path.wildcard(wildcard_expression) |> Enum.map(&read_md/1)}
   end

   defp read_md(path) do
     {path, File.read!(path)}
   end
end
